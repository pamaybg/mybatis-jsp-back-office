package com.icignal.common.workflow.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignDefaultInfoReqDto;

/**
 * @name : infavor.marketing.workflow.dto.request
 * @date : 2015. 10. 26.
 * @author : 류동균
 * @description : node이 data 정의
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class WorkflowDataReqDto extends CommonDataAuthReqDto {
	
    private LoyCampaignDefaultInfoReqDto campaignDefaultInfo;    //캠페인 기본정보

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public LoyCampaignDefaultInfoReqDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(LoyCampaignDefaultInfoReqDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

}
