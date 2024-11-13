package com.icignal.systemmanagement.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemDeleteAuthObjRelReqDto extends BaseReqDto {
	
	private List<String> objRelIdList;
	private String empId;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public List<String> getObjRelIdList() {
		return objRelIdList;
	}
	public void setObjRelIdList(List<String> objRelIdList) {
		this.objRelIdList = objRelIdList;
	}
	
}
