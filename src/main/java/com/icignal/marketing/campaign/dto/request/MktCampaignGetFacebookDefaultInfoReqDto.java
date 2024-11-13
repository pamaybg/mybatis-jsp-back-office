package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class MktCampaignGetFacebookDefaultInfoReqDto extends CommonDataAuthReqDto {
	
	private String camid;
	
	public String getCamid() {
		return camid;
	}
	public void setCamid(String camid) {
		this.camid = camid;
	}
}
