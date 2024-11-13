package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class AuthGroupDetailReqDto extends BaseReqDto {
	
	private String groupId;

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	
}
