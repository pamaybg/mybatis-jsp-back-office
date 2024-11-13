package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignROIReturnListResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    private String accountId;    //어카운트ID
    
    private String campaignId;    //캠페인 ID
    
    private String campaignDataDivCode;    //캠페인데이터구분코드
    private String campaignDataDivCodeName;    //캠페인데이터구분코드
    
    private String targetBaseGroupCode;    //대상기준그룹코드
    private String targetBaseGroupCodeName;    //대상기준그룹코드
    
    private String targetCustCount;    //대상고객건수
    
    private String responseTypeCode;    //반품유형코드
    private String responseTypeCodeName;    //반품유형코드
    
    private String responseCustCount;    //반응고객건수
    private String totalResponseAmt;    //전체반응금액
	
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

    public String getCampaignDataDivCode() {
        return campaignDataDivCode;
    }

    public void setCampaignDataDivCode(String campaignDataDivCode) {
        this.campaignDataDivCode = campaignDataDivCode;
    }

    public String getCampaignDataDivCodeName() {
        return campaignDataDivCodeName;
    }

    public void setCampaignDataDivCodeName(String campaignDataDivCodeName) {
        this.campaignDataDivCodeName = campaignDataDivCodeName;
    }

    public String getTargetBaseGroupCode() {
        return targetBaseGroupCode;
    }

    public void setTargetBaseGroupCode(String targetBaseGroupCode) {
        this.targetBaseGroupCode = targetBaseGroupCode;
    }

    public String getTargetBaseGroupCodeName() {
        return targetBaseGroupCodeName;
    }

    public void setTargetBaseGroupCodeName(String targetBaseGroupCodeName) {
        this.targetBaseGroupCodeName = targetBaseGroupCodeName;
    }

    public String getTargetCustCount() {
        return targetCustCount;
    }

    public void setTargetCustCount(String targetCustCount) {
        this.targetCustCount = targetCustCount;
    }

    public String getResponseTypeCode() {
        return responseTypeCode;
    }

    public void setResponseTypeCode(String responseTypeCode) {
        this.responseTypeCode = responseTypeCode;
    }

    public String getResponseTypeCodeName() {
        return responseTypeCodeName;
    }

    public void setResponseTypeCodeName(String responseTypeCodeName) {
        this.responseTypeCodeName = responseTypeCodeName;
    }

    public String getResponseCustCount() {
        return responseCustCount;
    }

    public void setResponseCustCount(String responseCustCount) {
        this.responseCustCount = responseCustCount;
    }

    public String getTotalResponseAmt() {
        return totalResponseAmt;
    }

    public void setTotalResponseAmt(String totalResponseAmt) {
        this.totalResponseAmt = totalResponseAmt;
    }

}
