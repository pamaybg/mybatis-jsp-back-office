package com.icignal.common.base.dto.request;

import java.util.List;


/**
 * @name : infavor.batch.campaign.common
 * @date : 2016. 8. 10.
 * @author : 류동균
 * @description : export excel request
 */
public class ExportExcelReqDto {
    
	private String id;
    private String fileName;                //파일명
    private String realPath;                //path
    private List<String> headerList;         //헤더 목록
    private List<List<Object>> dataList;     //데이터 목록
    
    private List<ExportExcelSheetReqDto> sheetList;		//시트 목록
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getRealPath() {
        return realPath;
    }

    public void setRealPath(String realPath) {
        this.realPath = realPath;
    }

	public List<ExportExcelSheetReqDto> getSheetList() {
		return sheetList;
	}

	public void setSheetList(List<ExportExcelSheetReqDto> sheetList) {
		this.sheetList = sheetList;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the headerList
	 */
	public List<String> getHeaderList() {
		return headerList;
	}

	/**
	 * @param headerList the headerList to set
	 */
	public void setHeaderList(List<String> headerList) {
		this.headerList = headerList;
	}

	/**
	 * @return the dataList
	 */
	public List<List<Object>> getDataList() {
		return dataList;
	}

	/**
	 * @param dataList the dataList to set
	 */
	public void setDataList(List<List<Object>> dataList) {
		this.dataList = dataList;
	}
	
}
