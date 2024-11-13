package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthInsertEmployeeReqDto extends MKTBaseReqDto {
	
	private List<String> empSelectList;
	private List<String> userSelectList;
	private String authGroupId;
	private String empId;
	private String ridUser;
	

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
	public List<String> getEmpSelectList() {
		return empSelectList;
	}
	public void setEmpSelectList(List<String> empSelectList) {
		this.empSelectList = empSelectList;
	}
	public String getRidUser() {
		return ridUser;
	}
	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}
	public List<String> getUserSelectList() {
		return userSelectList;
	}
	public void setUserSelectList(List<String> userSelectList) {
		this.userSelectList = userSelectList;
	}

	
	

}
