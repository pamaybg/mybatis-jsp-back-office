package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class MktCampaignGetConidByCamidReqDto extends CommonDataAuthReqDto {
	
	private String camid;

	
	public String getCamid() {
		return camid;
	}
	public void setCamid(String camid) {
		this.camid = camid;
	}
}
