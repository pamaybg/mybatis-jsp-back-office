package com.icignal.loyalty.notice.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyImageInsertReqDto extends StatusResDto {
	
	private String parentId;

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

}
