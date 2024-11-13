package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthInsertAuthReqDto extends MKTBaseReqDto {
	
	private List<String> authSelectList;
	private String authGroupId;
	private String empId;
	
	
	public List<String> getAuthSelectList() {
		return authSelectList;
	}
	public void setAuthSelectList(List<String> authSelectList) {
		this.authSelectList = authSelectList;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}

}
