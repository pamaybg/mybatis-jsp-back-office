package com.icignal.systemmanagement.responseinfo.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


public class SystemGetResponseInfoDetailReqDto extends MKTBaseReqDto{

	private String id;					//아이디
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
