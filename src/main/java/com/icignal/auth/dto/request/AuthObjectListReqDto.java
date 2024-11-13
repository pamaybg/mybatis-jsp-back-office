package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class AuthObjectListReqDto extends GridPagingReqDto {
	
	private String authId;
	private String pgmId;
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}

}
