package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class AuthGroupDivisionListReqDto extends GridPagingReqDto {
	
	private String authId;

	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
}
