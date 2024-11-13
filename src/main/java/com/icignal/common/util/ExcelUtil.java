package com.icignal.common.util;

import static org.apache.commons.lang.StringEscapeUtils.unescapeHtml;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.request.ExcelMergeDto;
import com.icignal.common.base.dto.request.ExcelRowDto;
import com.icignal.common.base.dto.request.ExportExcelReqDto;
import com.icignal.common.base.dto.request.ExportExcelSheetReqDto;
import com.icignal.common.base.dto.response.ExcelMetaDataResDto;
import com.icignal.common.util.ExcelStyles.MERGE_CELL;
import com.icignal.core.exception.DataFailException;
import org.springframework.web.util.HtmlUtils;

/*
 * 1. 클래스명	: ExcelUtil
 * 2. 파일명	: ExcelUtil.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: qtsys-m07
 * 5. 작성일자	: 2020. 4. 2.
 */

/**
 * <PRE>
 * 1. 설명
 * 대용량 Excel Utility
 * </PRE>
 */
public class ExcelUtil {

	final static public String XML_ENCODING = "UTF-8";


	/**
	 * 엑셀 파일 생성
	 *
	 * @param out
	 * @param styles
	 * @throws Exception
	 */
	public static void generate(Writer out, Map<String, CellStyle> styles, String excelTitle, Map excelMap) throws Exception {

		Integer rowNum = 0;

		ObjectMapper om = new ObjectMapper();
		String excelHeaderDataListStr = unescapeHtml(unescapeHtml((String) excelMap.get("excelHeader")));
		String excelFooterDataListStr = unescapeHtml(unescapeHtml((String) excelMap.get("excelFooter")));

		List<Object> excelHeaderDataList = om.readValue(excelHeaderDataListStr, new TypeReference<List<Object>>() {
		}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함

		List<Object> excelFooterDataList = new ArrayList<Object>();
		if (ObjectUtil.isNotEmpty(excelFooterDataListStr)) {
			om.readValue(excelFooterDataListStr, new TypeReference<List<Object>>() {
			}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함
		}
		List<Object> rstList = (List<Object>) excelMap.get("excelData");
		List<ExcelRowDto> currentHeaderDataList = new ArrayList<ExcelRowDto>(); // 데이터를 가져와야할 대상 헤더 리스트


		ExcelSpreadSheetWriter sw = new ExcelSpreadSheetWriter(out);
		sw.beginSheet(); // 시트 시작

		if (excelHeaderDataList.size() > 0) {
			List lastList = (List) excelHeaderDataList.get(excelHeaderDataList.size() - 1);

			for (Object obj : lastList) {
				ObjectMapper mapper = new ObjectMapper();
				ExcelRowDto headerVO = mapper.convertValue(obj, ExcelRowDto.class);
				currentHeaderDataList.add(headerVO);
			}
		}

		sw.beginSheetData();

		int headerStyle = styles.get("HEADER").getIndex();
		List<ExcelMergeDto> megeInfoList = new ArrayList<>();

		if (excelHeaderDataList.size() > 0) {
			// 빈 Row
			sw.beginRow(rowNum++);
			int titleIdx = styles.get("TITLE_BG").getIndex();
			sw.createCell(0, "", titleIdx);
			sw.endRow();

			for (Object headerObject : excelHeaderDataList) {
				List currentExcelHeader = (List) headerObject;

				if (currentExcelHeader.size() > 0) {
					sw.beginRow(rowNum);
					Integer colIdx = 0;

					for (Object rowObj : currentExcelHeader) {
						ObjectMapper mapper = new ObjectMapper();
						ExcelRowDto headerVO = mapper.convertValue(rowObj, ExcelRowDto.class);
						sw.createCell(colIdx, headerVO.getText(), headerStyle);

						if (headerVO.getColspan() > 1) {
							ExcelMergeDto megeInfo = new ExcelMergeDto("M", rowNum, colIdx++, 0, headerVO.getColspan() - 1);
							megeInfoList.add(megeInfo);
							for (int i = 0; i < headerVO.getColspan() - 1; i++) {
								sw.createCell(colIdx++, "", headerStyle);
							}

						} else {
							colIdx++;
						}
					}

					rowNum++;
					sw.endRow();
				}
			}
		}

		if (rstList.size() > 0) {

			int pointIndex = styles.get("POINT").getIndex();

			for (Object dataVO : rstList) {
				Integer colNum = 0;

				sw.beginRow(rowNum++);

				for (ExcelRowDto keyVO : currentHeaderDataList) {
					String key = keyVO.getField();
					Class<?> type = null;
					Object value = null;

					Class<?> clazz = dataVO.getClass();

					// dataVo class별 값 추출
					// LinkedHashMap
					if (dataVO instanceof Map) {
						Map map = (Map) dataVO;

						value = map.get(key);

						if (value == null) {
							//throw new NullPointerException( key + " 가 존재 하지 않습니다. ");
							value = "";
						}

						type = value.getClass();
					}
					// 일반 VO
					else {
						Field field = null;

						while (clazz != null) {
							try {
								field = clazz.getDeclaredField(key);
								break;
							} catch (Exception e) {
								clazz = clazz.getSuperclass();
							}
						}

						if (field == null) {
							throw new ArithmeticException(key + " 가 존재 하지 않습니다. ");
						}
						field.setAccessible(true);
						type = field.getType();
						value = field.get(dataVO);
					}

					if (value != null) {
						ExcelStyles.excelFormat(colNum, sw, styles, value, type, pointIndex);
					}
					colNum++;
				}
				sw.endRow();
			}
		}

		if (excelFooterDataList.size() > 0) {


			int footerIndex = styles.get("FOOTER").getIndex();

			for (Object dataVO : excelFooterDataList) {
				Integer colNum = 0;

				sw.beginRow(rowNum++);

				for (ExcelRowDto keyVO : currentHeaderDataList) {
					String key = keyVO.getField();
					Class<?> type = null;
					Object value = null;

					Class<?> clazz = dataVO.getClass();

					// dataVo class별 값 추출
					// LinkedHashMap
					if (java.util.LinkedHashMap.class.equals(clazz)) {
						LinkedHashMap map = (LinkedHashMap) dataVO;

						value = map.get(key);

						if (value == null) {
							//throw new NullPointerException( key + " 가 존재 하지 않습니다. ");
							value = "";
						}

						type = value.getClass();
					}
					// 일반 VO
					else {
						Field field = null;

						while (clazz != null) {
							try {
								field = clazz.getDeclaredField(key);
								break;
							} catch (Exception e) {
								clazz = clazz.getSuperclass();
							}
						}

						if (field == null) {
							throw new ArithmeticException(key + " 가 존재 하지 않습니다. ");
						}
						field.setAccessible(true);
						type = field.getType();
						value = field.get(dataVO);
					}

					if (value != null) {
						ExcelStyles.excelFormat(colNum, sw, styles, value, type, footerIndex);
					}
					colNum++;
				}
				sw.endRow();
			}
		}

		sw.endSheetData();


		if (megeInfoList.size() > 0) {
			sw.beginSetMergeCell();
			for (ExcelMergeDto megeInfo : megeInfoList) {
				sw.createSetMergeCell(megeInfo.getMergeTarget(), megeInfo.getStartRow(), megeInfo.getStartCol(), megeInfo.getRowMergeCount(), megeInfo.getColMergeCount());
			}
			sw.endSetMergeCell();
		}

		sw.endSheet();
	}

	/**
	 * 다중시트 엑셀 파일 생성 (시트 별 타이틀 row 추가)
	 *
	 * @param out
	 * @param styles
	 * @throws Exception
	 */
	public static void generateWithExcelTitle(Writer out, Map<String, CellStyle> styles, String excelTitle, Map excelMap) throws Exception {

		Integer rowNum = 0;

		ObjectMapper om = new ObjectMapper();

		String excelHeaderDataListStr = unescapeHtml(unescapeHtml((String) excelMap.get("excelHeader")));
		List<Object> excelHeaderDataList = om.readValue(excelHeaderDataListStr, new TypeReference<List<Object>>() {
		}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함


		List<Object> rstList = (List<Object>) excelMap.get("excelData");
		List<ExcelRowDto> currentHeaderDataList = new ArrayList<ExcelRowDto>(); // 데이터를 가져와야할 대상 헤더 리스트


		ExcelSpreadSheetWriter sw = new ExcelSpreadSheetWriter(out);
		sw.beginSheet(); // 시트 시작

		if (excelHeaderDataList.size() > 0) {
			List lastList = (List) excelHeaderDataList.get(excelHeaderDataList.size() - 1);

			for (Object obj : lastList) {
				ObjectMapper mapper = new ObjectMapper();
				ExcelRowDto headerVO = mapper.convertValue(obj, ExcelRowDto.class);
				currentHeaderDataList.add(headerVO);
			}
		}

		//컬럼에 맞게 width 설정
		if (currentHeaderDataList.size() > 0) {

			sw.beginSetColWidth();

			for (int i = 1; i <= currentHeaderDataList.size(); i++) {
				ExcelRowDto er = currentHeaderDataList.get(i - 1);
				if (er != null) {
					sw.createSetColWidth(i, i, er.getText().getBytes().length);
				}
			}

			sw.endSetColWidth();
		}

		sw.beginSheetData();

		//타이틀
		if (ObjectUtil.isNotEmpty(excelTitle)) {
			sw.beginRow(rowNum++);
			int titleIdx = styles.get("TITLE_BG").getIndex();
			sw.createCell(0, excelTitle, titleIdx);
			sw.endRow();
		}

		int headerStyle = styles.get("HEADER").getIndex();
		List<ExcelMergeDto> megeInfoList = new ArrayList<>();

		if (excelHeaderDataList.size() > 0) {

			for (Object headerObject : excelHeaderDataList) {
				List currentExcelHeader = (List) headerObject;

				if (currentExcelHeader.size() > 0) {
					sw.beginRow(rowNum);
					Integer colIdx = 0;

					for (Object rowObj : currentExcelHeader) {
						ObjectMapper mapper = new ObjectMapper();
						ExcelRowDto headerVO = mapper.convertValue(rowObj, ExcelRowDto.class);

						//셀 병합
						if (headerVO.getColspan() > 1) {
							sw.createCell(colIdx, headerVO.getText(), headerStyle);

							ExcelMergeDto mergeItem = new ExcelMergeDto("C", rowNum, colIdx, headerVO.getRowspan() - 1, headerVO.getColspan() - 1);
							megeInfoList.add(mergeItem);

							colIdx = colIdx + headerVO.getColspan();
						} else {
							sw.createCell(colIdx, headerVO.getText(), headerStyle);

							colIdx++;
						}

					}
					rowNum++;
					sw.endRow();
				}
			}
		}

		if (rstList.size() > 0) {

			int pointIndex = styles.get("POINT").getIndex();

			for (Object dataVO : rstList) {
				Integer colNum = 0;

				sw.beginRow(rowNum++);

				for (ExcelRowDto keyVO : currentHeaderDataList) {
					String key = keyVO.getField();
					Field field = null;

					Class<?> clazz = dataVO.getClass();

					while (clazz != null) {
						try {
							field = clazz.getDeclaredField(key);
							break;
						} catch (Exception e) {
							clazz = clazz.getSuperclass();
						}
					}

					if (field == null) {
						throw new ArithmeticException(key + " 가 존재 하지 않습니다. ");
					}
					field.setAccessible(true);
					Class<?> type = field.getType();
					Object value = field.get(dataVO);

					if (value != null) {

						ExcelStyles.excelFormat(colNum, sw, styles, value, type, pointIndex);
					}
					colNum++;
				}
				sw.endRow();
			}
		}

		sw.endSheetData();

		sw.beginSetMergeCell();
		sw.createSetMergeCell("M", 0, 0, 0, 4); //타이틀 병합

		if (megeInfoList.size() > 0) {
			for (int i = 0; i < megeInfoList.size(); i++) {
				sw.createSetMergeCell(megeInfoList.get(i).getMergeTarget(), megeInfoList.get(i).getStartRow(), megeInfoList.get(i).getStartCol(), megeInfoList.get(i).getRowMergeCount(), megeInfoList.get(i).getColMergeCount()); //타이틀 병합
			}
		}

		sw.endSetMergeCell();

		sw.endSheet();
	}

	/**
	 * 생성한 템플릿 엑셀 파일과 시트 데이터를 합침
	 *
	 * @param zipFile  : the template file
	 * @param tempFile : the XML file with the sheet data
	 * @param entry    : the name of the sheet entry to substitute, e.g.
	 *                 xl/worksheets/shee1.xml
	 * @param out      : the stream to write the result to
	 * @throws IOException
	 */
	public static void substitute(File zipFile, File tempFile, String entry, OutputStream out) throws IOException {
		ZipFile zip = new ZipFile(zipFile);
		InputStream is = null;
		ZipOutputStream zos = new ZipOutputStream(out);
		try {
			Enumeration<? extends ZipEntry> entries = zip.entries();
			while (entries.hasMoreElements()) {
				ZipEntry ze = entries.nextElement();
				String entryName = ze.getName();

				if (entryName.equals(entry)) {
					zos.putNextEntry(new ZipEntry(entry));
					is = new FileInputStream(tempFile);
				} else {
					zos.putNextEntry(new ZipEntry(entryName));
					is = zip.getInputStream(ze);
				}

				copyStream(is, zos);
			}
		} finally {
			zip.close();
			is.close();
			zos.close();
		}
	}


	/*
	 * 1. 메소드명: substituteTemplate
	 * 2. 클래스명: ExcelUtil
	 * 3. 작성자명: Quintet
	 * 4. 작성일자: 2020. 4. 16.
	 */

	/**
	 * <PRE>
	 * 1. 설명
	 * 템플릿을 이용한 엑셀다운시 zipFile을 이용해 화면에 던저준다.
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param zipFile
	 * @param out
	 * @throws IOException
	 */
	public static void substituteTemplate(File zipFile, OutputStream out) throws IOException {
		ZipFile zip = new ZipFile(zipFile);
		try {
			ZipOutputStream zos = new ZipOutputStream(out);

			Enumeration<? extends ZipEntry> entries = zip.entries();
			while (entries.hasMoreElements()) {
				ZipEntry ze = entries.nextElement();
				String entryName = ze.getName();
				InputStream is = null;
				zos.putNextEntry(new ZipEntry(entryName));
				is = zip.getInputStream(ze);
				copyStream(is, zos);
				is.close();
			}

			zos.close();

		} finally {
			zip.close();
		}
	}

	/**
	 * @param in
	 * @param out
	 * @throws IOException
	 */
	public static void copyStream(InputStream in, OutputStream out) throws IOException {
		byte[] chunk = new byte[1024];
		int count;
		count = in.read(chunk);
		while (count >= 0) {
			out.write(chunk, 0, count);
			count = in.read(chunk);
		}
	}

	/**
	 * Sheet Data Writer
	 *
	 * @author qtsys-m07
	 */
	public static class ExcelSpreadSheetWriter {
		private final Writer _out;
		private int _rowNum;

		/**
		 * 생성자
		 *
		 * @param out
		 */
		public ExcelSpreadSheetWriter(Writer out) {
			this._out = out;
		}

		/**
		 * @return
		 */
		public int get_rowNum() {
			return _rowNum;
		}

		/**
		 * Sheet 작성 시작
		 *
		 * @throws IOException
		 */
		public void beginSheet() throws IOException {
			this._out.write("<?xml version=\"1.0\" encoding=\"" + XML_ENCODING + "\"?>\n");
			this._out.write("<worksheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\">\n");
		}

		/**
		 * Sheet 작성 종료
		 *
		 * @throws IOException
		 */
		public void endSheet() throws IOException {
			this._out.write("</worksheet>\n");
		}

		/**
		 * Sheet Data 작성 시작
		 *
		 * @throws IOException
		 */
		public void beginSheetData() throws IOException {
			this._out.write("<sheetData>\n");
		}

		/**
		 * Sheet Data 작성 종료
		 *
		 * @throws IOException
		 */
		public void endSheetData() throws IOException {
			this._out.write("</sheetData>\n");
		}

		/**
		 * 엑셀 Row 작성 시작
		 *
		 * @param rowNum
		 * @throws IOException
		 */
		public void beginRow(int rowNum) throws IOException {
			this._out.write("<row r=\"" + (rowNum + 1) + "\">\n");
			this._rowNum = rowNum;
		}

		/**
		 * 엑셀 Row 작성 종료
		 *
		 * @throws IOException
		 */
		public void endRow() throws IOException {
			this._out.write("</row>\n");
		}

		/**
		 * 엑셀 Cell 작성 - 스타일이 있는 텍스트
		 *
		 * @param colIdx
		 * @param value
		 * @param styleIdx
		 * @throws IOException
		 */
		public void createCell(int colIdx, String value, int styleIdx) throws IOException {
			String cellRef = new CellReference(this._rowNum, colIdx).formatAsString();
			this._out.write("<c r=\"" + cellRef + "\" t=\"inlineStr\"");
			if (styleIdx != -1) {
				this._out.write(" s=\"" + styleIdx + "\"");
			}
			this._out.write(">\n");
			this._out.write("<is><t>" + HtmlUtils.htmlEscape(value, "UTF-8") + "</t></is>\n");
			this._out.write("</c>\n");
		}

		/**
		 * 엑셀 Cell 작성 - 스타일이 없는 텍스트
		 *
		 * @param colIdx
		 * @param value
		 * @throws IOException
		 */
		public void createCell(int colIdx, String value) throws IOException {
			this.createCell(colIdx, value, -1);
		}

		/**
		 * 엑셀 Cell 작성 - 스타일이 있는 숫자
		 *
		 * @param colIdx
		 * @param value
		 * @param styleIdx
		 * @throws IOException
		 */
		public void createCell(int colIdx, Double value, int styleIdx) throws IOException {
			String cellRef = new CellReference(this._rowNum, colIdx).formatAsString();
			this._out.write("<c r=\"" + cellRef + "\" t=\"n\"");
			if (styleIdx != -1) {
				this._out.write(" s=\"" + styleIdx + "\"");
			}
			this._out.write(">\n");

			this._out.write("<v>" + value + "</v>\n");
			this._out.write("</c>\n");
		}

		/**
		 * 엑셀 Cell 작성 - 스타일이 없는 숫자
		 *
		 * @param colIdx
		 * @param value
		 * @throws IOException
		 */
		public void createCell(int colIdx, Double value) throws IOException {
			this.createCell(colIdx, value, -1);
		}

		/**
		 * 엑셀 Cell 작성 - 스타일이 있는 날짜
		 *
		 * @param colIdx
		 * @param value
		 * @param styleIdx
		 * @throws IOException
		 */
		public void createCell(int colIdx, Calendar value, int styleIdx) throws IOException {
			this.createCell(colIdx, DateUtil.getExcelDate(value, false), styleIdx);
		}

		/**
		 * 컬럼 Width 작성 시작
		 *
		 * @throws IOException
		 */
		public void beginSetColWidth() throws IOException {
			this._out.write("<cols>\n");
		}

		/**
		 * 컬럼 Width 작성 종료
		 *
		 * @throws IOException
		 */
		public void endSetColWidth() throws IOException {
			this._out.write("</cols>\n");
		}

		/**
		 * @param min
		 * @param max
		 * @param colWidth
		 * @throws IOException
		 */
		public void createSetColWidth(int min, int max, double colWidth) throws IOException {
			this._out.write("<col min=\"" + min + "\" max=\"" + max + "\" width=\"" + colWidth + "\" customWidth=\"1\" />\n");
		}

		/**
		 * 셀 병합 작성 시작
		 *
		 * @throws IOException
		 */
		public void beginSetMergeCell() throws IOException {
			this._out.write("<mergeCells>\n");
		}

		/**
		 * 셀 병합 작성 종료
		 *
		 * @throws IOException
		 */
		public void endSetMergeCell() throws IOException {
			this._out.write("</mergeCells>\n");
		}

		/**
		 * 셀 병합
		 *
		 * @param mergeTarget   : Row or Column
		 * @param startRow      : 시작 Row
		 * @param startCol      : 시작 Column
		 * @param rowMergeCount : 병합 갯수
		 * @throws IOException
		 */
		public void createSetMergeCell(String mergeTarget, int startRow, int startCol, int rowMergeCount, int colMergeCount) throws IOException {
			String startCellRef = null;
			String endCellRef = null;

			startCellRef = new CellReference(startRow, startCol).formatAsString();

			if (MERGE_CELL.M.name().equals(mergeTarget)) {
				endCellRef = new CellReference(startRow + rowMergeCount, startCol + colMergeCount).formatAsString();
			}

			if (MERGE_CELL.R.name().equals(mergeTarget)) {
				endCellRef = new CellReference(startRow + rowMergeCount, startCol).formatAsString();
			}

			if (MERGE_CELL.C.name().equals(mergeTarget)) {
				endCellRef = new CellReference(startRow, startCol + colMergeCount).formatAsString();
			}

			this._out.write("<mergeCell ref=\"" + startCellRef + ":" + endCellRef + "\" />\n");
		}

		public void setFreezePane(int startSplit) throws IOException {
			String cellTopLeft = new CellReference(startSplit, 0).formatAsString();

			this._out.write("<sheetViews>\n");
			this._out.write("<sheetView tabSelected=\"1\" workbookViewId=\"0\">\n");
			this._out.write("<pane ySplit=\"" + startSplit + "\" topLeftCell=\"" + cellTopLeft + "\" activePane=\"bottomLeft\" state=\"frozen\" />\n");
			this._out.write("<selection pane=\"bottomLeft\" />\n");
			this._out.write("</sheetView>\n");
			this._out.write("</sheetViews>\n");
		}
	}

	/**
	 * Cell 값을 문자열로 반환
	 *
	 * @param cell
	 * @return
	 */
	public static String getCellValue(Cell cell) {
		if (cell != null) {
			switch (cell.getCellType()) {
				case STRING:
					return cell.getStringCellValue();

				case NUMERIC:
					return String.valueOf(cell.getNumericCellValue());

				case BOOLEAN:
					return String.valueOf(cell.getBooleanCellValue());

				case FORMULA:
					return cell.getCellFormula();

				case ERROR:
					return String.valueOf(cell.getErrorCellValue());

				case BLANK:
					return "";

				default:
					return null;
			}
		}
		return null;
	}

	/*
	 * 1. 메소드명: settleMonthGenerate
	 * 2. 클래스명: IFVExcelUtil
	 * 3. 작성자명: dw.keum
	 * 4. 작성일자: 2019. 2. 20.
	 */

	/**
	 * <PRE>
	 * 1. 설명
	 * 월정산 엑셀 다운로드 전용
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param out
	 * @param styles
	 * @param excelTitle
	 * @param excelMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void settleMonthGenerate(Writer out, Map<String, CellStyle> styles, String excelTitle, Map excelMap) throws Exception {

		Integer rowNum = 0;

		ObjectMapper om = new ObjectMapper();

		String excelHeaderDataListStr = unescapeHtml(unescapeHtml((String) excelMap.get("excelHeader"))); //해더 추출

		List<ExcelRowDto> excelHeaderDataList = om.readValue(excelHeaderDataListStr, new TypeReference<List<ExcelRowDto>>() {
		}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함

		List<Object> rstList = (List<Object>) excelMap.get("excelData");
		List<ExcelRowDto> currentHeaderDataList = new ArrayList<ExcelRowDto>(); // 데이터에 맞는 대상 헤더 리스트

		ExcelSpreadSheetWriter sw = new ExcelSpreadSheetWriter(out);
		sw.beginSheet(); // 시트 시작
		/**
		 * 2019.04.08
		 * jk.kim
		 * 동일한 키값이 들어와도 처음 key-value로 변경
		 */
		Map<String, String> map = excelHeaderDataList.stream().collect(Collectors.toMap(ExcelRowDto::getField, ExcelRowDto::getText, (p1, p2) -> p1));

		LinkedHashMap<String, Object> rst = (LinkedHashMap<String, Object>) rstList.get(0);
		for (Entry<String, Object> e : rst.entrySet()) {
			if (!e.getKey().toString().equals("YYYYMM") && !e.getKey().toString().equals("TOTALCOUNT")) {    //기간컬럼 제외

				ExcelRowDto header = new ExcelRowDto();
				header.setText(map.get(e.getKey()));
				header.setField(e.getKey());
				currentHeaderDataList.add(header);

			}
		}

		//컬럼 width 설정
		if (currentHeaderDataList.size() > 0) {
			sw.beginSetColWidth();
			sw.createSetColWidth(1, 1, 30);
			sw.createSetColWidth(2, 2, 15);
			sw.createSetColWidth(3, 3, 15);
			for (int i = 4; i <= currentHeaderDataList.size(); i++) {
				ExcelRowDto er = currentHeaderDataList.get(i - 1);
			}

			sw.endSetColWidth();
		}

		//sheetData 작성
		sw.beginSheetData();

		int headerStyle = styles.get("HEADER").getIndex();
		List<ExcelMergeDto> megeInfoList = new ArrayList<>();

		if (currentHeaderDataList.size() > 0) {

			sw.beginRow(rowNum);

			Integer colIdx = 0;

			for (ExcelRowDto headerObject : currentHeaderDataList) {
				ObjectMapper mapper = new ObjectMapper();
				sw.createCell(colIdx, headerObject.getText(), headerStyle);

				if (headerObject.getColspan() > 1) {
					ExcelMergeDto megeInfo = new ExcelMergeDto("M", rowNum, colIdx++, 0, headerObject.getColspan() - 1);
					megeInfoList.add(megeInfo);
					colIdx++;
					for (int i = 0; i < headerObject.getColspan() - 1; i++) {
						sw.createCell(colIdx++, "", headerStyle);
						colIdx++;
					}
				} else {
					colIdx++;
				}
			}
			rowNum++;
			sw.endRow();
		}

		if (rstList.size() > 0) {

			int pointIndex = styles.get("POINT").getIndex();

			for (Object dataVO : rstList) {

				sw.beginRow(rowNum++);

				for (int colNum = 0; colNum < currentHeaderDataList.size(); colNum++) {
					Class<?> type = null;
					Object value = null;

					LinkedHashMap<String, Object> dataMap = (LinkedHashMap<String, Object>) dataVO;
					value = dataMap.get(currentHeaderDataList.get(colNum).getField());
					if (value != null) {
						type = value.getClass();
						ExcelStyles.excelFormat(colNum, sw, styles, value, type, pointIndex);
					}
				}
				sw.endRow();
			}
		}

		sw.endSheetData();

		if (megeInfoList.size() > 0) {
			sw.beginSetMergeCell();
			for (ExcelMergeDto megeInfo : megeInfoList) {
				sw.createSetMergeCell(megeInfo.getMergeTarget(), megeInfo.getStartRow(), megeInfo.getStartCol(), megeInfo.getRowMergeCount(), megeInfo.getColMergeCount());
			}
			sw.endSetMergeCell();
		}

		sw.endSheet();
	}

	/*
	 * 1. 메소드명: getDBGenerate
	 * 2. 클래스명: ExcelMetaDBUtil
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 3. 27.
	 */

	/**
	 * <PRE>
	 * 1. 설명
	 * 엑셀 헤더값을 DB에서 가져오는 로직을 사용
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param out
	 * @param styles
	 * @param excelTitle
	 * @param excelMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void getDBGenerate(Writer out, Map<String, CellStyle> styles, String excelTitle, Map<String, Object> excelMap) throws Exception {

		int rowNum = 0;
		ObjectMapper om = new ObjectMapper();

		// 1 .  엑셀 다운로드할 데이터 조회
		List<Object> excelData = (List<Object>) excelMap.get("excelData");

		if (excelData.size() == 0) throw new DataFailException("엑셀 데이터 없음"); // 엑셀 데이터 없음


		// 2 .  엑셀 헤데 메타 데이터 조회
		String excelHeaderDataListStr = (String) excelMap.get("excelHeader");
		List<ExcelMetaDataResDto> excelHeaderDataList = om.readValue(excelHeaderDataListStr, new TypeReference<List<ExcelMetaDataResDto>>() {
		}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함

		if (excelHeaderDataList.size() == 0) throw new DataFailException("엑셀 헤더 메타데이터 없음");  // 엑셀 헤더 메타데이터 없음

		// 3 . 엑셀 데이터 작성
		ExcelSpreadSheetWriter sw = new ExcelSpreadSheetWriter(out);
		sw.beginSheet(); // 시트 시작

		sw.beginSheetData();

		// 3.1 타이틀 write
		rowNum = 1;
		sw.beginRow(rowNum);
		int titleIdx = styles.get("TITLE_BG").getIndex();
		sw.createCell(0, excelHeaderDataList.get(0).getTitle(), titleIdx);
		sw.endRow();

		//3.2 헤데 write
		int headerStyle = styles.get("HEADER").getIndex();
		rowNum = 2;
		sw.beginRow(rowNum);
		int colIdx = 0;
		for (ExcelMetaDataResDto headerObject : excelHeaderDataList) {

			sw.createCell(colIdx, headerObject.getText(), headerStyle);
			colIdx++;
		}
		sw.endRow();
		//3.3 데이터 write
		Class<?> clazz = null;
		Class<?> type = null;
		Object value = null;
		Field field = null;
		String key = null;

		int pointIndex = styles.get("POINT").getIndex();
		rowNum = 3;

		for (Object dataVO : excelData) {
			int colNum = 0;

			sw.beginRow(rowNum++);

			for (ExcelMetaDataResDto keyVO : excelHeaderDataList) {

				key = keyVO.getField();
				clazz = dataVO.getClass();
				field = clazz.getDeclaredField(key);

				if (field == null) {
					throw new IllegalArgumentException(key + " 가 존재 하지 않습니다. ");
				}
				field.setAccessible(true);
				type = field.getType();
				value = field.get(dataVO);

				if (value != null) {
					ExcelStyles.excelFormat(colNum, sw, styles, value, type, pointIndex);
				}
				colNum++;
			}
			sw.endRow();
		}

		sw.endSheetData();

		sw.endSheet();
	}

	/*
	 * 1. 메소드명: getTemplateGenerate
	 * 2. 클래스명: ExcelUtil
	 * 3. 작성자명: Quintet
	 * 4. 작성일자: 2020. 4. 9.
	 */

	/**
	 * <PRE>
	 * 1. 설명
	 * 템플릿을 이용한 엑셀다운로드할때 테이터 넣어주는 로직
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param curSheet
	 * @param row
	 * @param excelMap
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static void getTemplateGenerate(XSSFSheet curSheet, int row, Map<String, Object> excelMap) throws Exception {

//		row = curSheet.getPhysicalNumberOfRows();
		ObjectMapper om = new ObjectMapper();

		// 1 .  엑셀 다운로드할 데이터 조회
		List<Object> excelData = (List<Object>) excelMap.get("excelData");

		if (excelData.size() == 0) throw new DataFailException("엑셀 데이터 없음"); // 엑셀 데이터 없음

		// 2 .  엑셀 헤데 메타 데이터 조회
		String excelHeaderDataListStr = (String) excelMap.get("excelHeader");
		List<ExcelMetaDataResDto> excelHeaderDataList = om.readValue(excelHeaderDataListStr, new TypeReference<List<ExcelMetaDataResDto>>() {
		}); // 엑셀 헤더는 Merge 대상 헤더가 있을 수도 있어서 한 번 더 파싱해야함

		if (excelHeaderDataList.size() == 0) throw new DataFailException("엑셀 헤더 메타데이터 없음");  // 엑셀 헤더 메타데이터 없음
		int tempRow;
		// 3 . 엑셀 데이터 작성
		Class<?> clazz = null;
//		Class<?> type = null;
		Object value = null;
		Field field = null;
		String key = null;
		tempRow = excelHeaderDataList.get(0).getRowNum();
		for (Object dataVO : excelData) {
			// 현재 row
			XSSFRow curRow = curSheet.createRow(tempRow - 1);
			int colNum = 0;
			tempRow++;
			for (ExcelMetaDataResDto keyVO : excelHeaderDataList) {
				int col = excelHeaderDataList.get(colNum).getColNum();
				key = keyVO.getField();
				clazz = dataVO.getClass();
				field = clazz.getDeclaredField(key);

				field.setAccessible(true);
//				type = field.getType();
				value = field.get(dataVO);

				if (value != null) {
					XSSFCell cell0 = curRow.createCell(col - 1);
					cell0.setCellValue(value.toString());

				}
				colNum++;
			}
		}
	}

	/**
	 * Writes spreadsheet data in a Writer. (YK: in future it may evolve in a
	 * full-featured API for streaming data in Excel)
	 */
	public static class SpreadsheetWriter {
		private final Writer _out;
		private int _rownum;

		public SpreadsheetWriter(Writer out) {
			_out = out;
		}


		public void beginWorkSheet() throws IOException {
			_out.write("<?xml version=\"1.0\" encoding=\"" + XML_ENCODING + "\"?>"
					+ "<worksheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\">");
		}

		public void endWorkSheet() throws IOException {
			_out.write("</worksheet>");
		}

		public void beginSheet() throws IOException {
			_out.write("<sheetData>\n");
		}

		public void endSheet() throws IOException {
			_out.write("</sheetData>");
		}

		/**
		 * Insert a new row
		 *
		 * @param rownum 0-based row number
		 */
		public void insertRow(int rownum) throws IOException {
			_out.write("<row r=\"" + (rownum + 1) + "\">\n");
			this._rownum = rownum;
		}

		/**
		 * Insert a new row
		 *
		 * @param rownum 0-based row number
		 */
		public void insertRow(int rownum, int height, int customHeight) throws IOException {
			_out.write("<row r=\"" + (rownum + 1) + "\"  ht=\"" + height + "\" customHeight=\"" + customHeight + "\"  >\n");
			this._rownum = rownum;
		}

		/**
		 * Insert row end marker
		 */
		public void endRow() throws IOException {
			_out.write("</row>\n");
		}

		public void createCell(int columnIndex, String value, int styleIndex) throws IOException {
			String ref = new CellReference(_rownum, columnIndex).formatAsString();
			_out.write("<c r=\"" + ref + "\" t=\"inlineStr\"");
			if (styleIndex != -1)
				_out.write(" s=\"" + styleIndex + "\"");
			_out.write(">");
			_out.write("<is><t>" + getSTRFilter(value) + "</t></is>");
			_out.write("</c>");
		}

		public void createHyperLinkCell(int columnIndex, String value, int styleIndex) throws IOException {
			String ref = new CellReference(_rownum, columnIndex).formatAsString();
			_out.write("<c r=\"" + ref + "\" t=\"inlineStr\"");
			if (styleIndex != -1)
				_out.write(" s=\"" + styleIndex + "\"");
			_out.write(">");
			_out.write("<is><t>" + value + "</t></is>");
			_out.write("</c>");
		}

		public static String getSTRFilter(String str) {
			String tempStr = str;
			String str_imsi = "";
			String[] filter_word = {"", "\\.", "\\?", "\\/", "\\~", "\\!", "\\@", "\\#", "\\$", "\\%", "\\^", "\\&", "\\*", "\\(", "\\)", "\\_", "\\+", "\\=", "\\|", "\\\\", "\\}", "\\]", "\\{", "\\[", "\\\"", "\\'", "\\:", "\\;", "\\<", "\\,", "\\>", "\\.", "\\?", "\\/", "--", "\0"};

			for (int i = 0; i < filter_word.length; i++) {
				str_imsi = tempStr.replaceAll(filter_word[i], "");
				tempStr = str_imsi;
			}

			return tempStr;
		}

		;

		public void createCell(int columnIndex, String value) throws IOException {
			createCell(columnIndex, value, -1);
		}

		public void createCell(int columnIndex, double value, int styleIndex) throws IOException {
			String ref = new CellReference(_rownum, columnIndex).formatAsString();
			_out.write("<c r=\"" + ref + "\" t=\"n\"");
			if (styleIndex != -1)
				_out.write(" s=\"" + styleIndex + "\"");
			_out.write(">");
			_out.write("<v>" + value + "</v>");
			_out.write("</c>");
		}

		public void createCell(int columnIndex, double value)
				throws IOException {
			createCell(columnIndex, value, -1);
		}

		public void createCell(int columnIndex, Calendar value, int styleIndex) throws IOException {
			createCell(columnIndex, DateUtil.getExcelDate(value, false), styleIndex);
		}


		/**
		 * 셀 합치기
		 *
		 * @param mergeCell 행으로만 테스트 ... [A1 : F5]
		 * @throws IOException
		 */
		public void mergeCell(String[][] mergeCell) throws IOException {
			_out.write("<mergeCells>");

			for (int i = 0; i < mergeCell.length; i++) {
				_out.write("<mergeCell ref=\"");
				for (int j = 0; j < mergeCell[i].length; j++) {
					_out.write(mergeCell[i][j] + (j < mergeCell[i][j].length() - 1 ? ":" : ""));
				}
				_out.write("\" />");
			}
			_out.write("</mergeCells>");

		}

		/**
		 * 셀 크기 변경
		 *
		 * @param min
		 * @param max
		 * @param width
		 * @param customWidth
		 * @throws IOException
		 */
		public void customCell(int min, int max, int width, int customWidth) throws IOException {
			_out.write("<cols>");
			_out.write("<col min=\"" + min + "\" max=\"" + max + "\" width=\"" + width + "\" customWidth=\"" + customWidth + "\" />");
			_out.write("</cols>");
		}

		public void customCell(List<SfExcelAttribute> customCellSizeList) throws IOException {
			_out.write("<cols>");

			for (SfExcelAttribute sfExcelAttribute : customCellSizeList) {
				_out.write("<col min=\"" + sfExcelAttribute.getMin() + "\" max=\"" + sfExcelAttribute.getMax() + "\" width=\"" + sfExcelAttribute.getWidth() + "\" customWidth=\"" + sfExcelAttribute.getCustomWidth() + "\" />");
			}
			_out.write("</cols>");
		}
	}

	public static class HeaderInfoList extends ArrayList<HeaderInfo> {
		/**
		 *
		 */
		private static final long serialVersionUID = 1461231795670059566L;

		public void addHeader(HeaderInfo hi) {
			this.add(hi);
		}

		public void addHeader(int index, String variableName, String displayName) {
			HeaderInfo hi = new HeaderInfo();
			hi.setIndex(index);
			hi.setDisplayName(displayName);
			hi.setVariableName(variableName);

			this.add(hi);
		}

		public void addHeader(int index, String variableName, String displayName, String format) {
			HeaderInfo hi = new HeaderInfo();
			hi.setIndex(index);
			hi.setDisplayName(displayName);
			hi.setVariableName(variableName);
			hi.setFormat(format);

			this.add(hi);
		}
	}

	public static class HeaderInfo {
		private int index;
		private String displayName;
		private String variableName;
		private String format;

		public int getIndex() {
			return index;
		}

		public void setIndex(int index) {
			this.index = index;
		}

		public String getDisplayName() {
			return displayName;
		}

		public void setDisplayName(String displayName) {
			this.displayName = displayName;
		}

		public String getVariableName() {
			return variableName;
		}

		public void setVariableName(String variableName) {
			this.variableName = variableName;
		}

		public String getFormat() {
			return format;
		}

		public void setFormat(String format) {
			this.format = format;
		}

	}

	public static class SfExcelAttribute {
		int min, max, width, customWidth;

		public SfExcelAttribute(int min, int max, int width, int customWidth) {
			super();
			this.min = min;
			this.max = max;
			this.width = width;
			this.customWidth = customWidth;
		}

		public int getMax() {
			return max;
		}

		public int getMin() {
			return min;
		}

		public void setMin(int min) {
			this.min = min;
		}

		public int getWidth() {
			return width;
		}

		public void setWidth(int width) {
			this.width = width;
		}

		public int getCustomWidth() {
			return customWidth;
		}

		public void setCustomWidth(int customWidth) {
			this.customWidth = customWidth;
		}

		public void setMax(int max) {
			this.max = max;
		}
	}

	public static String bulkInsertExcel(ExcelTable excelTable, String headers,
										 String tableName, String columns, String customValue) {
		String rtnValue = "";

		String content = "";
		try {
			for (ExcelRow row : excelTable.getData()) {
				String[] headerArr = headers.split(",");

				for (String s : headerArr) {
					content += row.get(s.trim().toUpperCase()) + "|";
				}

				content = content.substring(0, content.length() - 1);
				content += "\r\n";
			}

			String filePath = "";
			String folderPath = System.getProperty("java.io.tmpdir");
			String fileName = "Excel-" + new Date().getTime() + ".txt";

			File f1 = new File(folderPath);
			if (!f1.exists())
				f1.mkdirs();

			filePath = folderPath + fileName;
			File f2 = new File(filePath);
			if (f2.exists())
				f2.delete();
			f2.createNewFile();

			IOUtils.write(content, new FileOutputStream(f2.getPath()), "UTF-8");

			excelTable.setTxtPath(filePath);
			String cv = "";
			if (customValue != null && customValue.length() > 0)
				cv = " SET " + customValue;

			rtnValue = " LOAD DATA LOCAL INFILE '" + filePath.replace("\\", "\\\\") + "' INTO TABLE " + tableName
					+ "	 "
					+ " FIELDS TERMINATED BY  '|'" + " LINES TERMINATED BY '\\r\\n'" + " (" + columns + ")"
					+ cv;

		} catch (FileNotFoundException ex) {
			LogUtil.error(ex.getMessage(), ex);
			rtnValue = "";
		} catch (IOException ex) {
			LogUtil.error(ex.getMessage(), ex);
			rtnValue = "";
		}


		return rtnValue;
	}

	/**
	 * 엑셀 읽기
	 *
	 * @param multipart
	 * @param sheetName
	 * @param includeHeader
	 * @param maxCellIndex
	 * @return
	 */
	public static ExcelTable readExcel(MultipartFile multipart, String sheetName, boolean includeHeader,
									   int maxCellIndex) {
		File tmpFile = new File(System.getProperty("java.io.tmpdir") + System.getProperty("file.separator")
				+ "Excel-" + new Date().getTime() + multipart.getOriginalFilename());
		try {
			if (tmpFile.exists())
				tmpFile.delete();
			multipart.transferTo(tmpFile);
		} catch (IllegalStateException | IOException e) {
			LogUtil.error(e);
		}

		return ExcelUtil.readExcel(tmpFile.getAbsolutePath(), sheetName, includeHeader, maxCellIndex);
	}

	/**
	 * 엑셀 읽기
	 *
	 * @param excelPath
	 * @param sheetName
	 * @param includeHeader
	 * @param maxCellIndex
	 * @return
	 */
	public static ExcelTable readExcel(String excelPath, String sheetName, boolean includeHeader, int maxCellIndex) {
		ExcelTable rtnValue = new ExcelTable();

		File file = new File(excelPath);
		Workbook wb = null;

		LogUtil.debug("Read ExcelFile Start");
		try {// 엑셀 파일 오픈
			if (file.getAbsolutePath().endsWith(".xlsx")) {
				wb = new XSSFWorkbook(new FileInputStream(file));
			} else {
				wb = new HSSFWorkbook(new FileInputStream(file));
			}

		} catch (FileNotFoundException e) {
			LogUtil.error(e);
		} catch (IOException e) {
			LogUtil.error(e);
		}
		LogUtil.debug("Read ExcelFile Finish");

		LogUtil.debug("Convert ExcelFileData Start");
		int index = 0;
		for (Row row : wb.getSheet(sheetName)) {

			index++;

			if (!includeHeader && index == 1)
				continue;

			ExcelRow rowData = new ExcelRow();
			rowData.rowIndex = index;

			try {
				LogUtil.debug("Read Line : " + index);

				// Iterator cellItr = row.cellIterator();
				// while (cellItr.hasNext()) {
				// XSSFCell cell = (XSSFCell) cellItr.next();

				// String cellLocation = cell.getReference();
				// String cellValue = "";

				for (int count = 0; count < maxCellIndex; count++) {
					Cell cell = row.getCell(count, Row.MissingCellPolicy.RETURN_NULL_AND_BLANK);
					String cellLocation = "";
					String cellValue = "";

//					cellLocation = (char) (count + 65) + String.valueOf(rowData.rowIndex);
					cellLocation = Integer.toString(count + 65);

					if (cell != null) {
						switch (cell.getCellType()) {
							case BLANK:
								cellValue = "";
								break;
							case BOOLEAN:
								cellValue = String.valueOf(cell.getBooleanCellValue());
								break;
							case ERROR:
								cellValue = String.valueOf(cell.getErrorCellValue());
								break;
							case FORMULA:
								cellValue = String.valueOf(cell.getStringCellValue());
								break;
							case NUMERIC:
								cellValue = String.valueOf(cell.getNumericCellValue());
								break;
							case STRING:
								cellValue = cell.getStringCellValue();
								break;
							default:
								break;
						}
					}
					rowData.put(cellLocation, cellValue);
				}
				wb.close();

				rtnValue.addData(rowData);

			} catch (IOException ex) {
				LogUtil.error(ex.getMessage(), ex);
			}
		}

		rtnValue.setExcelPath(file.getAbsolutePath());
		LogUtil.debug("Convert ExcelFileData Finish");

		return rtnValue;
	}

	public static void exportExcel(String fileName, HttpServletRequest req, HttpServletResponse res)
			throws IOException {
		String tempFileName = fileName;
		String fileTempPath = CommonUtil.getInstance().getServletProp("imageUpload.tempImageUploadPath") + fileName + "/";

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			tempFileName += ".xlsx";
			File file = new File(fileTempPath + tempFileName); // 저장된 위치에서
			// 뽑아옴.
			if (file.isFile()) {

				fin = new BufferedInputStream(new FileInputStream(file));
				outs = new BufferedOutputStream(res.getOutputStream());

				int filelength = (int) file.length();

				if (filelength > 0) {
					byte[] bytestream = new byte[filelength];

					int read = 0;

					//response.setContentType("application/x-msdownload");
					res.setContentType("application/octet-stream");

					String userAgent = req.getHeader("User-Agent");
					boolean isIE = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1;

					if (isIE) {
						tempFileName = new String(tempFileName.getBytes("x-windows-949"), "ISO-8859-1");
					} else {
						tempFileName = new String(tempFileName.getBytes("UTF-8"), "ISO-8859-1");
					}

					res.setHeader("Content-Disposition", "attachment; filename=\"" + tempFileName + "\"");
					res.setContentLength(filelength);
					res.setHeader("Content-Length", String.valueOf(filelength));
					res.setHeader("Content-Transfer-Encoding", "binary;");
					res.setHeader("Pragma", "no-cache;");
					res.setHeader("Expires", "0");

					read = fin.read(bytestream);

					while (read != -1) {
						outs.write(bytestream, 0, read);

						read = fin.read(bytestream);
					}

					outs.flush();
				} else {
					LogUtil.debug("no file");
				}
			} else {
				LogUtil.debug("no file");
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(), e);
		} finally {
			if (fin != null)
				fin.close();
			if (outs != null)
				outs.close();
		}
	}

	public static String createExcel(List<Object> dataList, HeaderInfoList headers, HttpServletRequest request) {
		String rtnValue = "";

		String xmlFileName = "sheet";
		String xlsxName = String.valueOf(System.currentTimeMillis());
		String sheetName = "sheet";
		String fileTempPath = CommonUtil.getInstance().getServletProp("imageUpload.tempImageUploadPath") + xlsxName + "/";
		File file = new File(fileTempPath);
		if (!file.isDirectory()) {
			file.mkdirs();
		}

		try {
			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet("Export Excel");

			Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);
			String sheetRef = sheet.getPackagePart().getPartName().getName();

			String tmpPath = fileTempPath + "template.xlsx";
			File f = new File(tmpPath);
			f.createNewFile();

			// save the template
			FileOutputStream os = new FileOutputStream(tmpPath);
			wb.write(os);
			os.close();

			// Step 2. Generate XML file.
			File tmp = new File(fileTempPath + "/dataXml/", "sheet.xml");// File.createTempFile("sheet",
			// ".xml");//
			if (!tmp.getParentFile().isDirectory()) {
				tmp.getParentFile().mkdirs();
			}

			tmp.createNewFile();

			Writer fw = new OutputStreamWriter(new FileOutputStream(tmp), XML_ENCODING);
			generate(fw, styles, dataList, headers);
			fw.close();

			// Step 3. Substitute the template entry with the generated data
			FileOutputStream out = null;
			try {
				out = new FileOutputStream(fileTempPath + "/" + xlsxName + ".xlsx");
			} catch (FileNotFoundException e) {
				LogUtil.error(e);
			}
			substitute(new File(fileTempPath + "/template.xlsx"), tmp, sheetRef.substring(1), out);
			out.close();
			wb.close();
			rtnValue = xlsxName;
		} catch (IOException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
			LogUtil.error(e.getMessage(), e);

			rtnValue = null;
		}

		return rtnValue;
	}

