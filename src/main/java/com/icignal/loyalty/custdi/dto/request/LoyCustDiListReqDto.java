package com.icignal.loyalty.custdi.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCustDiListReqDto extends CommonDataAuthReqDto{

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
