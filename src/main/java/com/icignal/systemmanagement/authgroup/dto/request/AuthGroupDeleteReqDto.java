package com.icignal.systemmanagement.authgroup.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthGroupDeleteReqDto extends MKTBaseReqDto {
	
	private List<String> groupId;
	private String empId;

	public List<String> getGroupId() {
		return groupId;
	}

	public void setGroupId(List<String> groupId) {
		this.groupId = groupId;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
	
}
