package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class GetIpAccessControlListReqDto extends MKTGridPagingReqDto {
	
	private String rid;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
