package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignROICostListResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String accountId;    //어카운트ID
    private String campaignId;    //캠페인 ID
    
    private String costTypeCode;    //비용유형코드
    private String costTypeCodeName;    //비용유형코드명
    
    private String costName;    //비용명
    private String costDesc;    //비용상세
    private String costUcost;    //비용단가
    private String costCount;    //비용건수
    private String costAmt;    //비용금액
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
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

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getCostTypeCode() {
        return costTypeCode;
    }

    public void setCostTypeCode(String costTypeCode) {
        this.costTypeCode = costTypeCode;
    }
    
    public String getCostTypeCodeName() {
        return costTypeCodeName;
    }

    public void setCostTypeCodeName(String costTypeCodeName) {
        this.costTypeCodeName = costTypeCodeName;
    }
    
    public String getCostName() {
        return costName;
    }

    public void setCostName(String costName) {
        this.costName = costName;
    }

    public String getCostUcost() {
        return costUcost;
    }

    public void setCostUcost(String costUcost) {
        this.costUcost = costUcost;
    }

    public String getCostCount() {
        return costCount;
    }

    public void setCostCount(String costCount) {
        this.costCount = costCount;
    }

    public String getCostAmt() {
        return costAmt;
    }

    public void setCostAmt(String costAmt) {
        this.costAmt = costAmt;
    }

    public String getCostDesc() {
        return costDesc;
    }

    public void setCostDesc(String costDesc) {
        this.costDesc = costDesc;
    }

}
