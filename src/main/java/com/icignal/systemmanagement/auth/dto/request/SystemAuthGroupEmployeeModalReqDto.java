package com.icignal.systemmanagement.auth.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemAuthGroupEmployeeModalReqDto extends CommonDataAuthReqDto {
	
	private String empId;
	private String empName;
	private String empEmail;
	private String empType;
	private String empNo;
	private String ridUser;
	private String userId;
	private String allFlag;		//매장 직원까지 조회
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getEmpType() {
		return empType;
	}
	public void setEmpType(String empType) {
		this.empType = empType;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getRidUser() {
		return ridUser;
	}
	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAllFlag() {return allFlag;}
	public void setAllFlag(String allFlag) {this.allFlag = allFlag;}
}
