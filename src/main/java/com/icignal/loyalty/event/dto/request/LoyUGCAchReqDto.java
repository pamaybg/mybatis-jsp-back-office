package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyUGCAchReqDto extends CommonDataAuthReqDto {
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

}
