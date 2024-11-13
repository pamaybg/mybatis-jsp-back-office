package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class MktCampaignScheduleCheckResDto  extends StatusResDto {
	private String chnlType;

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
}
