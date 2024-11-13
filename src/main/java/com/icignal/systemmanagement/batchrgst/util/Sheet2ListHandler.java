package com.icignal.systemmanagement.batchrgst.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler.SheetContentsHandler;
import org.apache.poi.xssf.usermodel.XSSFComment;

/*
 * 1. 클래스명	: Sheet2ListHandler
 * 2. 파일명	: Sheet2ListHandler.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.util
 * 4. 작성자명	: 
 * 5. 작성일자	: 2019. 11. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		상품 대용량 업로드(100만건이상)
 * </PRE>
 * @param <T>
 */ 
public class Sheet2ListHandler<T> implements SheetContentsHandler {
    //Header 정보를 입력

    private int isLastCell;
	List<T> list;
	T prodObj;
	Map<String, String> map = new HashMap<String, String>();
    //collection 내 객체를 String[] 로 잡았기 때문에 배열의 길이를 생성시 받도록 설계
    private final int columnCnt;
    
    //외부 collection 과 배열 size를 받기 위해 추가한 부분입니다.
	public Sheet2ListHandler(int columnsCnt, List<T> resDto,T obj) {
    	prodObj = obj;
    	list = (List<T>) resDto;
        this.columnCnt = columnsCnt;
    }
    

    //Row의 시작 부분에서 발생하는 이벤트를 처리하는 method
    @Override
	public void startRow(int rowNum) {
    	//prodObj = new LoySetProdListReqDto();
    	isLastCell = 0;    
    }
    

    @Override
	public void headerFooter(String paramString1, boolean paramBoolean,
            String paramString2) {
        //sheet의 첫 row와 마지막 row를 처리하는 method
    }

	@SuppressWarnings("unchecked")
	@Override
	public void endRow(int rowNum) {
		if(rowNum!=0 && isLastCell==columnCnt){
			list.add((T) map);
		}
	}

	@Override
	public void cell(String cellReference, String formattedValue, XSSFComment comment) {
		if ( formattedValue == null ) return;
		String cellVal =  cellReference.substring(0,1);
		
		for(int i=0;i<columnCnt;i++)
		map.put(cellVal,formattedValue);
		
//		if("A".equals(cellVal) ) map.put(cellVal,formattedValue);
//			//prodObj.setBrndType(formattedValue);		
//		else if("B".equals(cellVal) ) map.put(cellVal,formattedValue);
//			//prodObj.setSerialNo(formattedValue);
//		else if("C".equals(cellVal) ) map.put(cellVal,formattedValue);
//			//prodObj.setColor(formattedValue);
//		else if("D".equals(cellVal) ) map.put(cellVal,formattedValue);
//			//prodObj.setStanYearMonth(formattedValue);
//	    else return;
		
		isLastCell++;
	}
	
	public List<T> getList() {
		return list;
	}


	
  }
