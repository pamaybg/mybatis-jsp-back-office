package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 캠페인 삭제 Req Dto
 * 
 * @name : infavor.marketing.campaign.dto.request.MktCampaignRemoveReqDto
 * @date : 2017. 11. 29.
 * @author : jh.kim
 * @description :
 */
public class MktCampaignRemoveReqDto extends MKTBaseReqDto {
    
    private String id;                          // 캠페인 id
    private String campaignStatusCode;          // 캠페인 상태코드
    private String campaignApprovalStatusCode;  // 결제 상태코드
    
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
    
}
