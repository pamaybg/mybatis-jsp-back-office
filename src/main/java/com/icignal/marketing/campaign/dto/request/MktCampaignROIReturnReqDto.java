package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.util.ObjectUtil;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignROIReturnReqDto extends MKTBaseReqDto {
	
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    private String campaignDataDivCode;    //캠페인데이터구분코드
    private String targetBaseGroupCode;    //대상기준그룹코드
    private String targetCustCount;    //대상고객건수
    private String responseTypeCode;    //반품유형코드
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

    public String getCampaignDataDivCode() {
        return campaignDataDivCode;
    }

    public void setCampaignDataDivCode(String campaignDataDivCode) {
        this.campaignDataDivCode = campaignDataDivCode;
    }

    public String getTargetBaseGroupCode() {
        return targetBaseGroupCode;
    }

    public void setTargetBaseGroupCode(String targetBaseGroupCode) {
        this.targetBaseGroupCode = targetBaseGroupCode;
    }

    public String getTargetCustCount() {
        targetCustCount = ObjectUtil.isEmpty(this.targetCustCount) ? null : this.targetCustCount;
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

    public String getResponseCustCount() {
            responseCustCount = ObjectUtil.isEmpty(this.responseCustCount) ? null : this.responseCustCount;
        return responseCustCount;
    }

    public void setResponseCustCount(String responseCustCount) {
        this.responseCustCount = responseCustCount;
    }

    public String getTotalResponseAmt() {
        totalResponseAmt = ObjectUtil.isEmpty(this.totalResponseAmt) ? null : this.totalResponseAmt;
        return totalResponseAmt;
    }

    public void setTotalResponseAmt(String totalResponseAmt) {
        this.totalResponseAmt = totalResponseAmt;
    }

}
