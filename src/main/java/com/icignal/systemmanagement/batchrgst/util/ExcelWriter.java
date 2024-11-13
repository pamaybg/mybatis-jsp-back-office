package com.icignal.systemmanagement.batchrgst.util;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstUploadReqDto;



public class ExcelWriter {
	 public static void stampWiter(List<SystemBatchRgstUploadReqDto> list) {
	        // 워크북 생성
	        HSSFWorkbook workbook = new HSSFWorkbook();
	        // 워크시트 생성
	        HSSFSheet sheet = workbook.createSheet();
	        // 행 생성
	        HSSFRow row = sheet.createRow(0);
	        // 쎌 생성
	        HSSFCell cell;

	        // 헤더 정보 구성
	        cell = row.createCell(0);
	        cell.setCellValue("회원 아이디");

	        cell = row.createCell(1);
	        cell.setCellValue("적립 스탬프");

	        cell = row.createCell(2);
	        cell.setCellValue("적립차감 구분");

	        cell = row.createCell(3);
	        cell.setCellValue("회원번호");

	        // 리스트의 size 만큼 row를 생성
	        SystemBatchRgstUploadReqDto param =new SystemBatchRgstUploadReqDto();
	        for(int rowIdx=0; rowIdx < list.size(); rowIdx++) {
	            param = list.get(rowIdx);

	            // 행 생성
	            row = sheet.createRow(rowIdx+1);

	            cell = row.createCell(0);
	            cell.setCellValue(param.getMbrId());

	            cell = row.createCell(1);
	            cell.setCellValue(param.getReqPoint());

	            cell = row.createCell(2);
	            cell.setCellValue(param.getDedutionDiv());

	            cell = row.createCell(3);
	            cell.setCellValue(param.getMbrNo());

	        }

	        // 입력된 내용 파일로 쓰기
	        //File file = new File();

	        String fileName = "\\Downloads\\testWrite.xls";

	        File file = new File(System.getProperty ( "user.home" )+ fileName); //testwriter가 파일명

	        if(file != null && file.exists() && file.isFile()) {
			        FileOutputStream fos = null;
			        try {
			            fos = new FileOutputStream(file);
			            fos.write(workbook.getBytes());
			        } catch (FileNotFoundException e) {
			        	LogUtil.error(e);
			        } catch (IOException e) {
			        	LogUtil.error(e);
			        } finally {

			                if(workbook!=null){
			                	try {workbook.close();} catch (IOException e) {LogUtil.error(e);}
			                }
			                if(fos!=null){
			                	try { 	fos.close();} catch (IOException e2) {LogUtil.error(e2);}
			                }
			        }

	        }
	    }


	 public static void main(String[] args) {
		// System.out.println("ddd"+System.getProperty ( "user.home" ));

	}
}
