package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class GetManageTabListReqDto extends GridPagingReqDto {
	
	private String clientFlag;

	
	public String getClientFlag() {
		return clientFlag;
	}
	public void setClientFlag(String clientFlag) {
		this.clientFlag = clientFlag;
	}
	
}
