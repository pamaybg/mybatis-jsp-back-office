package com.icignal.systemmanagement.batchrgst.util;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.*;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.coupon.dto.response.LOYCpnPayUploadResDto;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.event.dto.request.LoyEvtApplctReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqUploadReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyCategoryGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpListReqDto;
import com.icignal.loyalty.product.dto.request.LoySetProdListReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTgtGrpXmListReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlItemReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstItemReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemUploadReqDto;
import com.icignal.systemmanagement.roadaddress.dto.request.RoadAddressReqDto;



public class ExcelRead {
	 public static List<Map<String, String>> read(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
		 //엑셀파일을 읽어 들인다.
		 //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

		 Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
		 /**
		  * 엑셀 파일에서 첫번째 시트를 가지고 온다.
		  */
		 Sheet sheet = wb.getSheetAt(0);

		 LogUtil.info("Sheet 이름: "+ wb.getSheetName(0));
		 LogUtil.info("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());

		 /**
		  * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		  */

		 int numOfRows = sheet.getPhysicalNumberOfRows();
		 int numOfCells = 0;

		 Row row = null;
		 Cell cell = null;

		 String cellName = "";
		 /**
		  * 각 row마다의 값을 저장할 맵 객체
		  * 저장되는 형식은 다음과 같다.
		  * put("A", "이름");
		  * put("B", "게임명");
		  */
		 Map<String, String> map = null;
		 /*
		  * 각 Row를 리스트에 담는다.
		  * 하나의 Row를 하나의 Map으로 표현되며
		  * List에는 모든 Row가 포함될 것이다.
		  */
		 List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		 /**
		  * 각 Row만큼 반복을 한다.
		  */
		 for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			 /*
			  * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			  * 하나의 Row는 여러개의 Cell을 가진다.
			  */

			 row = sheet.getRow(rowIndex);

			 if(row != null) {
				 /*
				  * 가져온 Row의 Cell의 개수를 구한다.
				  */
				 numOfCells = row.getPhysicalNumberOfCells();
				 /*
				  * 데이터를 담을 맵 객체 초기화
				  */
				 map = new HashMap<String, String>();
				 /*
				  * cell의 수 만큼 반복한다.
				  */
				 for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					 /*
					  * Row에서 CellIndex에 해당하는 Cell을 가져온다.
					  */
					 cell = row.getCell(cellIndex);


					 cell = row.getCell(cellIndex);

					 /*
					  * 현재 Cell의 이름을 가져온다
					  * 이름의 예 : A,B,C,D,......
					  */
					 cellName = ExcelCellRef.getName(cell, cellIndex);
					 /*
					  * 추출 대상 컬럼인지 확인한다
					  * 추출 대상 컬럼이 아니라면,
					  * for로 다시 올라간다
					  */
					 if( !excelReadOption.getOutputColumns().contains(cellName) ) {
						 continue;
					 }
					 /*
					  * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
					  */
					 map.put(cellName, ExcelCellRef.getValue(cell));
				 }
				 /*
				  * 만들어진 Map객체를 List로 넣는다.
				  */
				 result.add(map);
			 }
		 }
		 return result;
	 }

	 public static List<LoyEvtApplctReqDto> evnetWinnerRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    List<LoyEvtApplctReqDto> list = new ArrayList<LoyEvtApplctReqDto>();
	    
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	    List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyEvtApplctReqDto prodObj = new LoyEvtApplctReqDto();

	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getLastCellNum();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 회원번호
									prodObj.setMbrNo(cellValue);
									isLastCell = true;
									break;
								case 1:	// 혜택지급여부
									prodObj.setBnfYn(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
         			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		list.add(prodObj);
	        	}


     	}
 	}

 	return list;

	}


	 public static List<SystemBatchRgstUploadReqDto> stampRead(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    List<SystemBatchRgstUploadReqDto> list = new ArrayList<SystemBatchRgstUploadReqDto>();
	    

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	//    List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemBatchRgstUploadReqDto stmpObj = new SystemBatchRgstUploadReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 적립 스탬프
									stmpObj.setReqPoint(cellValue);
									break;

								case 1: // 적립차감 구분
									stmpObj.setDedutionDiv(cellValue);
									break;

								case 2: // 회원번호
									stmpObj.setMbrNo(cellValue);
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(stmpObj);
	        	}


        	}
    	}

    	return list;

	 }


	 public static List<SystemBatchRgstUploadReqDto> pntRead(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemBatchRgstUploadReqDto> list = new ArrayList<SystemBatchRgstUploadReqDto>();
	    wb.close();
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	 //   List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */


	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemBatchRgstUploadReqDto pntObj = new SystemBatchRgstUploadReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */

	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {

	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//테두리 있어도 내용이 빈값일때 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);
							cell.setCellType(CellType.STRING);


							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 구매일자
									pntObj.setPurchDate(cellValue);
									break;

								case 1: // 적립포인트
									pntObj.setReqPoint(cellValue);
									break;

								case 2: // 적립금액
									pntObj.setSaveMoney(cellValue);
									break;

								case 3: // 적립/차감 구분
									pntObj.setDedutionDiv(cellValue);
									break;

								case 4: // 회원번호
									pntObj.setMbrNo(cellValue);
									break;

								default:
									break;
							}

						}else{
							cell=null;
						}
					}else{
	            		cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	            if(cell!=null){
	            	list.add(pntObj);
	            }

        	}
    	}

    	return list;

	 }

