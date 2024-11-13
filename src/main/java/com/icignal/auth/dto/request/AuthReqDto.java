package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class AuthReqDto extends BaseReqDto {
	
	private String ridUser;			//사용자 아이디
	private String empId;			//직원 아이디
	private String authGroupId;		//권한그룹 아이디
	private String accountOrgId;	//어카운트 ORG 아이디
	private String dataTypeCd;		//데이터유형코드
	private String ridDivision;		//부서아이디


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

	public String getAccountOrgId() {
		return accountOrgId;
	}

	public void setAccountOrgId(String accountOrgId) {
		this.accountOrgId = accountOrgId;
	}

	public String getDataTypeCd() {
		return dataTypeCd;
	}

	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}

	public String getRidUser() {
		return ridUser;
	}

	public void setRidUser(String ridUser) {
		this.ridUser = ridUser;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}
}
