package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 캠페인 삭제 Request DTO
 * 
 * @name : infavor.marketing.campaign.dto.request.MKTCampaignRemoveRequestDTO
 * @date : 2017. 11. 29.
 * @author : jh.kim
 * @description :
 */
public class LoyCampaignRemoveReqDto extends CommonDataAuthReqDto {
    
    private String id;                          // 캠페인 id
    private String campaignStatusCode;          // 캠페인 상태코드
    private String campaignApprovalStatusCode;  // 결제 상태코드
    private String rid;
    private String promStatCd;
    
     
    public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCampaignApprovalStatusCode() {
        return campaignApprovalStatusCode;
    }

    public void setCampaignApprovalStatusCode(String campaignApprovalStatusCode) {
        this.campaignApprovalStatusCode = campaignApprovalStatusCode;
    }

    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getCampaignStatusCode() {
        return campaignStatusCode;
    }
    
    public void setCampaignStatusCode(String campaignStatusCode) {
        this.campaignStatusCode = campaignStatusCode;
    }

	public String getPromStatCd() {
		return promStatCd;
	}

	public void setPromStatCd(String promStatCd) {
		this.promStatCd = promStatCd;
	}
    
}
