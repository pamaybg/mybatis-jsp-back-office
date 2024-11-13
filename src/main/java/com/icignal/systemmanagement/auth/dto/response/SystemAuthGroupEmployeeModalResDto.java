package com.icignal.systemmanagement.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class SystemAuthGroupEmployeeModalResDto extends GridPagingItemResDto {
	
	private String empId;
	private String empName;
	@Decrypted(masked="none")
	private String empEmail;
	private String empType;
	private String empNo;
	private String ridUser;
	private String userId;
	private String orgId;

	private String employeeRid;
	private String name;
	private String email;
	@MarkName(groupCode = "WORK_STATUS", codeField = "workStatus")
	private String workStatusNm;
	private String workStatus;
	private String ridDivision;

	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
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

	public String getEmployeeRid() {
		return employeeRid;
	}

	public void setEmployeeRid(String employeeRid) {
		this.employeeRid = employeeRid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWorkStatusNm() {
		return workStatusNm;
	}

	public void setWorkStatusNm(String workStatusNm) {
		this.workStatusNm = workStatusNm;
	}

	public String getWorkStatus() {
		return workStatus;
	}

	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
}
