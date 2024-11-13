package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.util.ObjectUtil;


@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignROICostReqDto extends MKTBaseReqDto {
	
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    private String costTypeCode;    //비용유형코드
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

    public String getCostTypeCode() {
        return costTypeCode;
    }

    public void setCostTypeCode(String costTypeCode) {
        this.costTypeCode = costTypeCode;
    }

    public String getCostName() {
        return costName;
    }

    public void setCostName(String costName) {
        this.costName = costName;
    }

    public String getCostUcost() {
        costUcost = ObjectUtil.isEmpty(this.costUcost) ? null : this.costUcost;
        return costUcost;
    }

    public void setCostUcost(String costUcost) {
        this.costUcost = costUcost;
    }

    public String getCostCount() {
        costCount = ObjectUtil.isEmpty(this.costCount) ? null : this.costCount;
        return costCount;
    }

    public void setCostCount(String costCount) {
        this.costCount = costCount;
    }

    public String getCostAmt() {
        costAmt = ObjectUtil.isEmpty(this.costAmt) ? null : this.costAmt;
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
