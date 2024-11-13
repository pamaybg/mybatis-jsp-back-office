package com.icignal.loyalty.promotion.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRuleSetResDto;



/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2015. 10. 19.
 * @author : 류동균
 * @description : 
 */
public class LoyCampaignWorkflowDataResDto extends StatusResDto{
	
    private CampaignDefaultInfoResDto campaignDefaultInfo;    //캠페인 기본정보
    
    private LoyCampaignResourceResDto campaignResource;    //캠페인 자원
    
    private LoyCampaignOfferResDto campaignOffer;    //캠페인 오퍼
    
    private LoyCampaignExecutionInfoResDto campaignExecutionInfo;    //캠페인 실행정보
    
    private LoyCampaignROIResDto campaignROI;    //캠페인 ROI
    
    private LoyCampaignContentsChnnelRelResDto campaignContents;    //캠페인 콘텐츠
    
    private LoyCampaignMonitoringResDto campaignMonitoring;    //캠페인 모니터링
    
    private LoyCampaignApprovalResDto campaignApproval;    //전자결재
    
    
    private LoyRuleSetResDto ruleSet;	//RuleSet

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public CampaignDefaultInfoResDto getCampaignDefaultInfo() {
        return campaignDefaultInfo;
    }

    public void setCampaignDefaultInfo(CampaignDefaultInfoResDto campaignDefaultInfo) {
        this.campaignDefaultInfo = campaignDefaultInfo;
    }

    public LoyCampaignResourceResDto getCampaignResource() {
        return campaignResource;
    }

    public void setCampaignResource(LoyCampaignResourceResDto campaignResource) {
        this.campaignResource = campaignResource;
    }

    public LoyCampaignOfferResDto getCampaignOffer() {
        return campaignOffer;
    }

    public void setCampaignOffer(LoyCampaignOfferResDto campaignOffer) {
        this.campaignOffer = campaignOffer;
    }

    public LoyCampaignExecutionInfoResDto getCampaignExecutionInfo() {
        return campaignExecutionInfo;
    }

    public void setCampaignExecutionInfo(LoyCampaignExecutionInfoResDto campaignExecutionInfo) {
        this.campaignExecutionInfo = campaignExecutionInfo;
    }

    public LoyCampaignROIResDto getCampaignROI() {
        return campaignROI;
    }

    public void setCampaignROI(LoyCampaignROIResDto campaignROI) {
        this.campaignROI = campaignROI;
    }

    public LoyCampaignContentsChnnelRelResDto getCampaignContents() {
        return campaignContents;
    }

    public void setCampaignContents(LoyCampaignContentsChnnelRelResDto campaignContents) {
        this.campaignContents = campaignContents;
    }

    public LoyCampaignMonitoringResDto getCampaignMonitoring() {
        return campaignMonitoring;
    }

    public void setCampaignMonitoring(LoyCampaignMonitoringResDto campaignMonitoring) {
        this.campaignMonitoring = campaignMonitoring;
    }

    public LoyCampaignApprovalResDto getCampaignApproval() {
        return campaignApproval;
    }

    public void setCampaignApproval(LoyCampaignApprovalResDto campaignApproval) {
        this.campaignApproval = campaignApproval;
    }

	public LoyRuleSetResDto getRuleSet() {
		return ruleSet;
	}

	public void setRuleSet(LoyRuleSetResDto ruleSet) {
		this.ruleSet = ruleSet;
	}

}