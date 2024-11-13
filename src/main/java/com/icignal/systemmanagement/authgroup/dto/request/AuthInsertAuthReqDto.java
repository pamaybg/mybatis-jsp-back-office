package com.icignal.systemmanagement.authgroup.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthInsertAuthReqDto extends MKTBaseReqDto {
	
	private List<String> authSelectList;
	private String authGroupId;
	private String empId;
	private String authId;
	
	
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
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}

}
