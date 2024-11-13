package com.icignal.systemmanagement.program.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemAuthGroupListReqDto extends GridPagingReqDto{
	
	private String rid;
	private String id;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
