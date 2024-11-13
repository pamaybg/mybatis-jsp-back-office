package com.icignal.core.component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.common.util.*;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
/*
 * 1. 클래스명	: PersonalDataExcelView
 * 2. 파일명		: PersonalDataExcelView.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		개인정보 엑셀다운로드 암호화 처리 ExcelView
 * </PRE>
 */ 
@Component("PersonalDataExcelView")
public class PersonalDataExcelView extends AbstractView {
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	@Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
   
		
		HttpSession session = request.getSession(true);
		Map<String, Object> excelMap = new HashMap<String, Object>();
		String headerType = (String) model.get("headerType");
		
        excelMap.put("excelHeader" , model.get("excelHeader"));
        
        if("LIST".equals(model.get("type"))) {
        	excelMap.put("excelData" , model.get("result"));
        } else {
        	excelMap.put("excelData" , ((GridPagingResDto<?>)model.get("result")).getRows());
        }

        ExcelViewHelper excel = new ExcelViewHelper((String) model.get("fileName")); /* 확장자가 없음 */
        //excel =  currentData, encodeFileName, extension, fileName, path, pathFileName

        //response 의 날자 값과 personal-data 로 저장해야하는 값을 맞추기위해 변수에 저장한다.
        String CurrentData = excel.getCurrentDate();
        response.setHeader("Content-Disposition",  "attachment; filename=\"" + excel.getEncodeFileName() + "_" + CurrentData + ".xlsx\"");
        response.setContentType("application/vnd.ms-excel");
        
        //배포전 Local에서 사용
//        String realPath = request.getSession().getServletContext().getRealPath("/") 
//        		+ BeansUtil.getApplicationProperty("icignal.context.resource.personal-file-path");
        //배포후 실제 사용해야하는 경로
        String DevPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath")+"personalData/";
            
        String excelType = (String) model.get("excelType");
        String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
        
        File dir = new File(DevPath);		
		if(!dir.exists())  dir.mkdirs();
		
        File templateFile = new File(DevPath + excel.getFileName() +  "_" + CurrentData + "_temp.xlsx");
        File xmlFile = new File(DevPath + excel.getFileName() +  "_" + CurrentData + "_temp.xml");
        Writer fw = null;
		FileOutputStream os = null;
        //일반 엑셀 다운로드
      	if (excelType==null) {
            XSSFWorkbook wb = new XSSFWorkbook();

      		try {

            XSSFSheet sheet = wb.createSheet(excel.getFileName());
				Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);
            
            os = new FileOutputStream(templateFile);
            wb.write(os);
            fw = new OutputStreamWriter(new FileOutputStream(xmlFile), ExcelUtil.XML_ENCODING);
//            if(headerType == "DB") {
//            	ExcelUtil.getDBGenerate(fw, styles, excel.getFileName(), excelMap);
//            }else 
				ExcelUtil.generate(fw, styles, excel.getFileName(), excelMap);
            String sheetRef = sheet.getPackagePart().getPartName().getName();
            ExcelUtil.substitute(templateFile, xmlFile, sheetRef.substring(1), response.getOutputStream());

            //templateFile를  개인정보파일 암호화해서 보관처리 로직
            secuTemplateFile(templateFile, xmlFile, model, request);
            
        } catch (IOException e){
            LogUtil.error(e);
            
        } catch(Error e) {
        	LogUtil.error(new Exception("메모리 부족으로 인한 엑셀 파일 생성 실패"));
        } finally {
            os.close();
            fw.close();
            wb.close();
        }
        
    } else if("G".equals(excelType)) {
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
	
				secuTemplateFile(templateFile, xmlFile, model, request); 
			} catch (IOException e) {
				LogUtil.error(e);
			} catch (Error e) {
				LogUtil.error(new Exception("메모리 부족으로 인한 엑셀 파일 생성 실패"));
			} finally {
				wb.close();
				wb.dispose();
			}
	    }
	}
	
	 /*
	  * 1. 메소드명: secuTemplateFile
	  * 2. 클래스명: PersonalDataExcelView
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		templateFile를  개인정보파일 암호화해서 보관처리 로직
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param templateFile
	 *   @param xmlFile
	 *   @param model
	 *   @param request	
	 */
	public void secuTemplateFile(File templateFile, File xmlFile, Map<String, Object> model, HttpServletRequest request) {
		SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), templateFile , templateFile );
        SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), xmlFile , xmlFile );

        ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setDownFilePath(templateFile.toString());
        edlr.setTargetId((String) model.get("targetId"));
        edlr.setCreateBy((String) model.get("createBy")); 
        edlr.setModifyBy((String) model.get("modifyBy"));
        edlr.setLoyProgramId((String) model.get("LoyProgramId"));
        edlr.setLang((String) model.get("lang"));
        
        loggingHelper.addExcelDownloadLog(request, edlr, (EXCEL_DOWNLOAD_TYPE) model.get("excelDownlType"));
	}
}
