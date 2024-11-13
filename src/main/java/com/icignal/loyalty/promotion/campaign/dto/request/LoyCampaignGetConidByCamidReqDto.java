package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyCampaignGetConidByCamidReqDto extends CommonDataAuthReqDto {
	
	private String camid;

	
	public String getCamid() {
		return camid;
	}
	public void setCamid(String camid) {
		this.camid = camid;
	}
}
