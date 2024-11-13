package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class AuthGroupInsertResDto extends StatusResDto{
	
	private String groupId;

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

}
