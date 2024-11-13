package com.icignal.systemmanagement.program.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemInsertAuthObjRelReqDto extends CommonDataAuthReqDto {
	
	private String empId;
	private String objId;
	private String pgmId;
	private String viewType;
	private String id;
	private List<String> authIdList;

	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}
	public String getViewType() {
		return viewType;
	}
	public void setViewType(String viewType) {
		this.viewType = viewType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getAuthIdList() {
		return authIdList;
	}
	public void setAuthIdList(List<String> authIdList) {
		this.authIdList = authIdList;
	}
	
	
}
