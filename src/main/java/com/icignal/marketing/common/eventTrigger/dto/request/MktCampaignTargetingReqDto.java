package com.icignal.marketing.common.eventTrigger.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNCampaignTargetingRequestDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 캠페인 타겟팅
 */
public class MktCampaignTargetingReqDto extends MKTBaseReqDto {

	private String campaignId;
   
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


	public String getCampaignId() {
		return campaignId;
	}


	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}

}
