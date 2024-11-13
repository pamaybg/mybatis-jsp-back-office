package com.icignal.systemmanagement.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemAuthDetailReqDto extends BaseReqDto{
	
	private String authId;

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

}
