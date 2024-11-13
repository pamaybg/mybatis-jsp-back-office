package com.icignal.loyalty.promotion.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.GridPagingItemResDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignResourceListResDto extends GridPagingItemResDto {
	
    private String id;    //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String resourceId;    //캠페인아이디
    private String campaignId;    //자원아이디
    private String resourceUseAmt;    //자원사용금액
    
    private String resourceUseUnitCode;    //자원단위코드
    private String resourceUseUnitCodeName;    //자원단위코드
    
    private String resourceDtlDesc;    //자원상세설명
    
    
    private String resourceItemNo;    //아이템 번호
    private String resourceItemName;    //아이템 명
    private String resourceDesc;    //자원설명
    
    private String resourceStatusCode;    //자원상태코드
    private String resourceStatusCodeName;    //자원상태코드
    
    private String resourceEffectStartDate;    //자원유효시작일자
    private String resourceEffectEndDate;    //자원유효종료일자
    
    private String resourcePlanOrgCode;    //자원기획조직코드
    private String resourcePlanOrgCodeName;    //자원기획조직코드
    
    private String resourcePlanner;    //자원기획자
    private String resourcePlannerName;    //자원기획자명
    
    private String resourceTypeCode;    //자원유형코드
    private String resourceTypeCodeName;    //자원유형코드
    
    private String resourceTypeDtlCode;    //자원유형상세코드
    private String resourceTypeDtlCodeName;    //자원유형상세코드
    
    private String resourceAmt;    //자원금액
    
    private String resourceUnitCode;    //자원단위코드
    private String resourceUnitCodeName;    //자원단위코드
    
    private String itemNo;    //아이템번호
    private String itemName;    //아이템명
	
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

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getResourceUseAmt() {
        return resourceUseAmt;
    }

    public void setResourceUseAmt(String resourceUseAmt) {
        this.resourceUseAmt = resourceUseAmt;
    }

    public String getResourceUseUnitCode() {
        return resourceUseUnitCode;
    }

    public void setResourceUseUnitCode(String resourceUseUnitCode) {
        this.resourceUseUnitCode = resourceUseUnitCode;
    }

    public String getResourceUseUnitCodeName() {
        return resourceUseUnitCodeName;
    }

    public void setResourceUseUnitCodeName(String resourceUseUnitCodeName) {
        this.resourceUseUnitCodeName = resourceUseUnitCodeName;
    }

    public String getResourceDtlDesc() {
        return resourceDtlDesc;
    }

    public void setResourceDtlDesc(String resourceDtlDesc) {
        this.resourceDtlDesc = resourceDtlDesc;
    }

    public String getResourceItemNo() {
        return resourceItemNo;
    }

    public void setResourceItemNo(String resourceItemNo) {
        this.resourceItemNo = resourceItemNo;
    }

    public String getResourceItemName() {
        return resourceItemName;
    }

    public void setResourceItemName(String resourceItemName) {
        this.resourceItemName = resourceItemName;
    }

    public String getResourceDesc() {
        return resourceDesc;
    }

    public void setResourceDesc(String resourceDesc) {
        this.resourceDesc = resourceDesc;
    }

    public String getResourceStatusCode() {
        return resourceStatusCode;
    }

    public void setResourceStatusCode(String resourceStatusCode) {
        this.resourceStatusCode = resourceStatusCode;
    }

    public String getResourceStatusCodeName() {
        return resourceStatusCodeName;
    }

    public void setResourceStatusCodeName(String resourceStatusCodeName) {
        this.resourceStatusCodeName = resourceStatusCodeName;
    }

    public String getResourceEffectStartDate() {
        return resourceEffectStartDate;
    }

    public void setResourceEffectStartDate(String resourceEffectStartDate) {
        this.resourceEffectStartDate = resourceEffectStartDate;
    }

    public String getResourceEffectEndDate() {
        return resourceEffectEndDate;
    }

    public void setResourceEffectEndDate(String resourceEffectEndDate) {
        this.resourceEffectEndDate = resourceEffectEndDate;
    }

    public String getResourcePlanOrgCode() {
        return resourcePlanOrgCode;
    }

    public void setResourcePlanOrgCode(String resourcePlanOrgCode) {
        this.resourcePlanOrgCode = resourcePlanOrgCode;
    }

    public String getResourcePlanOrgCodeName() {
        return resourcePlanOrgCodeName;
    }

    public void setResourcePlanOrgCodeName(String resourcePlanOrgCodeName) {
        this.resourcePlanOrgCodeName = resourcePlanOrgCodeName;
    }

    public String getResourcePlanner() {
        return resourcePlanner;
    }

    public void setResourcePlanner(String resourcePlanner) {
        this.resourcePlanner = resourcePlanner;
    }

    public String getResourcePlannerName() {
        return resourcePlannerName;
    }

    public void setResourcePlannerName(String resourcePlannerName) {
        this.resourcePlannerName = resourcePlannerName;
    }

    public String getResourceTypeCode() {
        return resourceTypeCode;
    }

    public void setResourceTypeCode(String resourceTypeCode) {
        this.resourceTypeCode = resourceTypeCode;
    }

    public String getResourceTypeCodeName() {
        return resourceTypeCodeName;
    }

    public void setResourceTypeCodeName(String resourceTypeCodeName) {
        this.resourceTypeCodeName = resourceTypeCodeName;
    }

    public String getResourceTypeDtlCode() {
        return resourceTypeDtlCode;
    }

    public void setResourceTypeDtlCode(String resourceTypeDtlCode) {
        this.resourceTypeDtlCode = resourceTypeDtlCode;
    }

    public String getResourceTypeDtlCodeName() {
        return resourceTypeDtlCodeName;
    }

    public void setResourceTypeDtlCodeName(String resourceTypeDtlCodeName) {
        this.resourceTypeDtlCodeName = resourceTypeDtlCodeName;
    }

    public String getResourceAmt() {
        return resourceAmt;
    }

    public void setResourceAmt(String resourceAmt) {
        this.resourceAmt = resourceAmt;
    }

    public String getResourceUnitCode() {
        return resourceUnitCode;
    }

    public void setResourceUnitCode(String resourceUnitCode) {
        this.resourceUnitCode = resourceUnitCode;
    }

    public String getResourceUnitCodeName() {
        return resourceUnitCodeName;
    }

    public void setResourceUnitCodeName(String resourceUnitCodeName) {
        this.resourceUnitCodeName = resourceUnitCodeName;
    }

    public String getItemNo() {
        return itemNo;
    }

    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
	
}
