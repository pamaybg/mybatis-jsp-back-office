package com.icignal.systemmanagement.alert.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemAlertListReqDto extends CommonDataAuthReqDto{

	private String rid;
	private String empId;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}
