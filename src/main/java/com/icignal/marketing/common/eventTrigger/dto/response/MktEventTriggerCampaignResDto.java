package com.icignal.marketing.common.eventTrigger.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNEventTriggerCampaignResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 트리거 캠페인 목록
 */
public class MktEventTriggerCampaignResDto extends StatusResDto {
	
	
    private String id;     //아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자
    private String createDate;     //생성일시
    private String modifyDate;     //수정일시
    
    private String offerId;    //오퍼ID
    private String offerName;    //오퍼명
    private String offerTypeCodeName;    //오퍼유형
    
    private String accountId;     //Account ID
    private String dispNo;     //표시 번호
    
    private String campaignStatusCode;     //상태 코드
    private String campaignStatusCodeName;     //상태 코드명
    
    private String campaignName;     //캠페인명
    private String description;     //비고
    private String campaignStartDate;     //시작일
    private String campaignEndDate;     //종료일
    
    private String planOrgCode;     //기획조직
    private String planOrgCodeName;     //기획조직
    
    private String exeOrgLvlCode;     //실행 조직 레벨 코드
    private String exeOrgLvlCodeName;     //실행 조직 레벨 코드명
    
    private String campaignPlanner;     //기획자
    private String campaignPlannerName;    //기획자명
    
    private String campaignPurposeCode;     //캠페인 목적
    private String campaignPurposeCodeName;     //캠페인 목적명
    
    private String campaignMethodCode;     //캠페인 수단
    private String campaignMethodCodeName;     //캠페인 수단명
    private String campaignMethodDesc;    //캠페인 수단비고
    
    private String channelTypeCode;     //실행 채널 구분
    private String channelTypeCodeName;     //실행 채널 구분명
    
    private String campaignTypeCode;     //캠페인 유형
    private String campaignTypeCodeName;     //캠페인 유형명
    
    private String parCampaignId;     //상위 캠페인 아이디
    private String programId;     //프로그램 아이디
    private String programName;    //프로그램명
    
    private String camTemplateUseYn;    //캠페인 템플릿 사용여부
    
    private String fatigueExceptYn;    //피로도 제외여부

