package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class GetAuthGroupListByEIRUReqDto extends MKTGridPagingReqDto {
	
	private String empId;
	private String rid;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
