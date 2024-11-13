package com.icignal.systemmanagement.program.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemExcelDataMapReqDto extends CommonDataAuthReqDto{
	private String dRid; // 엑셀셀 rid
	private String ridExcelH; // 엑셀 rid
	private String createDate; 
	private String empId;
	private String excelCell; //엑셀 셀 번호
	private String dataField; //매핑 데이터
	private String headNm;
	private String rid;
	
	public String getHeadNm() {
		return headNm;
	}
	public void setHeadNm(String headNm) {
		this.headNm = headNm;
	}
	public String getDataField() {
		return dataField;
	}
	public void setDataField(String dataField) {
		this.dataField = dataField;
	}
	public String getCreateDate() {
		return createDate;
	}
	public String getExcelCell() {
		return excelCell;
	}
	public void setExcelCell(String excelCell) {
		this.excelCell = excelCell;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getRidExcelH() {
		return ridExcelH;
	}
	public void setRidExcelH(String ridExcelH) {
		this.ridExcelH = ridExcelH;
	}
	public String getdRid() {
		return dRid;
	}
	public void setdRid(String dRid) {
		this.dRid = dRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}

