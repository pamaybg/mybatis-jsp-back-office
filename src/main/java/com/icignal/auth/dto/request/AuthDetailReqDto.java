package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class AuthDetailReqDto extends BaseReqDto {
	
	private String authId;

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

}
