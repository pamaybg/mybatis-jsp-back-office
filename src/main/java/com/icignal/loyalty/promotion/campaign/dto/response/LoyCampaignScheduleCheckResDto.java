package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyCampaignScheduleCheckResDto  extends StatusResDto{
	private String chnlType;

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
}
