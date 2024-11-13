package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2015. 10. 19.
 * @author : 류동균
 * @description : 
 */
public class MktCampaignWorkflowDataResDto extends StatusResDto {
	
    private MktCampaignDefaultInfoResDto campaignDefaultInfo;    //캠페인 기본정보
    
    private MktCampaignResourceResDto campaignResource;    //캠페인 자원
    
    private MktCampaignOfferResDto campaignOffer;    //캠페인 오퍼
    
    private MktCampaignExecutionInfoResDto campaignExecutionInfo;    //캠페인 실행정보
    
    private MktCampaignROIResDto campaignROI;    //캠페인 ROI
    
    private MktCampaignContentsChnnelRelResDto campaignContents;    //캠페인 콘텐츠
    
    private MktCampaignMonitoringResDto campaignMonitoring;    //캠페인 모니터링
    
    private MktCampaignApprovalResDto campaignApproval;    //전자결재
    
    private MktETCampaignNodeResDto etCampaignCond;	//et 조건
    
    private MktETCampaignNodeResDto etCampaignAct;		//et 활동
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public MktCampaignDefaultInfoResDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(MktCampaignDefaultInfoResDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

    public MktCampaignResourceResDto getCampaignResource() {
        return campaignResource;
    }

    public void setCampaignResource(MktCampaignResourceResDto campaignResource) {
        this.campaignResource = campaignResource;
    }

    public MktCampaignOfferResDto getCampaignOffer() {
        return campaignOffer;
    }

    public void setCampaignOffer(MktCampaignOfferResDto campaignOffer) {
        this.campaignOffer = campaignOffer;
    }

    public MktCampaignExecutionInfoResDto getCampaignExecutionInfo() {
        return campaignExecutionInfo;
    }

    public void setCampaignExecutionInfo(MktCampaignExecutionInfoResDto campaignExecutionInfo) {
        this.campaignExecutionInfo = campaignExecutionInfo;
    }

    public MktCampaignROIResDto getCampaignROI() {
        return campaignROI;
    }

    public void setCampaignROI(MktCampaignROIResDto campaignROI) {
        this.campaignROI = campaignROI;
    }

    public MktCampaignContentsChnnelRelResDto getCampaignContents() {
        return campaignContents;
    }

    public void setCampaignContents(MktCampaignContentsChnnelRelResDto campaignContents) {
        this.campaignContents = campaignContents;
    }

    public MktCampaignMonitoringResDto getCampaignMonitoring() {
        return campaignMonitoring;
    }

    public void setCampaignMonitoring(MktCampaignMonitoringResDto campaignMonitoring) {
        this.campaignMonitoring = campaignMonitoring;
    }

    public MktCampaignApprovalResDto getCampaignApproval() {
        return campaignApproval;
    }

    public void setCampaignApproval(MktCampaignApprovalResDto campaignApproval) {
        this.campaignApproval = campaignApproval;
    }

	public MktETCampaignNodeResDto getEtCampaignCond() {
		return etCampaignCond;
	}

	public void setEtCampaignCond(MktETCampaignNodeResDto etCampaignCond) {
		this.etCampaignCond = etCampaignCond;
	}

	public MktETCampaignNodeResDto getEtCampaignAct() {
		return etCampaignAct;
	}

	public void setEtCampaignAct(MktETCampaignNodeResDto etCampaignAct) {
		this.etCampaignAct = etCampaignAct;
	}

}