    private String campaignCategoryCodeId;		//캠페인분류코드아이디
    private String intactType1Code;			//인터랙션 유형1 코드
    private String intactType1CodeName;		//인터랙션 유형1 코드명
    private String intactType2Code;			//인터랙션 유형2 코드
    private String intactType2CodeName;		//인터랙션 유형2 코드명
    
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

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
    }

    public String getOfferName() {
        return offerName;
    }

    public void setOfferName(String offerName) {
        this.offerName = offerName;
    }

    public String getOfferTypeCodeName() {
        return offerTypeCodeName;
    }

    public void setOfferTypeCodeName(String offerTypeCodeName) {
        this.offerTypeCodeName = offerTypeCodeName;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getDispNo() {
        return dispNo;
    }

    public void setDispNo(String dispNo) {
        this.dispNo = dispNo;
    }

    public String getCampaignStatusCode() {
        return campaignStatusCode;
    }

    public void setCampaignStatusCode(String campaignStatusCode) {
        this.campaignStatusCode = campaignStatusCode;
    }

    public String getCampaignStatusCodeName() {
        return campaignStatusCodeName;
    }

    public void setCampaignStatusCodeName(String campaignStatusCodeName) {
        this.campaignStatusCodeName = campaignStatusCodeName;
    }

    public String getCampaignName() {
        return campaignName;
    }

    public void setCampaignName(String campaignName) {
        this.campaignName = campaignName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCampaignStartDate() {
        return campaignStartDate;
    }

    public void setCampaignStartDate(String campaignStartDate) {
        this.campaignStartDate = campaignStartDate;
    }

    public String getCampaignEndDate() {
        return campaignEndDate;
    }

    public void setCampaignEndDate(String campaignEndDate) {
        this.campaignEndDate = campaignEndDate;
    }

    public String getPlanOrgCode() {
        return planOrgCode;
    }

    public void setPlanOrgCode(String planOrgCode) {
        this.planOrgCode = planOrgCode;
    }

    public String getPlanOrgCodeName() {
        return planOrgCodeName;
    }

    public void setPlanOrgCodeName(String planOrgCodeName) {
        this.planOrgCodeName = planOrgCodeName;
    }

    public String getExeOrgLvlCode() {
        return exeOrgLvlCode;
    }

    public void setExeOrgLvlCode(String exeOrgLvlCode) {
        this.exeOrgLvlCode = exeOrgLvlCode;
    }

    public String getExeOrgLvlCodeName() {
        return exeOrgLvlCodeName;
    }

    public void setExeOrgLvlCodeName(String exeOrgLvlCodeName) {
        this.exeOrgLvlCodeName = exeOrgLvlCodeName;
    }

    public String getCampaignPlanner() {
        return campaignPlanner;
    }

    public void setCampaignPlanner(String campaignPlanner) {
        this.campaignPlanner = campaignPlanner;
    }

    public String getCampaignPlannerName() {
        return campaignPlannerName;
    }

    public void setCampaignPlannerName(String campaignPlannerName) {
        this.campaignPlannerName = campaignPlannerName;
    }

    public String getCampaignPurposeCode() {
        return campaignPurposeCode;
    }

    public void setCampaignPurposeCode(String campaignPurposeCode) {
        this.campaignPurposeCode = campaignPurposeCode;
    }

    public String getCampaignPurposeCodeName() {
        return campaignPurposeCodeName;
    }

    public void setCampaignPurposeCodeName(String campaignPurposeCodeName) {
        this.campaignPurposeCodeName = campaignPurposeCodeName;
    }

    public String getCampaignMethodCode() {
        return campaignMethodCode;
    }

    public void setCampaignMethodCode(String campaignMethodCode) {
        this.campaignMethodCode = campaignMethodCode;
    }

    public String getCampaignMethodCodeName() {
        return campaignMethodCodeName;
    }

    public void setCampaignMethodCodeName(String campaignMethodCodeName) {
        this.campaignMethodCodeName = campaignMethodCodeName;
    }

    public String getCampaignMethodDesc() {
        return campaignMethodDesc;
    }

    public void setCampaignMethodDesc(String campaignMethodDesc) {
        this.campaignMethodDesc = campaignMethodDesc;
    }

    public String getChannelTypeCode() {
        return channelTypeCode;
    }

    public void setChannelTypeCode(String channelTypeCode) {
        this.channelTypeCode = channelTypeCode;
    }

    public String getChannelTypeCodeName() {
        return channelTypeCodeName;
    }

    public void setChannelTypeCodeName(String channelTypeCodeName) {
        this.channelTypeCodeName = channelTypeCodeName;
    }

    public String getCampaignTypeCode() {
        return campaignTypeCode;
    }

    public void setCampaignTypeCode(String campaignTypeCode) {
        this.campaignTypeCode = campaignTypeCode;
    }

    public String getCampaignTypeCodeName() {
        return campaignTypeCodeName;
    }

    public void setCampaignTypeCodeName(String campaignTypeCodeName) {
        this.campaignTypeCodeName = campaignTypeCodeName;
    }

    public String getParCampaignId() {
        return parCampaignId;
    }

    public void setParCampaignId(String parCampaignId) {
        this.parCampaignId = parCampaignId;
    }

    public String getProgramId() {
        return programId;
    }

    public void setProgramId(String programId) {
        this.programId = programId;
    }

    public String getCamTemplateUseYn() {
        return camTemplateUseYn;
    }

    public void setCamTemplateUseYn(String camTemplateUseYn) {
    	String yn = camTemplateUseYn;
        if ("1".equals(camTemplateUseYn)) {
        	yn = "true";
        } else {
        	yn = "false";
        }
        
        this.camTemplateUseYn = yn;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    public String getFatigueExceptYn() {
        return fatigueExceptYn;
    }

    public void setFatigueExceptYn(String fatigueExceptYn) {
    	String yn = fatigueExceptYn;
        if ("1".equals(fatigueExceptYn)) {
        	yn = "true";
        } else {
        	yn = "false";
        }
        
        this.fatigueExceptYn = yn;
    }

	public String getCampaignCategoryCodeId() {
		return campaignCategoryCodeId;
	}

	public void setCampaignCategoryCodeId(String campaignCategoryCodeId) {
		this.campaignCategoryCodeId = campaignCategoryCodeId;
	}

	public String getIntactType1Code() {
		return intactType1Code;
	}

	public String getIntactType1CodeName() {
		return intactType1CodeName;
	}

	public void setIntactType1CodeName(String intactType1CodeName) {
		this.intactType1CodeName = intactType1CodeName;
	}

	public String getIntactType2Code() {
		return intactType2Code;
	}

	public void setIntactType2Code(String intactType2Code) {
		this.intactType2Code = intactType2Code;
	}

	public String getIntactType2CodeName() {
		return intactType2CodeName;
	}

	public void setIntactType2CodeName(String intactType2CodeName) {
		this.intactType2CodeName = intactType2CodeName;
	}

}
