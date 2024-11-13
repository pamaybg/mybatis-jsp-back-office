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
public class CampaignWorkflowDataResDto extends StatusResDto {
	
    private LoyPromotionDefaultInfoResDto campaignDefaultInfo;    //캠페인 기본정보
    
    private LoyPromotionRuleInfoResDto promotionRuleInfo;
    
    private LoyPromotionActionDetailResDto promotionActionInfo;
    
    private CampaignResourceResDto campaignResource;    //캠페인 자원
    
    private CampaignOfferResDto campaignOffer;    //캠페인 오퍼
    
    private CampaignExecutionInfoResDto campaignExecutionInfo;    //캠페인 실행정보
    
    private CampaignROIResDto campaignROI;    //캠페인 ROI
    
    private CampaignContentsChnnelRelResDto campaignContents;    //캠페인 콘텐츠
    
    private CampaignMonitoringResDto campaignMonitoring;    //캠페인 모니터링
    
    private LoyCampaignApprovalResDto campaignApproval;    //전자결재
    
    
    private LoyRuleSetResDto ruleSet;	//RuleSet

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }



    public LoyPromotionDefaultInfoResDto getCampaignDefaultInfo() {
		return campaignDefaultInfo;
	}



	public void setCampaignDefaultInfo(LoyPromotionDefaultInfoResDto campaignDefaultInfo) {
		this.campaignDefaultInfo = campaignDefaultInfo;
	}



	public CampaignResourceResDto getCampaignResource() {
        return campaignResource;
    }

    public void setCampaignResource(CampaignResourceResDto campaignResource) {
        this.campaignResource = campaignResource;
    }

    public CampaignOfferResDto getCampaignOffer() {
        return campaignOffer;
    }

    public void setCampaignOffer(CampaignOfferResDto campaignOffer) {
        this.campaignOffer = campaignOffer;
    }

    public CampaignExecutionInfoResDto getCampaignExecutionInfo() {
        return campaignExecutionInfo;
    }

    public void setCampaignExecutionInfo(CampaignExecutionInfoResDto campaignExecutionInfo) {
        this.campaignExecutionInfo = campaignExecutionInfo;
    }

    public CampaignROIResDto getCampaignROI() {
        return campaignROI;
    }

    public void setCampaignROI(CampaignROIResDto campaignROI) {
        this.campaignROI = campaignROI;
    }

    public CampaignContentsChnnelRelResDto getCampaignContents() {
        return campaignContents;
    }

    public void setCampaignContents(CampaignContentsChnnelRelResDto campaignContents) {
        this.campaignContents = campaignContents;
    }

    public CampaignMonitoringResDto getCampaignMonitoring() {
        return campaignMonitoring;
    }

    public void setCampaignMonitoring(CampaignMonitoringResDto campaignMonitoring) {
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



	public LoyPromotionRuleInfoResDto getPromotionRuleInfo() {
		return promotionRuleInfo;
	}



	public void setPromotionRuleInfo(LoyPromotionRuleInfoResDto promotionRuleInfo) {
		this.promotionRuleInfo = promotionRuleInfo;
	}



	public LoyPromotionActionDetailResDto getPromotionActionInfo() {
		return promotionActionInfo;
	}



	public void setPromotionActionInfo(LoyPromotionActionDetailResDto promotionActionInfo) {
		this.promotionActionInfo = promotionActionInfo;
	}
	
	
}