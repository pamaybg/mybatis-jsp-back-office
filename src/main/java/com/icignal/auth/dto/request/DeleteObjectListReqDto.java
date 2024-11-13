package com.icignal.auth.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.BaseReqDto;

public class DeleteObjectListReqDto extends BaseReqDto{
	
	private String id;
	private String empId;
	
	//권한삭제
	private List<String> ids;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getIds() {
		return ids;
	}
	public void setIds(List<String> ids) {
		this.ids = ids;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
}
