package com.icignal.loyalty.promotion.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;


/**
 * @programId : 
 * @name : infavor.marketing.workflow.dto.response
 * @date : 2015. 10. 2.
 * @author : 류동균
 * @description : node이 data 정의
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignWorkflowDataReqDto extends MKTBaseReqDto {
	
    private LoyCampaignDefaultInfoReqDto campaignDefaultInfo;       //캠페인 기본정보
    
    private LoyCampaignResourceReqDto campaignResource;             //캠페인 자원
    private LoyCampaignOfferReqDto campaignOffer;                   //캠페인 혜택
    private LoyCampaignExecutionInfoReqDto campaignExecutionInfo;   //캠페인 실행정보
    private LoyCampaignROIReqDto campaignROI;                       //캠페인 ROI
    private LoyCampaignContentsChnnelRelReqDto campaignContents;    //캠페인 콘텐츠
    private LoyCampaignMonitoringReqDto campaignMonitoring;         //캠페인 모니터링

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    

    public LoyCampaignDefaultInfoReqDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(LoyCampaignDefaultInfoReqDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

    public LoyCampaignResourceReqDto getCampaignResource() {
        return campaignResource;
    }

    public void setCampaignResource(LoyCampaignResourceReqDto campaignResource) {
        this.campaignResource = campaignResource;
    }

    public LoyCampaignOfferReqDto getCampaignOffer() {
        return campaignOffer;
    }

    public void setCampaignOffer(LoyCampaignOfferReqDto campaignOffer) {
        this.campaignOffer = campaignOffer;
    }

    public LoyCampaignExecutionInfoReqDto getCampaignExecutionInfo() {
        return campaignExecutionInfo;
    }

    public void setCampaignExecutionInfo(LoyCampaignExecutionInfoReqDto campaignExecutionInfo) {
        this.campaignExecutionInfo = campaignExecutionInfo;
    }

    public LoyCampaignROIReqDto getCampaignROI() {
        return campaignROI;
    }

    public void setCampaignROI(LoyCampaignROIReqDto campaignROI) {
        this.campaignROI = campaignROI;
    }

    public LoyCampaignContentsChnnelRelReqDto getCampaignContents() {
        return campaignContents;
    }

    public void setCampaignContents(LoyCampaignContentsChnnelRelReqDto campaignContents) {
        this.campaignContents = campaignContents;
    }

    public LoyCampaignMonitoringReqDto getCampaignMonitoring() {
        return campaignMonitoring;
    }

    public void setCampaignMonitoring(LoyCampaignMonitoringReqDto campaignMonitoring) {
        this.campaignMonitoring = campaignMonitoring;
    }



}