	public static void generate(Writer out, Map<String, CellStyle> styles, List<Object> data,
								HeaderInfoList headers) throws IOException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		SpreadsheetWriter sw = new SpreadsheetWriter(out);
		sw.beginWorkSheet();
		// column size
		// List<SfExcelAttribute> customCellSizeList = new ArrayList<>();
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 8, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 30, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 30, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 15, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 15, 1));
		// sw.customCell(customCellSizeList);
		sw.beginSheet();

		// insert header row
		sw.insertRow(0);

		sw.createCell(0, "#", styles.get("header").getIndex());
		for (HeaderInfo hi : headers) {
			sw.createCell(hi.getIndex() + 1, hi.getDisplayName(), styles.get("header").getIndex());
		}
		sw.endRow();

		// insert row / create cell data
		int rownum = 1;
		if (!data.isEmpty() && data.size() > 0) {
			for (Object obj : data) {

				sw.insertRow(rownum);

				sw.createCell(0, rownum - 1, styles.get("guide").getIndex());
				for (HeaderInfo hi : headers) {
					Object item = PropertyUtils.getProperty(obj, hi.getVariableName());
					String value = item.toString();
					int styleIndex = styles.get("guide").getIndex();
					if (item instanceof java.util.Date) {
						SimpleDateFormat sdf = new SimpleDateFormat(hi.getFormat(), Locale.KOREAN);
						value = sdf.format((java.util.Date) item);
					} else if (item instanceof Boolean) {
						String[] formats = hi.getFormat().split("\\|");
						value = item.toString().equalsIgnoreCase("TRUE") ? formats[0] : formats[1];
					}

					if (hi.getVariableName().contains("image")) {
						styleIndex = styles.get("hyperlink").getIndex();

						sw.createHyperLinkCell(hi.getIndex() + 1, value, styleIndex);
					} else {

						sw.createCell(hi.getIndex() + 1, value, styleIndex);

					}
				}

				rownum++;
				sw.endRow();
			}
		}

		LogUtil.info("dataMergeList SIZE = " + data.size());
		sw.endSheet();

		// end
		sw.endWorkSheet();
	}

	public static void generateMultiCell(Writer out, Map<String, CellStyle> styles, List<HashMap<String, Object>> data,
										 HeaderInfoList headers) throws IOException, IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		SpreadsheetWriter sw = new SpreadsheetWriter(out);
		sw.beginWorkSheet();
		// column size
		// List<SfExcelAttribute> customCellSizeList = new ArrayList<>();
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 8, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 30, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 30, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 15, 1));
		// customCellSizeList.add(new SfExcelAttribute(1, 1, 15, 1));
		// sw.customCell(customCellSizeList);
		sw.beginSheet();

		// insert header row
		sw.insertRow(0);

		sw.createCell(0, "#", styles.get("header").getIndex());
		for (HeaderInfo hi : headers) {
			sw.createCell(hi.getIndex() + 1, hi.getDisplayName(), styles.get("header").getIndex());
		}
		sw.endRow();

		// insert row / create cell data
		int rownum = 1;
		if (!data.isEmpty() && data.size() > 0) {
			for (HashMap<String, Object> obj : data) {
				if (ObjectUtil.isNotEmpty(obj)) {
					sw.insertRow(rownum);

					sw.createCell(0, rownum - 1, styles.get("guide").getIndex());
					for (HeaderInfo hi : headers) {
						Object item = obj.get(hi.getVariableName());
						String value = null;
						try {
							value = item.toString();
						} catch (ArithmeticException e) {
							LogUtil.error(e);
						}
						int styleIndex = styles.get("guide").getIndex();
						if (item instanceof java.util.Date) {
							SimpleDateFormat sdf = new SimpleDateFormat(hi.getFormat(), Locale.KOREAN);
							value = sdf.format((java.util.Date) item);
						} else if (item instanceof Boolean) {
							String[] formats = hi.getFormat().split("\\|");
							value = item.toString().equalsIgnoreCase("TRUE") ? formats[0] : formats[1];
						}

						if (hi.getVariableName().contains("image")) {
							styleIndex = styles.get("hyperlink").getIndex();

							sw.createHyperLinkCell(hi.getIndex() + 1, value, styleIndex);
						} else {

							sw.createCell(hi.getIndex() + 1, value, styleIndex);

						}
					}
					rownum++;
					sw.endRow();
				}
			}
		}

		LogUtil.info("dataMergeList SIZE = " + data.size());
		sw.endSheet();

		// end
		sw.endWorkSheet();
	}

	public static class ExcelTable {
		private List<ExcelRow> _data;
		private String excelPath;
		private String txtPath;

		public List<String> getData(String column) {
			List<String> rtnValue = new ArrayList<String>();

			for (ExcelRow er : this._data) {
				String value = er.get(column.toUpperCase());
				rtnValue.add(value == null ? "" : value);
			}

			return rtnValue;
		}

		public List<ExcelRow> getData() {
			if (this._data == null)
				this._data = new ArrayList<ExcelRow>();
			return _data;
		}

		public void setData(List<ExcelRow> _data) {
			this._data = _data;
		}

		public void addData(ExcelRow _row) {
			this.getData().add(_row);
		}

		public String getExcelPath() {
			return excelPath;
		}

		public void setExcelPath(String excelPath) {
			this.excelPath = excelPath;
		}

		public String getTxtPath() {
			return txtPath;
		}

		public void setTxtPath(String txtPath) {
			this.txtPath = txtPath;
		}
	}

	public static class ExcelRow extends HashMap<String, String> {

		private int rowIndex;

		public int getRowIndex() {
			return rowIndex;
		}

		public void setRowIndex(int rowIndex) {
			this.rowIndex = rowIndex;
		}

	}

	/*
	 * IFVMExcelUtility
	 * */

	/**
	 * @return :
	 * @name : generateExcel
	 * @date : 2016. 8. 10.
	 * @author : 류동균
	 * @description : generate Excel
	 */
	public static boolean generateExcel(ExportExcelReqDto eer) {
		boolean rtnValue = true;

		// get temp path
		String fileTempPath = eer.getRealPath();
		File file = new File(fileTempPath);
		if (!file.isDirectory()) {
			file.mkdirs();
		}

		String xlsxName = eer.getFileName();

		FileOutputStream os = null;
		Writer fw = null;
		FileOutputStream out = null;
		List<String> sheetRefList = new ArrayList<String>();

		try {
			int idx = 1;
			XSSFWorkbook wb = new XSSFWorkbook();
			for (ExportExcelSheetReqDto sheetData : eer.getSheetList()) {
				String sheetName = sheetData.getSheetName();

				// Step 1. Create a template file. Setup sheets and
				// workbook-level objects such as
				// cell styles, number formats, etc.
				Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);
				XSSFSheet sheet = wb.createSheet(sheetName);

				// name of the zip entry holding sheet data, e.g.
				// /xl/worksheets/sheet1.xml
				sheetRefList.add(sheet.getPackagePart().getPartName().getName());

				// Step 2. Generate XML file.
				File tmp = new File(fileTempPath + "/dataXml/", sheetName + ".xml");
				if (!tmp.getParentFile().isDirectory()) {
					tmp.getParentFile().mkdirs();
				}

				tmp.createNewFile();

				fw = new OutputStreamWriter(new FileOutputStream(tmp), XML_ENCODING);
				generateSheet(fw, styles, sheetData);
				fw.close();
				wb.close();
				idx++;
			}

			String tmpXlsx = fileTempPath + "/template.xlsx";
			String outXlsx = fileTempPath + "/" + xlsxName + ".xlsx";
			idx = 0;
			for (String sheetRef : sheetRefList) {
				// create template xlsx
				if (idx == 0) {
					// save the template
					os = new FileOutputStream(tmpXlsx);
					wb.write(os);
					os.close();
				} else {
					FileInputStream in = new FileInputStream(outXlsx);
					out = new FileOutputStream(tmpXlsx);
					copyStream(in, out);
					in.close();
					out.close();
				}

				String sheetName = eer.getSheetList().get(idx).getSheetName();

				// xml file
				File xmlFile = new File(fileTempPath + "/dataXml/", sheetName + ".xml");

				// tmp file
				File tmpFile = new File(tmpXlsx);

				// Step 3. Substitute the template entry with the generated data
				out = new FileOutputStream(outXlsx);
				substitute(tmpFile, xmlFile, sheetRef.substring(1), out);
				out.close();

				idx++;
			}
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e.toString(), e);

			rtnValue = false;

		} catch (FileNotFoundException e) {
			LogUtil.error(e.toString(), e);

			rtnValue = false;

		} catch (IOException e) {
			LogUtil.error(e.toString(), e);

			rtnValue = false;

		} finally {

			try {
				if (os != null)
					os.close();
				if (fw != null)
					fw.close();
				if (out != null)
					out.close();

			} catch (IOException e) {
				LogUtil.error(e.toString(), e);
			}
		}

		return rtnValue;
	}

	/**
	 * @return :
	 * @name : generateSheet
	 * @date : 2016. 8. 10.
	 * @author : 류동균
	 * @description : generate Sheet
	 */
	private static void generateSheet(Writer out, Map<String, CellStyle> styles, ExportExcelSheetReqDto eer) {

		SpreadsheetWriter sw = new SpreadsheetWriter(out);
		try {
			sw.beginWorkSheet();
			// column size
			List<SfExcelAttribute> customCellSizeList = new ArrayList<>();

			for (int i = 0; i < eer.getHeaderList().size(); i++) {
				customCellSizeList.add(new SfExcelAttribute(i + 1, i + 1, 15, i + 1));
			}

			sw.customCell(customCellSizeList);
			sw.beginSheet();

			// insert header row
			sw.insertRow(0);
			int styleIndex = styles.get("header").getIndex();
			int index = 0;
			for (String name : eer.getHeaderList()) {
				sw.createCell(index++, name, styleIndex);
			}
			sw.endRow();

			// insert row / create cell data
			int rownum = 1;
			for (List<String> rows : eer.getDataList()) {
				sw.insertRow(rownum++);

				int cellnum = 0;
				for (String str : rows) {
					sw.createCell(cellnum++, str);
				}

				sw.endRow();
			}

			sw.endSheet();

			// end
			sw.endWorkSheet();

			LogUtil.info("dataMergeList SIZE : " + rownum);
		} catch (IOException e) {
			LogUtil.error(e);
		}
	}


	public void generate(Writer out, Map<String, XSSFCellStyle> styles, List<Map<String, Object>> dataList) throws Exception {

		SpreadsheetWriter sw = new SpreadsheetWriter(out);
		sw.beginSheet();

		// insert header row
		sw.insertRow(0);
		int styleIndex = styles.get("header").getIndex();

		sw.createCell(0, "디렉토리", styleIndex);
		sw.createCell(1, "파일명", styleIndex);
		sw.createCell(2, "탐지번호", styleIndex);
		sw.createCell(3, "탐지원인 탐지코드", styleIndex);
		sw.createCell(4, "탐지결과 번호", styleIndex);
		sw.createCell(5, "탐지결과 탐지코드", styleIndex);

		sw.endRow();

		// insert ROW / CELL DATA
		int rownum = 1;
		for (Map<String, Object> dataMap : dataList) {
			sw.insertRow(rownum);
			Iterator<Entry<String, Object>> entries = dataMap.entrySet().iterator();
			int cellNo = 0;
			while (entries.hasNext()) {
				Entry<?, ?> thisEntry = entries.next();
				Object key = thisEntry.getKey();
				sw.createCell(cellNo, (String) key);
				cellNo++;
			}

			sw.endRow();
			rownum++;
		}

		sw.endSheet();
	}


	/**
	 * 확장자에 따른 엑셀 이미지 타입
	 *
	 * @param imageExtension
	 * @return
	 */
	static public Integer getPictureType(String imageExtension) {
		String tempImageExtension = imageExtension;
		if (ObjectUtil.isNotEmpty(tempImageExtension)) {
			tempImageExtension = tempImageExtension.toUpperCase();

			switch (tempImageExtension) {
				case "PNG":
					return Workbook.PICTURE_TYPE_PNG;

				case "JPEG":
				case "JPG":
					return Workbook.PICTURE_TYPE_JPEG;
				default:

			}


		}
		return -1;
	}

}