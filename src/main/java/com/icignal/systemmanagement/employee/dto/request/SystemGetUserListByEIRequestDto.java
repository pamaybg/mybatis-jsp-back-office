package com.icignal.systemmanagement.employee.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemGetUserListByEIRequestDto extends MKTGridPagingReqDto {
	
	private String empId;

	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
}
