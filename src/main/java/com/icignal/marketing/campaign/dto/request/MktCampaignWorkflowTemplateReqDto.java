package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MktCampaignWorkflowTemplateReqDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 워크플로우 템플릿
 */
public class MktCampaignWorkflowTemplateReqDto extends CommonDataAuthReqDto {
	
    private String campaignId;    //캠페인 ID
    private String workflowId;    //워크플로우 ID
    
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String wfCamTypeCode;    //워크플로우캠페인유형코드
    private String wfCamPrpsCode;    //워크플로우캠페인목적코드
    private String wfName;    //워크플로우 명
    private String wfDesc;    //워크플로우 설명
    private String wfDtlDesc;    //워크플로우 상세 설명
    
    private String templateUseFlag;     //템플릿사용여부

    private String storeYn;     //매장사용여부
    private String brandCd;     //브랜드 코드
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
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

    public String getWfCamTypeCode() {
        return wfCamTypeCode;
    }

    public void setWfCamTypeCode(String wfCamTypeCode) {
        this.wfCamTypeCode = wfCamTypeCode;
    }

    public String getWfCamPrpsCode() {
        return wfCamPrpsCode;
    }

    public void setWfCamPrpsCode(String wfCamPrpsCode) {
        this.wfCamPrpsCode = wfCamPrpsCode;
    }

    public String getWfName() {
        return wfName;
    }

    public void setWfName(String wfName) {
        this.wfName = wfName;
    }

    public String getWfDesc() {
        return wfDesc;
    }

    public void setWfDesc(String wfDesc) {
        this.wfDesc = wfDesc;
    }

    public String getWfDtlDesc() {
        return wfDtlDesc;
    }

    public void setWfDtlDesc(String wfDtlDesc) {
        this.wfDtlDesc = wfDtlDesc;
    }

    public String getWorkflowId() {
        return workflowId;
    }

    public void setWorkflowId(String workflowId) {
        this.workflowId = workflowId;
    }

    public String getTemplateUseFlag() {
        return templateUseFlag;
    }

    public void setTemplateUseFlag(String templateUseFlag) {
        this.templateUseFlag = templateUseFlag;
    }

    public String getStoreYn() {return storeYn;}

    public void setStoreYn(String storeYn) {this.storeYn = storeYn;}

    public String getBrandCd() {return brandCd;}

    public void setBrandCd(String brandCd) {this.brandCd = brandCd;}
}
