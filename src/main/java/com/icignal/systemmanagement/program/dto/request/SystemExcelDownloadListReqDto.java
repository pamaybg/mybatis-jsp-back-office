package com.icignal.systemmanagement.program.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemExcelDownloadListReqDto extends GridPagingReqDto{
	
	private String rid;
	private String pgmId; //프로그램id
	private String templateFile; //엑셀 템플릿 파일 경로
	private String title; // 엑셀 다운로드 제목
	private String excelCreateType; //액셀 생성 유형
	private String createDate;
	private String empId;
	private String tempName;
	private int excelSeq;
	private String objCode;
	
	public int getExcelSeq() {
		return excelSeq;
	}
	public void setExcelSeq(int excelSeq) {
		this.excelSeq = excelSeq;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getExcelCreateType() {
		return excelCreateType;
	}
	public void setExcelCreateType(String excelCreateType) {
		this.excelCreateType = excelCreateType;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTempName() {
		return tempName;
	}
	public void setTempName(String tempName) {
		this.tempName = tempName;
	}
	public String getTemplateFile() {
		return templateFile;
	}
	public void setTemplateFile(String templateFile) {
		this.templateFile = templateFile;
	}
	public String getObjCode() {
		return objCode;
	}
	public void setObjCode(String objCode) {
		this.objCode = objCode;
	}
	
}
