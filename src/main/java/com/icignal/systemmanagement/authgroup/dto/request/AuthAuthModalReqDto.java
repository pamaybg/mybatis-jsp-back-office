package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class AuthAuthModalReqDto extends GridPagingReqDto {
	
	private String groupId;
	private String authGroupId;
	

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getAuthGroupId() {
		return authGroupId;
	}

	public void setAuthGroupId(String authGroupId) {
		this.authGroupId = authGroupId;
	}

}
