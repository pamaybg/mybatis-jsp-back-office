package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class GetUserDetailRequestDto extends GridPagingReqDto {
	
	private String rid;

	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
