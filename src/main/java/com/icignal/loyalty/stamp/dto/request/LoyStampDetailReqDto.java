package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampDetailReqDto extends CommonDataAuthReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
	
}
