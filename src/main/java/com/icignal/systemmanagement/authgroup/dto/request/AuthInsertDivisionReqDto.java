package com.icignal.systemmanagement.authgroup.dto.request;



import com.icignal.common.base.dto.request.BaseReqDto;

public class AuthInsertDivisionReqDto extends BaseReqDto {
	
	private String authId;
	private String authGroupId;
	private String empId;
	
	private String ridDivision;
	
	
	public String getRidDivision() {
		return ridDivision;
	}
	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
}
