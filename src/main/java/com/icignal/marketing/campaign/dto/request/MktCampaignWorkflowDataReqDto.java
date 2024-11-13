package com.icignal.marketing.campaign.dto.request;

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
public class MktCampaignWorkflowDataReqDto extends MKTBaseReqDto {
	
    private MktCampaignDefaultInfoReqDto campaignDefaultInfo;       //캠페인 기본정보
    
    private MktCampaignResourceReqDto campaignResource;             //캠페인 자원
    private MktCampaignOfferReqDto campaignOffer;                   //캠페인 혜택
    private MktCampaignExecutionInfoReqDto campaignExecutionInfo;   //캠페인 실행정보
    private MktCampaignROIReqDto campaignROI;                       //캠페인 ROI
    private MktCampaignContentsChnnelRelReqDto campaignContents;    //캠페인 콘텐츠
    private MktCampaignMonitoringReqDto campaignMonitoring;         //캠페인 모니터링

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public MktCampaignDefaultInfoReqDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(MktCampaignDefaultInfoReqDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

    public MktCampaignResourceReqDto getCampaignResource() {
        return campaignResource;
    }

    public void setCampaignResource(MktCampaignResourceReqDto campaignResource) {
        this.campaignResource = campaignResource;
    }

    public MktCampaignOfferReqDto getCampaignOffer() {
        return campaignOffer;
    }

    public void setCampaignOffer(MktCampaignOfferReqDto campaignOffer) {
        this.campaignOffer = campaignOffer;
    }

    public MktCampaignExecutionInfoReqDto getCampaignExecutionInfo() {
        return campaignExecutionInfo;
    }

    public void setCampaignExecutionInfo(MktCampaignExecutionInfoReqDto campaignExecutionInfo) {
        this.campaignExecutionInfo = campaignExecutionInfo;
    }

    public MktCampaignROIReqDto getCampaignROI() {
        return campaignROI;
    }

    public void setCampaignROI(MktCampaignROIReqDto campaignROI) {
        this.campaignROI = campaignROI;
    }

    public MktCampaignContentsChnnelRelReqDto getCampaignContents() {
        return campaignContents;
    }

    public void setCampaignContents(MktCampaignContentsChnnelRelReqDto campaignContents) {
        this.campaignContents = campaignContents;
    }

    public MktCampaignMonitoringReqDto getCampaignMonitoring() {
        return campaignMonitoring;
    }

    public void setCampaignMonitoring(MktCampaignMonitoringReqDto campaignMonitoring) {
        this.campaignMonitoring = campaignMonitoring;
    }


}
