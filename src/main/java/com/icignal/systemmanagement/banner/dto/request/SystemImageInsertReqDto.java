package com.icignal.systemmanagement.banner.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemImageInsertReqDto extends StatusResDto{
	
	private String parentId;

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}
