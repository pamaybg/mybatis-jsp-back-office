package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class AuthGroupEmployeeReqDto extends GridPagingReqDto {
	
	private String authGroupId;
	
	public String getAuthGroupId() {
		return authGroupId;
	}
	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

}