//	 public static List<LOYUnRgstCardUploadListRequestDTO> cardRead(ExcelReadOption excelReadOption) {
//
//		 //엑셀 파일 자체
//	    //엑셀파일을 읽어 들인다.
//	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
//
//	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
//	    /**
//	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
//	     */
//	    Sheet sheet = wb.getSheetAt(0);
//	    List<LOYUnRgstCardUploadListRequestDTO> list = new ArrayList<LOYUnRgstCardUploadListRequestDTO>();
//
//	    /**
//	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
//	     */
//
//	    int numOfRows = sheet.getPhysicalNumberOfRows();
//	    int numOfCells = 0;
//
//	    Row row = null;
//	    Cell cell = null;
//
//	    String cellName = "";
//	    /**
//	     * 각 row마다의 값을 저장할 맵 객체
//	     * 저장되는 형식은 다음과 같다.
//	     * put("A", "이름");
//	     * put("B", "게임명");
//	     */
//	    Map<String, String> map = null;
//	    /*
//	     * 각 Row를 리스트에 담는다.
//	     * 하나의 Row를 하나의 Map으로 표현되며
//	     * List에는 모든 Row가 포함될 것이다.
//	     */
//	    List<Map<String, String>> result = new ArrayList<Map<String, String>>();
//	    /**
//	     * 각 Row만큼 반복을 한다.
//	     */
//
//
//	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
//	        /*
//	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
//	         * 하나의 Row는 여러개의 Cell을 가진다.
//	         */
//
//	    	row = sheet.getRow(rowIndex);
//	    	LOYUnRgstCardUploadListRequestDTO pntObj = new LOYUnRgstCardUploadListRequestDTO();
//	        if(row != null) {
//	            /*
//	             * 가져온 Row의 Cell의 개수를 구한다.
//	             */
//	            numOfCells = row.getPhysicalNumberOfCells();
//	            /*
//	             * 데이터를 담을 맵 객체 초기화
//	             */
//	            map = new HashMap<String, String>();
//	            /*
//	             * cell의 수 만큼 반복한다.
//	             */
//	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
//	            	//셀 빈값 체크
//	            	if(row.getCell(cellIndex)!=null){
//	            		//공백 체크
//	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
//	            			/*
//			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
//			                 */
//		            		cell = row.getCell(cellIndex);
//		            		cell.setCellType(CellType.STRING);
//
//
//			            	cell = row.getCell(cellIndex);
//
//			                /*
//			                 * 현재 Cell의 이름을 가져온다
//			                 * 이름의 예 : A,B,C,D,......
//			                 */
//			                cellName = ExcelCellRef.getName(cell, cellIndex);
//			                /*
//			                 * 추출 대상 컬럼인지 확인한다
//			                 * 추출 대상 컬럼이 아니라면,
//			                 * for로 다시 올라간다
//			                 */
//			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
//			                    continue;
//			                }
//			                /*
//			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
//			                 */
//
//			                String cellValue =  ExcelCellRef.getValue(cell);
//			                // 현재 column index에 따라서 vo에 입력
//		                    switch (cellIndex) {
//
//		                    case 0: // 카드번호
//		                    	cellValue = cellValue.replaceAll("-","");
//		                    	pntObj.setCardNum(cellValue);
//		                        break;
//
//		                    case 1: // 선지급금액
//		                    	pntObj.setPreSavePoint(cellValue);
//		                        break;
//
//		                    case 2: // 제품아이디
//		                    	pntObj.setProdId(cellValue);
//		                        break;
//
//		                    case 3: // 유효기간
//		                    	cellValue =  cellValue.replaceAll("-","");
//		                    	pntObj.setExpireDt(cellValue);
//		                        break;
//
//		                    default:
//		                        break;
//		                    }
//	            		}else{
//	            			cell=null;
//	            		}
//	            	}else{
//	            		cell=null;
//	            	}
//	            }
//	            /*
//	             * 만들어진 객체를 List로 넣는다.
//	             */
//	            if(cell!=null){
//	            	list.add(pntObj);
//	            }
//
//        	}
//    	}
//
//    	return list;
//
//	 }

	 /**
	* @programId :
	* @name : mbrRead
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return : List<SystemPntBatchRgstItemReqDto>
	 * @throws Exception
	* @description :
	*/
	public static List<SystemPntBatchRgstItemReqDto> mbrRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    


	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 회원번호
									stmpObj.setMbrNo(cellValue);
									break;

								case 1: // 적립포인트
									stmpObj.setAcrlAmt(cellValue);
									break;

								case 2: // 프로모션 캠페인코드
									stmpObj.setDispNo(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
//	        	if(cell!=null){
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		stmpObj.setTargetNm(null);
	        		stmpObj.setTargetHhpNo(null);

	        		list.add(stmpObj);
	        	}


        	}
    	}

    	return list;

	 }

	 /**
	* @programId :
	* @name : eventRead
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return : List<SystemPntBatchRgstItemReqDto>
	 * @throws Exception
	* @description :
	*/
	public static List<SystemPntBatchRgstItemReqDto> eventRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getLastCellNum();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // WEBID
									stmpObj.setWebId(cellValue);
									break;

								case 1: // 휴대폰번호
									stmpObj.setHhpNo(cellValue);
									break;

								case 2: // 회원명
									stmpObj.setCustNm(cellValue);
									break;

								case 3: // 적립포인트
									stmpObj.setAcrlAmt(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
//	        	if(cell!=null){
	        	if(isLastCell){
	        		//회원 데이터 clear
	        		stmpObj.setMbrNo(null);
//	        		stmpObj.setAcrlAmt(null);
	        		stmpObj.setValidStartDate(null);
	        		stmpObj.setValidEndDate(null);

	        		list.add(stmpObj);
	        	}


        	}
    	}

    	return list;

	 }

	/**
	* @programId :
	* @name : empRead
	* @date : 2019. 1. 16.
	* @author : hy.jun
	* @table :
	* @return : List<SystemPntBatchRgstItemReqDto>
	* @description :
	*/
	public static List<SystemPntBatchRgstItemReqDto> empRead(ExcelReadOption excelReadOption) throws Exception {

		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



		/**
		 * 엑셀 파일에서 첫번째 시트를 가지고 온다.
		 */
		Sheet sheet = wb.getSheetAt(0);
		List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
		wb.close();

		//  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
		//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */

		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;

		Row row = null;
		Cell cell = null;

		String cellName = "";
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		//List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		/**
		 * 각 Row만큼 반복을 한다.
		 */

		boolean isLastCell = false;
		for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

			isLastCell = false;

			/*
			 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			 * 하나의 Row는 여러개의 Cell을 가진다.
			 */

			row = sheet.getRow(rowIndex);
			SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
			if(row != null) {
				/*
				 * 가져온 Row의 Cell의 개수를 구한다.
				 */
				numOfCells = row.getPhysicalNumberOfCells();
				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


					//셀 빈값 체크
					if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 성명
									stmpObj.setTargetNm(cellValue);
									break;

								case 1: // 휴대폰번호(ex)01012345678)
									stmpObj.setTargetHhpNo(cellValue);
									break;

								case 2: // 적립포인트
									stmpObj.setAcrlAmt(cellValue);
									break;

								case 3: // 프로모션 캠페인코드
									stmpObj.setDispNo(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
						cell=null;
					}

				}
				/*
				 * 만들어진 객체를 List로 넣는다.
				 */
//	        	if(cell!=null){
				if(isLastCell){
					//회원 데이터 clear
					stmpObj.setMbrNo(null);
//	        		stmpObj.setAcrlAmt(null);
					stmpObj.setValidStartDate(null);
					stmpObj.setValidEndDate(null);

					list.add(stmpObj);
				}


			}
		}

		return list;

	}

	public static List<SystemPntBatchRgstItemReqDto> ciRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	    //List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // CI
									stmpObj.setCi(cellValue);
									break;

								case 1: // 적립포인트
									stmpObj.setAcrlAmt(cellValue);
									break;

								case 2: // 프로모션 캠페인코드
									stmpObj.setDispNo(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
           			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
//	        	if(cell!=null){
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		stmpObj.setTargetNm(null);
	        		stmpObj.setTargetHhpNo(null);

	        		list.add(stmpObj);
	        	}


       	}
   	}

   	return list;

	 }


	public static List<SystemPntBatchRgstItemReqDto> smsRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	  //  List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */

							cell = row.getCell(cellIndex);

							String dataCellValue ="";
							switch (cellIndex) {
								case 2:
									SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.KOREA);
									simpledateformat.format(new Date());

									dataCellValue = simpledateformat.format(cell.getDateCellValue());


									break;
								default:
									break;

							}


							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);





							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: //
									stmpObj.setApprovalNum(cellValue);
									break;

								case 1: //
									stmpObj.setTxnNum(cellValue);
									break;

								case 2: //
									stmpObj.setRequestDt(dataCellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
           			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
//	        	if(cell!=null){
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		stmpObj.setTargetNm(null);
	        		stmpObj.setTargetHhpNo(null);

	        		list.add(stmpObj);
	        	}


       	}
   	}

   	return list;

	 }
	public static List<SystemPntBatchRgstItemReqDto> hhpNoRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    


	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto stmpObj = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK
								&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							//개행문자 제거
							StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 전화번호
									stmpObj.setTargetHhpNo(cellValue);
									break;

								case 1: // 이름
									stmpObj.setTargetNm(cellValue);
									isLastCell = true;
									break;

								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
          			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
