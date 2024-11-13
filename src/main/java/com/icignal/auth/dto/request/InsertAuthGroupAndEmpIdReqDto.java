package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class InsertAuthGroupAndEmpIdReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String ridUser;
	private String autGroupId;
	private String id;
	
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRidUser() {
		return ridUser;
	}
	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}
	public String getAutGroupId() {
		return autGroupId;
	}
	public void setAutGroupId(String autGroupId) {
		this.autGroupId = autGroupId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
