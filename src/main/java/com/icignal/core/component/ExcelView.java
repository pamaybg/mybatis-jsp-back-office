/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: ExcelView.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 8:48:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.core.component;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.common.util.ExcelStyles;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.response.ExcelMetaDataResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.ExcelUtil;
import com.icignal.common.util.LogUtil;

/*
 * 1. 클래스명	: ExcelView
 * 2. 파일명	: ExcelView.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *		spring mvc -> spring boot 컨버전으로 인한 로직 수정
 *		Excel Down ModelAndView
 *
 * 2. 참고
 * 		개인정보 들어간 ExcelDownLoad는 PersonalDataExcelView로 바꿔야합니다.
 * </PRE>
 */
@Component("ExcelView")
public class ExcelView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * excelData : { fileName : header : "JSON String", body : [ ] }
		 * 
		 */
		Map<String, Object> excelMap = new HashMap<>();
		Object replaceHeaderData = model.get("excelHeader").toString().replaceAll("&nbsp;", " ");
		excelMap.put("excelHeader", replaceHeaderData);
		String headerType = (String) model.get("headerType");

		if ("LIST".equals(model.get("type"))) { // 값을 GridList가 아닌 List형태로 가져올경우
			excelMap.put("excelData", model.get("result"));
		} else {
			excelMap.put("excelData", ((GridPagingResDto) model.get("result")).getRows());
		}