//	        	if(cell!=null){
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        	/*	stmpObj.setTargetNm(null);
	        		stmpObj.setTargetHhpNo(null);*/

	        		list.add(stmpObj);
	        	}


      	}
  	}

  	return list;

	 }


	public static List<LoySetProdListReqDto> prodRead(ExcelReadOption excelReadOption) throws Exception {
		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    


	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LoySetProdListReqDto> list = new ArrayList<LoySetProdListReqDto>();
	    wb.close();
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */
	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoySetProdListReqDto prodObj = new LoySetProdListReqDto();

	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */


	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
	            				&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                //개행문자 제거
			                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 브랜드유형
		                    	prodObj.setBrndType(cellValue);
		                    	isLastCell = true;
		                        break;
		                    case 1: //시리얼번호
		                    	prodObj.setSerialNo(cellValue);
		                    	isLastCell = true;
		                    	break;
		                    case 2: //색상
		                    	prodObj.setColor(cellValue);
		                    	isLastCell = true;
		                    	break;
		                    case 3: //기준년월
		                    	prodObj.setStanYearMonth(cellValue);
		                    	isLastCell = true;
		                    	break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
          			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		prodObj.setCatNm(null);
	        		prodObj.setBrdNm(null);
	        		prodObj.setChnlNm(null);

	        		list.add(prodObj);
	        	}


      	}
  	}
  	return list;

	}







	/**
	* @programId :
	* @name : surveyRead
	* @date : 2019. 9. 30.
	* @author : dw.keum
	* @table :
	* @return : List<SystemPntBatchRgstItemReqDto>
	* @description : 설문참여
	*/
	public static List<SystemPntBatchRgstItemReqDto> surveyRead(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    
	    

	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    List<SystemPntBatchRgstItemReqDto> list = new ArrayList<SystemPntBatchRgstItemReqDto>();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();

	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	 //   List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {

	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemPntBatchRgstItemReqDto pbri = new SystemPntBatchRgstItemReqDto();
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getLastCellNum();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
	            				&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                //개행문자 제거
			                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {
		                    case 0: // 회원번호
		                    	pbri.setMbrNo(cellValue);
		                        break;

		                    case 1: // 휴대폰번호
		                    	pbri.setHhpNo(cellValue);
		                        break;

		                    case 2: // 회원명
		                    	pbri.setCustNm(cellValue);
		                        break;

		                    case 3: // 적립포인트
		                    	pbri.setAcrlAmt(cellValue);
		                    	isLastCell = true;
		                        break;



		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
           			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		list.add(pbri);
	        	}


       	}
   	}

   	return list;

	 }

	 public static List<LoyFaqUploadReqDto> faqUploadRead(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    wb.close();


	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LoyFaqUploadReqDto> list = new ArrayList<LoyFaqUploadReqDto>();


	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyFaqUploadReqDto faqObj = new LoyFaqUploadReqDto();
	    	faqObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	faqObj.setFaqType(cellValue);
		                        break;

		                    case 1: // 카테고리 순번
		                    	if(StringUtil.isNumeric(cellValue)) {
		                    		faqObj.setSeq(cellValue);
		                    	}
		                    	else {
		                    		faqObj.setSeq(null);
		                    		//faqObj.setMessage(false);
		                    	}
		                        break;

		                    case 2: // 제목(faq)
		                    	faqObj.setFaqNm(cellValue);
		                        break;
		                    case 3: // 내용(faq)
		                    	faqObj.setFaqDesc(cellValue);
		                        break;

		                    case 4: // 개시예정일
		                    	if(StringUtil.isNumeric(cellValue) && cellValue.length() == 8) {
		                    		faqObj.setOpenDate(cellValue);
		                    	}
		                    	else {
		                    		faqObj.setOpenDate(null);
		                    	}
			                	break;
		                    case 5: // 상태
		                    	faqObj.setFaqStatus(cellValue);
		                        break;

		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(faqObj);
	        	}


        	}
    	}

    	return list;

	 }



		/**
		* @programId :
		* @name : msgUploadRead
		* @date : 2020. 01. 12.
		* @author : sh.park
		* @table :
		* @return : List<UploadReqDto>
		* @description :메시지 프로퍼티 업로드
		*/
	 public static List<SystemUploadReqDto> msgUploadRead(ExcelReadOption excelReadOption) throws Exception{

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    


	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<SystemUploadReqDto> list = new ArrayList<SystemUploadReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	  //  List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	SystemUploadReqDto msgObj = new SystemUploadReqDto();
	    	msgObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	msgObj.setCtg(cellValue);
		                        break;

		                    case 1: // 키

		                    	msgObj.setAttr(cellValue);
		                    	break;

		                    case 2: // 키value
		                    	msgObj.setAttrVal(cellValue);
		                    	break;
		                    case 3: // 내용(faq)
		                    	msgObj.setCreateBy(cellValue);
		                        break;

		                    case 4:
		                    	msgObj.setCreateDate(cellValue);

			                	break;
		                    case 5: // 상태
		                    	msgObj.setModifyBy(cellValue);
		                        break;

		                    case 6: // 상태
		                    	msgObj.setModifyDate(cellValue);
		                        break;

		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(msgObj);
	        	}


        	}
    	}

    	return list;

	 }

		public static List<KprTargetGroupItemReqDto> tgtGroupItemRead(ExcelReadOption excelReadOption) throws Exception {

			 //엑셀 파일 자체
		    //엑셀파일을 읽어 들인다.
		    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
		    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

		    /**
		     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
		     */
		    Sheet sheet = wb.getSheetAt(0);
		    wb.close();
		    /**
		     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		     */
		    int numOfRows = sheet.getPhysicalNumberOfRows();
		    int numOfCells = 0;

		    Row row = null;
		    Cell cell = null;

		    String cellName = "";

		    /*
		     * 각 Row를 리스트에 담는다.
		     * List에는 모든 Row가 포함될 것이다.
		     */
		    List<KprTargetGroupItemReqDto> list = new ArrayList<KprTargetGroupItemReqDto>();

		    /**
		     * 각 Row만큼 반복을 한다.
		     */
		    boolean isLastCell = false;
		    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
		    	isLastCell = false;

		        /*
		         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
		         * 하나의 Row는 여러개의 Cell을 가진다.
		         */
		    	row = sheet.getRow(rowIndex);
		    	KprTargetGroupItemReqDto prodObj = new KprTargetGroupItemReqDto();

		        if(row != null) {
		            /*
		             * 가져온 Row의 Cell의 개수를 구한다.
		             */
		            numOfCells = row.getPhysicalNumberOfCells();

		            /*
		             * cell의 수 만큼 반복한다.
		             */
		            for(int cellIndex = 0; cellIndex <= numOfCells; cellIndex++) {


		            	//셀 빈값 체크
		            	if(row.getCell(cellIndex)!=null){
		            		//공백 체크
		            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
						/*
						 * &&
						 * !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell),
						 * ""))
						 */){
		            			 /*
				                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
				                 */
			            		cell = row.getCell(cellIndex);

			            		if(cell.getCellType() == CellType.NUMERIC){
			            			if (HSSFDateUtil.isCellDateFormatted(cell)) {
			            				cell.setCellType(CellType.NUMERIC);
				            		}
			            			else{
			            				cell.setCellType(CellType.STRING);
			            			}
			            		}else{
			            			cell.setCellType(CellType.STRING);
			            		}


				            	cell = row.getCell(cellIndex);

				                /*
				                 * 현재 Cell의 이름을 가져온다
				                 * 이름의 예 : A,B,C,D,......
				                 */
				                cellName = ExcelCellRef.getName(cell, cellIndex);
				                /*
				                 * 추출 대상 컬럼인지 확인한다
				                 * 추출 대상 컬럼이 아니라면,
				                 * for로 다시 올라간다
				                 */
				                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
				                    continue;
				                }
				                /*
				                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
				                 */

				                String cellValue =  ExcelCellRef.getValue(cell);
				                //개행문자 제거
				                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

				                // 현재 column index에 따라서 vo에 입력
			                    switch (cellIndex) {

			                    case 0: // 회원번호
			                    	prodObj.setMemId(cellValue);
			                    	isLastCell = true;
			                        break;
			                    case 1: // attrib01
			                    	prodObj.setAttrib01(cellValue);
			                    	isLastCell = true;
			                        break;
			                    case 2: // attrib02
			                    	prodObj.setAttrib02(cellValue);
			                    	isLastCell = true;
			                    	break;
			                    case 3: // attrib03
			                    	prodObj.setAttrib03(cellValue);
			                    	isLastCell = true;
			                    	break;
//			                    case 4: // attrib04
//			                    	prodObj.setAttrib04(cellValue);
//			                    	isLastCell = true;
//			                    	break;
//			                    case 5: // attrib05
//			                    	prodObj.setAttrib05(cellValue);
//			                    	isLastCell = true;
//			                    	break;
			                    default:
			                        break;
			                    }
		            		}else{
		            			cell=null;
		            		}
		            	}else{
	       			cell=null;
		            	}

		            }
		            /*
		             * 만들어진 객체를 List로 넣는다.
		             */
		        	if(isLastCell){
		        		//이벤트 데이터 clear
		        		list.add(prodObj);
		        	}

		        }
			}

		    return list;

		}

	/**
	* @programId :
	* @name : offerJoinChnlItemRead
	* @date : 2020. 06. 13.
	* @author : jw.yu
	* @table :
	* @return : List<OfferJoinChnlItemReqDto>
	* @description : 오퍼 사용 가능채널 업로드
	*/
	public static List<OfferJoinChnlItemReqDto> offerJoinChnlItemRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */
	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";

	    /*
	     * 각 Row를 리스트에 담는다.
	     * List에는 모든 Row가 포함될 것이다.
	     */
	    List<OfferJoinChnlItemReqDto> list = new ArrayList<OfferJoinChnlItemReqDto>();

	    /**
	     * 각 Row만큼 반복을 한다.
	     */
	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */
	    	row = sheet.getRow(rowIndex);
	    	OfferJoinChnlItemReqDto prodObj = new OfferJoinChnlItemReqDto();

	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();

	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
	            				&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

		            		if(cell.getCellType() == CellType.NUMERIC){
		            			if (HSSFDateUtil.isCellDateFormatted(cell)) {
		            				cell.setCellType(CellType.NUMERIC);
			            		}
		            			else{
		            				cell.setCellType(CellType.STRING);
		            			}
		            		}else{
		            			cell.setCellType(CellType.STRING);
		            		}


			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                //개행문자 제거
			                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 채널번호
		                    	prodObj.setChnlId(cellValue);
		                    	isLastCell = true;
		                        break;
		                    case 1: // attrib01
		                    	prodObj.setAttrib01(cellValue);
		                    	isLastCell = true;
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
       			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		list.add(prodObj);
	        	}

	        }
		}

	    return list;
	}

	public static List<Map<String, String>> cardNoPoolRead(ExcelReadOption excelReadOption) throws Exception {

		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */
	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";

	    /*
	     * 각 Row를 리스트에 담는다.
	     * List에는 모든 Row가 포함될 것이다.
	     */
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();

	    /**
	     * 각 Row만큼 반복을 한다.
	     */
	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */
	    	row = sheet.getRow(rowIndex);
	    	Map<String, String> prodObj = new HashMap<String, String>();

	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();

	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
	            				&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

		            		if(cell.getCellType() == CellType.NUMERIC){
		            			if (HSSFDateUtil.isCellDateFormatted(cell)) {
		            				cell.setCellType(CellType.NUMERIC);
			            		}
		            			else{
		            				cell.setCellType(CellType.STRING);
		            			}
		            		}else{
		            			cell.setCellType(CellType.STRING);
		            		}


			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                //개행문자 제거
			                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 회원번호
		                    	prodObj.put("CARD_NO", cellValue);
		                    	isLastCell = true;
		                        break;
		                    case 1: // attrib01
		                    	prodObj.put("TITLE", cellValue);
		                    	isLastCell = true;
		                        break;
		                    case 2: // attrib02
		                    	prodObj.put("REG_DT", cellValue);
		                    	isLastCell = true;
		                    	break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
      			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		list.add(prodObj);
	        	}

	        }
		}

	    return list;

	}

	 /*
	  * 1. 메소드명: tgtGrpUploadRead
	  * 2. 클래스명: ExcelRead
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param excelReadOption
	 *   @return
	 */

	public static List<LoyTgtGrpXmListReqDto> tgtGrpUploadRead(ExcelReadOption excelReadOption) throws Exception{
		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LoyTgtGrpXmListReqDto> list = new ArrayList<LoyTgtGrpXmListReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyTgtGrpXmListReqDto tgtGrpObj = new LoyTgtGrpXmListReqDto();
	    	tgtGrpObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	tgtGrpObj.setCustNo(cellValue);
		                        break;

		                    case 1: // 카테고리 순번
		                    	tgtGrpObj.setMbrNo(cellValue);
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(tgtGrpObj);
	        	}


        	}
    	}

    	return list;
	}

	 /*
	  * 1. 메소드명: prodGrpUploadRead
	  * 2. 클래스명: ExcelRead
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param excelReadOption
	 *   @return
	 */

	public static List<LoyProdGrpListReqDto> prodGrpUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LoyProdGrpListReqDto> list = new ArrayList<LoyProdGrpListReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyProdGrpListReqDto prodGrpObj = new LoyProdGrpListReqDto();
	    	prodGrpObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	prodGrpObj.setProdId(cellValue);
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(prodGrpObj);
	        	}


        	}
    	}

    	return list;
	}

	public static List<LoyChnlGrpListReqDto> chnlGrpUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    List<LoyChnlGrpListReqDto> list = new ArrayList<LoyChnlGrpListReqDto>();


	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyChnlGrpListReqDto prodGrpObj = new LoyChnlGrpListReqDto();
	    	prodGrpObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	prodGrpObj.setChnlNo(cellValue);
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(prodGrpObj);
	        	}


        	}
    	}

    	return list;
	}

	 /*
	  * 1. 메소드명: categoryUploadRead
	  * 2. 클래스명: ExcelRead
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param excelReadOption
	 *   @return
	 */

	public static List<LoyCategoryGrpListReqDto> categoryUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());



	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LoyCategoryGrpListReqDto> list = new ArrayList<LoyCategoryGrpListReqDto>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LoyCategoryGrpListReqDto prodGrpObj = new LoyCategoryGrpListReqDto();
	    	prodGrpObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	prodGrpObj.setCatId(cellValue);
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
            			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(prodGrpObj);
	        	}


        	}
    	}

    	return list;
	}

	public static List<LOYCpnPayUploadResDto> parymentCpnUpldRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
		


		/**
		 * 엑셀 파일에서 첫번째 시트를 가지고 온다.
		 */
		Sheet sheet = wb.getSheetAt(0);
		wb.close();
		List<LOYCpnPayUploadResDto> list = new ArrayList<LOYCpnPayUploadResDto>();


		//  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
		//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */

		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;

		Row row = null;
		Cell cell = null;

		String cellName = "";
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		// List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		/**
		 * 각 Row만큼 반복을 한다.
		 */

		for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			/*
			 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			 * 하나의 Row는 여러개의 Cell을 가진다.
			 */

			row = sheet.getRow(rowIndex);
			LOYCpnPayUploadResDto tgtGrpObj = new LOYCpnPayUploadResDto();
			tgtGrpObj.setMessage(true);
			if(row != null) {
				/*
				 * 가져온 Row의 Cell의 개수를 구한다.
				 */
				numOfCells = row.getPhysicalNumberOfCells();
				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


					//셀 빈값 체크
					if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 회원번호
									tgtGrpObj.setMbrNo(cellValue);
									break;
								case 1: // 회원번호
									tgtGrpObj.setOfferNo(cellValue);
									break;

								case 2: // 쿠폰수량
									tgtGrpObj.setQty(Integer.parseInt(cellValue));
									break;
								default:
									break;
							}
						}else{
							cell=null;
						}
					}else{
						cell=null;
					}

				}
				/*
				 * 만들어진 객체를 List로 넣는다.
				 */
				if(cell!=null){
					list.add(tgtGrpObj);
				}


			}
		}

		return list;
	}
	
	
	/*
	  * 1. 메소드명: RoadAddressUploadRead
	  * 2. 클래스명: ExcelRead
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param excelReadOption
	 *   @return
	 */
	public static List<RoadAddressReqDto> RoadAddressUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    
	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    List<RoadAddressReqDto> list = new ArrayList<RoadAddressReqDto>();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	RoadAddressReqDto roadAddrObj = new RoadAddressReqDto();
	    	roadAddrObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                
			                String trimmedCellValue = cellValue.trim();
			                
			                /* 현재 column index에 따라서 vo에 입력
			                   (여기서 부터 엑셀파일 내용의 칼럼순서에 따라(0,1,2 식으로) 무슨 칼럼내용이 어디에 들어갈건지 지정)
			                 */
		                    switch (cellIndex) {
		                    
		                    case 0: // 칼럼 '법정동코드' 인 경우
		                    	roadAddrObj.setCode(trimmedCellValue);
		                        break;	    
		                        
		                    case 1:	// 칼럼 '법정동명' 인 경우
		                    		// 법정동명은 주소값이 최소 1단위(ex:서울특별시) 부터 3단위 이상(서울특별시 중구 을지로동) 일 수 있다 => split 해 나눠 넣기
		                    	String[] codeNmArr = trimmedCellValue.split(" ");		                    			                    	
		                    	int codeUnitCnt = codeNmArr.length; // 법정동명안에 들어있는 주소의 단위 가짓수 codeUnitCnt
		                    	
		                    	// 주소값이 1단위일 경우
	                    		if(codeUnitCnt == 1) {
	                    			// 시도 만 넣는다
	                    			roadAddrObj.setSido(codeNmArr[0]);
	                    			roadAddrObj.setSigungu(null);
	                    		} else if(codeUnitCnt == 2) {
	                    			// 시도, 시군구 넣는다
	                    			roadAddrObj.setSido(codeNmArr[0]);
	                    			roadAddrObj.setSigungu(codeNmArr[1]);
	                    		} else if(codeUnitCnt >= 3) {
	                    			// 시도, 시군구 넣는다
	                    			roadAddrObj.setSido(codeNmArr[0]);
	                    			roadAddrObj.setSigungu(codeNmArr[1]);
	                    		}
		                    	// '법정동명'칼럼에는 원본 통쨰로 넣는다
		                    	roadAddrObj.setCode_nm(trimmedCellValue);
		                    	break;
		                    	
		                    case 2: // 칼럼 '폐지여부' 인 경우
		                    	roadAddrObj.setDel_flag(trimmedCellValue);
		                    	break;
		                    	
		                    default:
		                        break;
		                    }
	            		} else {
	            			cell = null;
	            		}
	            	} else {
            			cell = null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell != null){
	        		list.add(roadAddrObj);
	        	}


        	}
    	}

    	return list;
	}
	
	
	
	

	public static List<LOYProdRequestDTO> prodListUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    List<LOYProdRequestDTO> list = new ArrayList<LOYProdRequestDTO>();
	    wb.close();

	  //  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
	//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */

	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";
	    /**
	     * 각 row마다의 값을 저장할 맵 객체
	     * 저장되는 형식은 다음과 같다.
	     * put("A", "이름");
	     * put("B", "게임명");
	     */
	    Map<String, String> map = null;
	    /*
	     * 각 Row를 리스트에 담는다.
	     * 하나의 Row를 하나의 Map으로 표현되며
	     * List에는 모든 Row가 포함될 것이다.
	     */
	   // List<Map<String, String>> result = new ArrayList<Map<String, String>>();
	    /**
	     * 각 Row만큼 반복을 한다.
	     */

	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */

	    	row = sheet.getRow(rowIndex);
	    	LOYProdRequestDTO prodGrpObj = new LOYProdRequestDTO();
	    	prodGrpObj.setMessage(true);
	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();
	            /*
	             * 데이터를 담을 맵 객체 초기화
	             */
	            map = new HashMap<String, String>();
	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

			            	cell.setCellType(CellType.STRING);

			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 카테고리명
		                    	prodGrpObj.setProdId(cellValue);
		                        break;
		                    case 1: // 카테고리명
		                    	prodGrpObj.setProdNm(cellValue);
		                        break;
		                    case 2: // 카테고리명
		                    	prodGrpObj.setSalePrice(cellValue);
		                        break; 
		                    case 3: // 카테고리명
		                    	prodGrpObj.setDesc(cellValue);
		                        break;    
		                    case 4: // 카테고리명
		                    	if(ObjectUtil.isEmpty(cellValue)) {
		                    		prodGrpObj.setCpnAvlYn("Y");
		                    	}else {
			                    	prodGrpObj.setCpnAvlYn(cellValue);
		                    	}
		                        break;       
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
           			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(cell!=null){
	        		list.add(prodGrpObj);
	        	}


       	}
   	}

   	return list;
	}

	public static List<OfferJoinChnlItemReqDto> offerJoinProdItemRead(ExcelReadOption excelReadOption) throws IOException {
		 //엑셀 파일 자체
	    //엑셀파일을 읽어 들인다.
	    //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
	    Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

	    /**
	     * 엑셀 파일에서 첫번째 시트를 가지고 온다.
	     */
	    Sheet sheet = wb.getSheetAt(0);
	    wb.close();
	    /**
	     * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
	     */
	    int numOfRows = sheet.getPhysicalNumberOfRows();
	    int numOfCells = 0;

	    Row row = null;
	    Cell cell = null;

	    String cellName = "";

	    /*
	     * 각 Row를 리스트에 담는다.
	     * List에는 모든 Row가 포함될 것이다.
	     */
	    List<OfferJoinChnlItemReqDto> list = new ArrayList<OfferJoinChnlItemReqDto>();

	    /**
	     * 각 Row만큼 반복을 한다.
	     */
	    boolean isLastCell = false;
	    for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
	    	isLastCell = false;

	        /*
	         * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
	         * 하나의 Row는 여러개의 Cell을 가진다.
	         */
	    	row = sheet.getRow(rowIndex);
	    	OfferJoinChnlItemReqDto prodObj = new OfferJoinChnlItemReqDto();

	        if(row != null) {
	            /*
	             * 가져온 Row의 Cell의 개수를 구한다.
	             */
	            numOfCells = row.getPhysicalNumberOfCells();

	            /*
	             * cell의 수 만큼 반복한다.
	             */
	            for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {


	            	//셀 빈값 체크
	            	if(row.getCell(cellIndex)!=null){
	            		//공백 체크
	            		if(row.getCell(cellIndex).getCellType() != CellType.BLANK
	            				&& !StringUtil.isLinebreak(StringUtil.convertNull(ExcelCellRef.getValue(cell), ""))){
	            			 /*
			                 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
			                 */
		            		cell = row.getCell(cellIndex);

		            		if(cell.getCellType() == CellType.NUMERIC){
		            			if (HSSFDateUtil.isCellDateFormatted(cell)) {
		            				cell.setCellType(CellType.NUMERIC);
			            		}
		            			else{
		            				cell.setCellType(CellType.STRING);
		            			}
		            		}else{
		            			cell.setCellType(CellType.STRING);
		            		}


			            	cell = row.getCell(cellIndex);

			                /*
			                 * 현재 Cell의 이름을 가져온다
			                 * 이름의 예 : A,B,C,D,......
			                 */
			                cellName = ExcelCellRef.getName(cell, cellIndex);
			                /*
			                 * 추출 대상 컬럼인지 확인한다
			                 * 추출 대상 컬럼이 아니라면,
			                 * for로 다시 올라간다
			                 */
			                if( !excelReadOption.getOutputColumns().contains(cellName) ) {
			                    continue;
			                }
			                /*
			                 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
			                 */

			                String cellValue =  ExcelCellRef.getValue(cell);
			                //개행문자 제거
			                StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,""));

			                // 현재 column index에 따라서 vo에 입력
		                    switch (cellIndex) {

		                    case 0: // 자재코드
		                    	prodObj.setRidProdM(cellValue);
		                    	isLastCell = true;
		                        break;
		                    default:
		                        break;
		                    }
	            		}else{
	            			cell=null;
	            		}
	            	}else{
       			cell=null;
	            	}

	            }
	            /*
	             * 만들어진 객체를 List로 넣는다.
	             */
	        	if(isLastCell){
	        		//이벤트 데이터 clear
	        		list.add(prodObj);
	        	}

	        }
		}

	    return list;
	}

	/*
	 * 1. 메소드명: chnlListUploadRead
	 * 2. 클래스명: ExcelRead
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 05. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param excelReadOption
	 *   @return
	 */
	public static List<LoyChnlReqDto> chnlListUploadRead(ExcelReadOption excelReadOption) throws Exception{
		//엑셀 파일 자체
		//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.

		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
		/**
		 * 엑셀 파일에서 첫번째 시트를 가지고 온다.
		 */
		Sheet sheet = wb.getSheetAt(0);
		List<LoyChnlReqDto> list = new ArrayList<LoyChnlReqDto>();
		wb.close();

		//  System.out.println("Sheet 이름: "+ wb.getSheetName(0));
		//    System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
		/**
		 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
		 */

		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;

		Row row = null;
		Cell cell = null;

		String cellName = "";
		/**
		 * 각 row마다의 값을 저장할 맵 객체
		 * 저장되는 형식은 다음과 같다.
		 * put("A", "이름");
		 * put("B", "게임명");
		 */
		Map<String, String> map = null;
		/*
		 * 각 Row를 리스트에 담는다.
		 * 하나의 Row를 하나의 Map으로 표현되며
		 * List에는 모든 Row가 포함될 것이다.
		 */
		// List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		/**
		 * 각 Row만큼 반복을 한다.
		 */

		for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			/*
			 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
			 * 하나의 Row는 여러개의 Cell을 가진다.
			 */

			row = sheet.getRow(rowIndex);
			LoyChnlReqDto chnlObj = new LoyChnlReqDto();
			chnlObj.setMessage(true);
			if(row != null) {
				/*
				 * 가져온 Row의 Cell의 개수를 구한다.
				 */
				numOfCells = row.getPhysicalNumberOfCells();
				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {

					//셀 빈값 체크
					if(row.getCell(cellIndex)!=null){
						//공백 체크
						if(row.getCell(cellIndex).getCellType() != CellType.BLANK){
							/*
							 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
							 */
							cell = row.getCell(cellIndex);

							cell.setCellType(CellType.STRING);

							cell = row.getCell(cellIndex);

							/*
							 * 현재 Cell의 이름을 가져온다
							 * 이름의 예 : A,B,C,D,......
							 */
							cellName = ExcelCellRef.getName(cell, cellIndex);
							/*
							 * 추출 대상 컬럼인지 확인한다
							 * 추출 대상 컬럼이 아니라면,
							 * for로 다시 올라간다
							 */
							if( !excelReadOption.getOutputColumns().contains(cellName) ) {
								continue;
							}
							/*
							 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
							 */

							String cellValue =  ExcelCellRef.getValue(cell);
							// 현재 column index에 따라서 vo에 입력
							switch (cellIndex) {

								case 0: // 매장 RID
									chnlObj.setRid(cellValue);
									break;
								case 1: // 매장번호
									chnlObj.setChnlNo(cellValue);
									break;
								case 2: // 매장명
									chnlObj.setChnlNm(cellValue);
									break;
								case 3: // 매장관리자 사번
									chnlObj.setEmpNo(cellValue);
									break;
								default:
									break;
							}
						}else{
							//매장관리자 사번만 공백 허용
							switch (cellIndex) {
								case 0: // 매장 RID
									cell=null;
									break;
								case 1: // 매장번호
									cell=null;
									break;
								case 2: // 매장명
									cell=null;
									break;
								case 3: // 매장관리자 사번
									chnlObj.setEmpNo(null);
									break;
								default:
									cell=null;
									break;
							}
						}
					}else{
						cell=null;
					}

				}
				/*
				 * 만들어진 객체를 List로 넣는다.
				 */
				if(cell!=null){
					list.add(chnlObj);
				}


			}
		}

		return list;
	}
	
	
	
	
	
	
	
}