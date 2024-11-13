package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktGetInstagramDtlReqDto extends CommonDataAuthReqDto{
	private String id;                       //아이디
	
	public String getId(){
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
