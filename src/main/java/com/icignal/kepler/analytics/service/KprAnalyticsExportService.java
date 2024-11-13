
package com.icignal.kepler.analytics.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.common.util.*;
import org.apache.commons.codec.binary.Base64;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.util.Units;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFCreationHelper;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFPicture;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.BreakType;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.springframework.stereotype.Service;

import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analytics.dto.request.KprAnalyticsExportReqDto;
import com.icignal.kepler.common.service.KprCommonService;


/*
 * 1. 클래스명	: KPRAnalyticsExportService
 * 2. 파일명	: KPRAnalyticsExportService.java
 * 3. 패키지명	: com.icignal.kepler.analytics.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service(value = "KprAnalyticsExportService")
public class KprAnalyticsExportService  {

	/**
	 * 파일 Export 용 enumerate
	 */
	private enum EXPORT_FILE_EXTENSION {
		EXCEL("XLSX"), WORD("DOCX"), HWP("HML");

		final private String extension;

		private EXPORT_FILE_EXTENSION(String extension) {
			this.extension = extension;
		}

		public String getExtension() {
			return extension;
		}
	}

	 /*
	  * 1. 메소드명: getAnalyticsExportData
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 08. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석 데이터 Export
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param req
	 *   @param res
	 *   @param aer
	 *   @return
	 *   @throws Exception	
	 */
	public String getAnalyticsExportData(HttpServletRequest req, HttpServletResponse res, KprAnalyticsExportReqDto aer) throws Exception {
		LogUtil.param(KprCommonService.class, aer);
		String exportType = aer.getExportType();
		String filePath = req.getSession().getServletContext().getRealPath("/") + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path");
		String fileFullPath = null;

		// EXCEL, WORD, HWP 파일만 Export 처리
		if (KprAnalysisConstants.EXPORT_TYPE.EXCEL.name().equals(exportType)) {
			fileFullPath = this.setAnalyticsExportEXCEL(aer, filePath);
		} else if (KprAnalysisConstants.EXPORT_TYPE.WORD.name().equals(exportType)) {
			fileFullPath = this.setAnalyticsExportWORD(aer, filePath);
		} else {
			fileFullPath = this.setAnalyticsExportHWP(aer, filePath);
		}
		return fileFullPath;
	}

	 /*
	  * 1. 메소드명: setAnalyticsExportEXCEL
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 파일 생성 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer  - 엑셀 생성에 필요한 데이터가 담긴 오브젝트
	 *   @param filePath  - 파일 생성 위치
	 *   @return String - 생성된 파일명
	 *   @throws Exception	
	 */
	private String setAnalyticsExportEXCEL(KprAnalyticsExportReqDto aer, String filePath) throws Exception {
		FileOutputStream fos = null;
		XSSFWorkbook thisWorkbook = null;
		String fileFullPath = null;
		try {	
		// 디렉토리가 없을 경우 디렉토리 생성
		File fileDir = new File(filePath);
		if (!fileDir.isDirectory()) {
			fileDir.mkdirs();
		}

		// 엑셀 파일 생성
		String fileName = this.getFileName(aer.getFileName(), EXPORT_FILE_EXTENSION.EXCEL.getExtension());
		fileFullPath = filePath + fileName;

		// 엑셀 관련 Workbook 생성
		thisWorkbook = new XSSFWorkbook();
		// 스타일 설정
		Map<String, CellStyle> styles = ExcelStyles.createStyles(thisWorkbook);

		// Export 할 데이터 설정
		List<KprAnalyticsExportReqDto> exportDataList = aer.getExportDataList();
		if (exportDataList.size() > 0) {
			for (KprAnalyticsExportReqDto exportData : exportDataList) {
				// Sheet 명 설정
				String targetName = this.convertFileName(exportData.getTargetName());
				if (targetName.length() > 31) {
					targetName = targetName.substring(0, 30);
				}

				// Sheet 생성
				XSSFSheet thisSheet = thisWorkbook.createSheet(targetName);
				String analyticsTypeCode = exportData.getAnalyticsTypeCode();

				// 테이블이라면, 테이블 정보를 가져와 처리
				if (KprAnalysisConstants.ANALYSIS_TYPE.TABLE.name().equals(analyticsTypeCode)) {
					Integer rowCnt = 0;
					List<List<KprAnalyticsExportReqDto>> tableRowList = exportData.getTableRowList();
					if (tableRowList.size() > 0) {
						for (List<KprAnalyticsExportReqDto> tableRow : tableRowList) {
							XSSFRow thisRow = thisSheet.createRow(rowCnt++);

							if (tableRow.size() > 0) {
								for (KprAnalyticsExportReqDto tableCol : tableRow) {
									XSSFCell thisCell = thisRow.createCell(tableCol.getColAddr());
									Boolean strongFlag = tableCol.getStrongFlag();
									Boolean alignFlag = tableCol.getAlignFlag();

									// style 을 지정하기 위해 cellType 설정
									String cellType = null;
									if (strongFlag && alignFlag) {
										cellType = "SV"; // summary value
															// 굵게, 오른쪽 정렬
									} else if (strongFlag && !alignFlag) {
										cellType = "NH"; // normal header
															// 굵게
									} else {
										cellType = "NV"; // normal value
															// 오른쪽 정렬
									}
									thisCell.setCellStyle(styles.get(cellType));

									// 현재 값이 빈 값이 아니고, SV 혹은 NV 라면
									// 숫자 값이므로 쉼표 제거 후 Double 형태로 변경
									String thisValue = tableCol.getColValue();
									if (ObjectUtil.isNotEmpty(thisValue)) {
										if ("NV".equals(cellType) || "SV".equals(cellType)) {
											try{
											Double value = Double.parseDouble(thisValue.replaceAll(",", ""));
											thisCell.setCellValue(value);
											}catch(Exception e){
												thisCell.setCellValue(thisValue);
											}
										} else {
											thisCell.setCellValue(thisValue);
										}
									}

									// 셀 병합을 처리하기 위해 설정
									Integer colAddr = tableCol.getColAddr();
									Integer rowAddr = tableCol.getRowAddr();
									Integer colSpan = tableCol.getColSpan();
									Integer rowSpan = tableCol.getRowSpan();
									if (colSpan > 0 || rowSpan > 0) {
										thisSheet.addMergedRegion(new CellRangeAddress(rowAddr, rowAddr + rowSpan, colAddr, colAddr + colSpan));
									}
								}
							}
						}
					}
				} else {
					// 차트 이미지 설정
					String imageExtension = exportData.getImageExtension();
					String imageBinaryData = exportData.getImageBinaryData();
					byte[] imageBytes = Base64.decodeBase64(imageBinaryData.getBytes());

					Integer imageIdx = thisWorkbook.addPicture(imageBytes, WordUtil.getPictureType(imageExtension));
					XSSFCreationHelper helper = thisWorkbook.getCreationHelper();
					XSSFDrawing drawing = thisSheet.createDrawingPatriarch();
					XSSFClientAnchor clientAnchor = helper.createClientAnchor();
					// 차트 위치 설정. A1:O30 에 설정
					clientAnchor.setCol1(0);
					clientAnchor.setRow1(0);
					clientAnchor.setCol2(15);
					clientAnchor.setRow2(30);

					// 이미지 배경색 조정
					XSSFPicture thisPicture = drawing.createPicture(clientAnchor, imageIdx);
					thisPicture.setFillColor(255, 255, 255);
				}
			}
		}

		// 엑셀 파일 생성
		File thisFile = new File(fileFullPath);
		if (!thisFile.isFile()) {
			thisFile.createNewFile();
		}

		// 파일에 설정한 내용을 저장
		fos = new FileOutputStream(thisFile);
		thisWorkbook.write(fos);
		
	  } finally {
			fos.close();
			thisWorkbook.close();
	  }
		return fileFullPath;
	}

	 /*
	  * 1. 메소드명: setAnalyticsExportWORD
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		워드 파일 생성 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer  - 워드 생성에 필요한 데이터가 담긴 오브젝트
	 *   @param filePath - 파일 생성 위치
	 *   @return String - 생성된 파일명
	 *   @throws Exception	
	 */
	private String setAnalyticsExportWORD(KprAnalyticsExportReqDto aer, String filePath) throws Exception {
		FileOutputStream fos = null;
		XWPFDocument thisDocument = null;
		String fileFullPath  = null;
		try {
			// 디렉토리가 없을 경우 디렉토리 생성
			File fileDir = new File(filePath);
			if (!fileDir.isDirectory()) {
				fileDir.mkdirs();
			}
	
			// 엑셀 파일 생성
			String fileName = this.getFileName(aer.getFileName(), EXPORT_FILE_EXTENSION.WORD.getExtension());
			fileFullPath = filePath + fileName;
	
			thisDocument = new XWPFDocument();
			// Export 할 데이터 설정
			List<KprAnalyticsExportReqDto> exportDataList = aer.getExportDataList();
			if (exportDataList.size() > 0) {
				Boolean pageBreak = false;
				for (KprAnalyticsExportReqDto exportData : exportDataList) {
					XWPFParagraph thisParagraph = thisDocument.createParagraph();
					XWPFRun thisRun = thisParagraph.createRun();
	
					// 페이지 분할 처리 여부
					// 처음이면 pageBreak 값이 false 이므로 페이지 분할을 하지 않음
					if (pageBreak) {
						thisRun.addBreak(BreakType.PAGE);
					} else {
						pageBreak = true;
					}
	
					// 굵게 처리와 텍스트 값 입력
					thisRun.setBold(true);
					thisRun.setText(exportData.getTargetName());
	
					// 분석 타입에 따라 다른 처리
					String analyticsTypeCode = exportData.getAnalyticsTypeCode();
					if (KprAnalysisConstants.ANALYSIS_TYPE.TABLE.name().equals(analyticsTypeCode)) {
						Integer colCnt = exportData.getTotalColCnt();
						Integer rowCnt = exportData.getTotalRowCnt();
	
						// 워드 테이블 생성
						XWPFTable thisTable = thisDocument.createTable(rowCnt, colCnt);
						List<List<KprAnalyticsExportReqDto>> tableRowList = exportData.getTableRowList();
						if (tableRowList.size() > 0) {
							for (List<KprAnalyticsExportReqDto> tableRow : tableRowList) {
								if (tableRow.size() > 0) {
									for (KprAnalyticsExportReqDto tableCol : tableRow) {
										// 현재 Cell 의 위치를 찾아서, 굵게 처리와 오른쪽 정렬 여부처리
										Integer colAddr = tableCol.getColAddr();
										Integer rowAddr = tableCol.getRowAddr();
	
										XWPFTableCell thisCell = thisTable.getRow(rowAddr).getCell(colAddr);
										XWPFParagraph cellParagraph = thisCell.addParagraph();
										XWPFRun cellRun = cellParagraph.createRun();
	
										Boolean strongFlag = tableCol.getStrongFlag();
										Boolean alignFlag = tableCol.getAlignFlag();
	
										if (strongFlag) {
											cellRun.setBold(true);
										}
										if (alignFlag) {
											cellParagraph.setAlignment(ParagraphAlignment.RIGHT);
										}
	
										// Cell Merge 설정
										Integer colSpan = tableCol.getColSpan();
										Integer rowSpan = tableCol.getRowSpan();
										if (colSpan > 0) {
											WordUtil.mergeCellHorizontally(thisTable, rowAddr, colAddr, colAddr + colSpan);
										}
										if (rowSpan > 0) {
											WordUtil.mergeCellVertically(thisTable, colAddr, rowAddr, rowAddr + rowSpan);
										}
	
										cellRun.setText(tableCol.getColValue());
									}
								}
							}
						}
					} else {
						// 이미지 설정
						String imageBinaryData = exportData.getImageBinaryData();
						ByteArrayInputStream bais = new ByteArrayInputStream(Base64.decodeBase64(imageBinaryData.getBytes()));
	
						String imageExtension = exportData.getImageExtension();
						Integer imageType = WordUtil.getPictureType(imageExtension);
						String imageId = exportData.getImageId();
	
						thisRun.addPicture(bais, imageType, imageId + "." + imageExtension, Units.toEMU(WordUtil.WORD_IMAGE_FIXVALUE), Units.toEMU(WordUtil.WORD_IMAGE_FIXVALUE));
						bais.close();
					}
				}
			}
	
			// 워드 파일 생성
			File thisFile = new File(fileFullPath);
			if (!thisFile.isFile()) {
				thisFile.createNewFile();
			}
	
			// 파일에 설정한 내용을 저장
			fos = new FileOutputStream(thisFile);
			thisDocument.write(fos);
		} finally {
			fos.close();
			thisDocument.close();
		}
		return fileFullPath;
	}

	 /*
	  * 1. 메소드명: setAnalyticsExportHWP
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		한글 파일 생성 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer - 워드 생성에 필요한 데이터가 담긴 오브젝트
	 *   @param filePath - 파일 생성 위치
	 *   @return String - 생성된 파일명
	 *   @throws Exception	
	 */
	private String setAnalyticsExportHWP(KprAnalyticsExportReqDto aer, String filePath) throws Exception {
		
		String fileFullPath = null;
		OutputStreamWriter osw = null;
		FileOutputStream fos = null;
		try {
			// 디렉토리가 없을 경우 디렉토리 생성
			File fileDir = new File(filePath);
			if (!fileDir.isDirectory()) {
				fileDir.mkdirs();
			}
	
			// 한글 파일 생성
			String fileName = this.getFileName(aer.getFileName(), EXPORT_FILE_EXTENSION.HWP.getExtension());
			fileFullPath = filePath + fileName;
	
			// export 할 데이터가 있는지 체크
			List<KprAnalyticsExportReqDto> exportDataList = aer.getExportDataList();
			Boolean exportDataFlag = ObjectUtil.isNotEmpty(exportDataList);
	
			// 파일 생성
			File thisFile = new File(fileFullPath);
			if (!thisFile.isFile()) {
				thisFile.createNewFile();
			}
			fos = new FileOutputStream(thisFile);
			osw = new OutputStreamWriter(fos, HWPUtil.XML_ENCODING);
	
			// HML 문서는 최상위에 ROOT 엘리먼트
			// 그 하위로 HEAD, BODY, TAIL이 있으며
			// 각각의 엘리먼트 하위로도 엘리먼트들이 존재
			HWPUtil.openRoot(osw);
			HWPUtil.openHead(osw, 0);
			HWPUtil.openMappingTable(osw);
	
			// HML 문서에서 이미지는 총 3부분으로 나누어 저장하는데
			// HEAD 에는 이미지의 확장자 및 이미지 아이디를 설정
			// BODY 에는 실제 이미지의 사이즈 및 위치
			// TAIL 에는 이미지의 Binary 데이터를 설정함.
			// Binary 데이터는 Base64 형태의 문자열
			Integer imageCnt = aer.getImageCnt();
			if (exportDataFlag && imageCnt > 0) {
				HWPUtil.openBinDataList(osw, imageCnt);
				for (KprAnalyticsExportReqDto exportData : exportDataList) {
					String analyticsTypeCode = exportData.getAnalyticsTypeCode();
	
					if (KprAnalysisConstants.ANALYSIS_TYPE.CHART.name().equals(analyticsTypeCode)) {
						HWPUtil.createBinItem(osw, exportData.getImageId(), exportData.getImageExtension());
					}
				}
	
				HWPUtil.closeBinDataList(osw);
			}
	
			// 필수 설정들 추가
			// Hard Coding 으로 처리해놓음
			// 여기서 추가하는 내용 외에 추가하는 내용은 없다고 봄
			HWPUtil.createFontList(osw);
			HWPUtil.createBorderFillList(osw);
			HWPUtil.createCharShapeList(osw);
			HWPUtil.createParaShapeList(osw);
	
			HWPUtil.closeMappingTable(osw);
			HWPUtil.closeHead(osw);
	
			HWPUtil.openBoby(osw);
			HWPUtil.openSection(osw, 1);
	
			if (exportDataFlag) {
				Boolean pageBreak = true;
				for (KprAnalyticsExportReqDto exportData : exportDataList) {
					HWPUtil.openText(osw, true, false, 0, 0);
					
					// 페이지를 가로로 할것인지, 세로로 할것인지 설정
					if (pageBreak) {
						HWPUtil.setHWPPageLandscape(osw, 0);
						pageBreak = false;
					}
	
					String analyticsTypeCode = exportData.getAnalyticsTypeCode();
					HWPUtil.createText(osw, exportData.getTargetName());
	
					// 테이블 생성
					if (KprAnalysisConstants.ANALYSIS_TYPE.TABLE.name().equals(analyticsTypeCode)) {
						HWPUtil.openTable(osw, exportData.getTotalWidth() * 30, exportData.getTotalHeight() * 30, HWPUtil.HWPML_PRE_OFFSET, 0, exportData.getTotalRowCnt(),
								exportData.getTotalColCnt());
	
						List<List<KprAnalyticsExportReqDto>> tableRowList = exportData.getTableRowList();
						if (tableRowList.size() > 0) {
							for (List<KprAnalyticsExportReqDto> tableRow : tableRowList) {
								HWPUtil.openRow(osw);
	
								if (tableRow.size() > 0) {
									for (KprAnalyticsExportReqDto tableCol : tableRow) {
										Integer width = (tableCol.getColWidth() * HWPUtil.HWPML_PAGE_WIDTH) / exportData.getTotalWidth();
										// 한글은 colSpan 및 rowSpan 의 최소값이 1이므로 +1를 해줌
										HWPUtil.openCell(osw, tableCol.getColAddr(), tableCol.getRowAddr(), tableCol.getColSpan() + 1, tableCol.getRowSpan() + 1, width, tableCol.getColHeight());
										Boolean strongFlag = tableCol.getStrongFlag();
										Boolean alignFlag = tableCol.getAlignFlag();
	
										Integer strongValue = 1;
										Integer alignValue = 0;
										if (strongFlag) {
											strongValue = 0;
										}
	
										if (alignFlag) {
											alignValue = 1;
										}
										
										// 실제 값 설정
										HWPUtil.openText(osw, false, true, strongValue, alignValue);
										HWPUtil.createText(osw, tableCol.getColValue());
										HWPUtil.closeText(osw);
										HWPUtil.closeCell(osw);
									}
								}
	
								HWPUtil.closeRow(osw);
							}
						}
						HWPUtil.closeTable(osw);
					} else {
						// 이미지 설정
						Integer width = (HWPUtil.HWPML_PAGE_WIDTH / exportData.getImageWidth()) * exportData.getImageWidth();
						Integer height = (HWPUtil.HWPML_PAGE_WIDTH / exportData.getImageHeight()) * exportData.getImageHeight();
	
						HWPUtil.createPicture(osw, exportData.getImageId(), exportData.getImageWidth(), exportData.getImageHeight(), width, height, HWPUtil.HWPML_PRE_OFFSET, 0);
					}
	
					HWPUtil.closeText(osw);
				}
			} else {
				HWPUtil.closeText(osw);
			}
	
			HWPUtil.closeSection(osw);
			HWPUtil.closeBody(osw);
	
			HWPUtil.openTail(osw);
	
			if (exportDataFlag && imageCnt > 0) {
				HWPUtil.openBinDataStorage(osw);
	
				for (KprAnalyticsExportReqDto exportData : exportDataList) {
					String analyticsTypeCode = exportData.getAnalyticsTypeCode();
	
					if (KprAnalysisConstants.ANALYSIS_TYPE.CHART.name().equals(analyticsTypeCode)) {
						HWPUtil.createBinData(osw, exportData.getImageId(), exportData.getImageEncoding(), exportData.getImageSize(), exportData.getImageBinaryData());
					}
				}
	
				HWPUtil.closeBinDataStorage(osw);
			}

		} finally {
			HWPUtil.closeTail(osw);
			HWPUtil.closeRoot(osw);

			osw.close();
			fos.close();

		}
		return fileFullPath;
	}

	 /*
	  * 1. 메소드명: getFileName
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		파일명 변경 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param fileName - 변경할 파일명
	 *   @param fileExtension - 파일 확장자
	 *   @return String - 윈도우에서 사용할 수 있는 파일명
	 */
	private String getFileName(String fileName, String fileExtension) {
		String resFileName = this.convertFileName(fileName);
		String systemTime = String.valueOf(System.currentTimeMillis());
		resFileName = resFileName + "_" + systemTime + "." + fileExtension;

		return resFileName;
	}

	 /*
	  * 1. 메소드명: convertFileName
	  * 2. 클래스명: KPRAnalyticsExportService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		파일명 변경 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param fileName - 변경할 파일명
	 *   @return String - 윈도우에서 사용할 수 있는 파일명
	 */
	private String convertFileName(String fileName) {
		String tempFileName = fileName;
		tempFileName = fileName.replaceAll(" ", "_");
		tempFileName = fileName.replaceAll("\\[", "_");
		tempFileName = fileName.replaceAll("\\]", "_");
		tempFileName = fileName.replaceAll("\\\\", "_");
		tempFileName = fileName.replaceAll("/", "_");
		tempFileName = fileName.replaceAll("[*]", "_");
		tempFileName = fileName.replaceAll("\\?", "_");

		return tempFileName;
	}
}
