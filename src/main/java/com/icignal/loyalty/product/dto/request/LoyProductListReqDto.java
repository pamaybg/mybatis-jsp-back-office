package com.icignal.loyalty.product.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyProductListReqDto extends CommonDataAuthReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
	
}
