package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;


public class AuthGroupEmployeeModalReqDto extends GridPagingReqDto {

	private String empId;
	private String authGroupId;
	private String cipherKey;


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

	/**
	* @return the cipherKey
	*/
	public String getCipherKey() {
		return cipherKey;
	}

	/**
	* @param cipherKey the cipherKey to set
	*/
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public AuthGroupEmployeeModalReqDto() {
    }


}
