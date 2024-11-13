package com.icignal.common.base.dto.request;

import java.util.List;


/**
 * @name : infavor.batch.campaign.common
 * @date : 2016. 8. 10.
 * @author : 류동균
 * @description : export excel sheet request
 */
public class ExportExcelSheetReqDto {
    
    private String sheetName;                //파일명
    private List<String> headerList;         //헤더 목록
    private List<List<String>> dataList;     //데이터 목록
    
    public List<String> getHeaderList() {
        return headerList;
    }
    
    public void setHeaderList(List<String> headerList) {
        this.headerList = headerList;
    }
    
    public List<List<String>> getDataList() {
        return dataList;
    }
    
    public void setDataList(List<List<String>> dataList) {
        this.dataList = dataList;
    }

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}
	
}
