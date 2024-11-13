package com.icignal.loyalty.promotion.campaign.dto.request;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CampaignApprovalReqDto extends MKTBaseReqDto {
	
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    
    private String approvalId;    //결재 ID
    
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getApprovalId() {
        return approvalId;
    }

    public void setApprovalId(String approvalId) {
        this.approvalId = approvalId;
    }


}