//        excelMap.put("excelFooter" , model.get("excelFooter"));

		ExcelViewHelper excel = new ExcelViewHelper((String) model.get("fileName")); /* 확장자가 없음 */

		response.setHeader("Content-Disposition","attachment; filename=\"" + excel.getEncodeFileName() + "_" + excel.getCurrentDate() + ".xlsx\"");
		response.setContentType("application/vnd.ms-excel");

		// local "user.dir" 경로 : C:\Users\Quintet\Documents\iCIGNAL_LOYALTY_T10_Beta/
		// Real "user.dir" 경로 : /app/adimn
		//String applicationFilePath = System.getProperty("user.dir");
		String applicationFilePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath");
		File folder= new File(applicationFilePath);
		
		if (!folder.exists()) {
			folder.mkdirs(); //폴더 생성합니다.
		}

		// EXCEL_CREATE_TYPE
		String excelType = (String) model.get("excelType");
		List<ExcelMetaDataResDto> metaDataList = new ArrayList<ExcelMetaDataResDto>();
		if(excelType != null) {
			ObjectMapper om = new ObjectMapper();
			metaDataList = om.readValue((String) excelMap.get("excelHeader"), new TypeReference<List<ExcelMetaDataResDto>>() {});
		}

		//일반 엑셀 다운로드
		if (excelType==null) {
			// excel.getPathFileName() : resources/UploadFile/{fileName} ,
			// excel.getFileName() : /{fileName}
			// File templateFile = new File(DevPath + File.separator + excel.getPathFileName() + "_temp.xlsx");
			// File xmlFile = new File(DevPath + File.separator + excel.getPathFileName() + "_temp.xml");
			File templateFile = new File(applicationFilePath+ File.separator + excel.getFileName() + "_temp.xlsx");
			File xmlFile = new File(applicationFilePath+ File.separator + excel.getFileName() + "_temp.xml");

			Writer fw = null;
			FileOutputStream os = null;
			XSSFWorkbook wb = new XSSFWorkbook();

			try {

				XSSFSheet sheet = wb.createSheet(excel.getFileName());
				Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);

				os = new FileOutputStream(templateFile);
				wb.write(os);
				os.close();

				fw = new OutputStreamWriter(new FileOutputStream(xmlFile), ExcelUtil.XML_ENCODING);
//				if ("DB".equals(headerType)) {
//					ExcelUtil.getDBGenerate(fw, styles, excel.getFileName(), excelMap);
//				} else
				ExcelUtil.generate(fw, styles, excel.getFileName(), excelMap);

				fw.close();
				
				String sheetRef = sheet.getPackagePart().getPartName().getName().substring(1);
				ExcelUtil.substitute(templateFile, xmlFile, sheetRef, response.getOutputStream());

			} catch (IOException e) {
				LogUtil.error(e);
			} catch (Error e) {
				LogUtil.error(new Exception("메모리 부족으로 인한 엑셀 파일 생성 실패"));
			} finally {
				if (os != null)
					os.close();
				if (fw != null)
					fw.close();

				//임시 생성한 파일 삭제
				if (templateFile.isFile()) {
					templateFile.delete();
				}
				if (xmlFile.isFile()) {
					xmlFile.delete();
				}

				wb.close();
			}
		} else if("G".equals(excelType)) {
				File templateFile = new File(applicationFilePath+ File.separator + excel.getFileName() + "_temp.xlsx");
				File xmlFile = new File(applicationFilePath+ File.separator + excel.getFileName() + "_temp.xml");

				Writer fw = null;
				FileOutputStream os = null;
				SXSSFWorkbook wb = new SXSSFWorkbook(100);
				try {

					Sheet sheet = wb.createSheet(excel.getFileName());
					Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);

					os = new FileOutputStream(templateFile);
					wb.write(os);
					os.close();
					
					fw = new OutputStreamWriter(new FileOutputStream(xmlFile), ExcelUtil.XML_ENCODING);
					ExcelUtil.getDBGenerate(fw, styles, excel.getFileName(), excelMap);
					fw.close();
					
					String sheetRef = "xl/worksheets/sheet1.xml";
					ExcelUtil.substitute(templateFile, xmlFile, sheetRef, response.getOutputStream());

					wb.dispose();
					wb.close();
				} catch (IOException e) {
					LogUtil.error(e);
				} catch (Error e) {
					LogUtil.error(new Exception("메모리 부족으로 인한 엑셀 파일 생성 실패"));
				} finally {
					if (os != null)
						os.close();
					if (fw != null)
						fw.close();
					if (templateFile.isFile()) {
						templateFile.delete();
					}
					if (xmlFile.isFile()) {
						xmlFile.delete();
					}
					wb.close();
				}
		}
		else if ("T".equals(excelType)) { // 템플릿을 이용한 엑셀 다운로드

            String tempFilename = metaDataList.get(0).getTempFilePath();
            String tempStoredDir = applicationFilePath + "template/";
			File dir = new File(tempStoredDir);
			
			if (!dir.exists())
				dir.mkdirs();
			
			File storedFile = new File(tempFilename);
			FileInputStream inputStream = new FileInputStream(storedFile);
			// 2007 이후 버전(xlsx파일)
			XSSFWorkbook xworkbook = new XSSFWorkbook(inputStream);
			// 엑셀파일 저장경로
			FileOutputStream fileOut = new FileOutputStream(tempFilename + "_temp.xlsx", true); 
			
			try {
				// 현재 sheet
				XSSFSheet curSheet; 
				curSheet = xworkbook.getSheetAt(0);
				int row = curSheet.getPhysicalNumberOfRows();

				ExcelUtil.getTemplateGenerate(curSheet, row, excelMap);

				// 파일에 저장																
				xworkbook.write(fileOut);
				File templateFile = new File(tempFilename + "_temp.xlsx");
				ExcelUtil.substituteTemplate(templateFile, response.getOutputStream());
				
				if (templateFile.isFile()) {
					templateFile.delete();
				}
				xworkbook.close();
				inputStream.close();
				fileOut.close();
			} catch (IOException e) {
				LogUtil.error(e);

			} catch (Error e) {
				LogUtil.error(new Exception("메모리 부족으로 인한 엑셀 파일 생성 실패"));
			}
			finally {
				inputStream.close();
				xworkbook.close();
				fileOut.close();
			}
		}
	}
}
