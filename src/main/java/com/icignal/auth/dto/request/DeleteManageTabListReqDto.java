package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

public class DeleteManageTabListReqDto extends BaseReqDto{
	
	private String rid;
	private String empId;
	private List<String> rids;
	
	
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
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	
}
