package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemExcelDataMapResDto extends GridPagingItemResDto{
	private String rid;
	private String excelCell;
	private String dataField;
	private String headNm;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getExcelCell() {
		return excelCell;
	}
	public void setExcelCell(String excelCell) {
		this.excelCell = excelCell;
	}
	public String getDataField() {
		return dataField;
	}
	public void setDataField(String dataField) {
		this.dataField = dataField;
	}
	public String getHeadNm() {
		return headNm;
	}
	public void setHeadNm(String headNm) {
		this.headNm = headNm;
	}
	
	
}
