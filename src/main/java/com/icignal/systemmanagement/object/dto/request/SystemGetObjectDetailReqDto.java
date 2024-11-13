package com.icignal.systemmanagement.object.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class SystemGetObjectDetailReqDto extends BaseReqDto{
	
	private String id;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
