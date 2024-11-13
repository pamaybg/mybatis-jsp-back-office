package com.icignal.loyalty.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCamMstListReqDto extends CommonDataAuthReqDto {

	private String camType;

	public String getCamType() {
		return camType;
	}

	public void setCamType(String camType) {
		this.camType = camType;
	}
	
}
