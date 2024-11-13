package com.icignal.loyalty.promotion.campaign.dto.response;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MKTCampaignResponseDTO.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 기획/실행 기본정보 ResponseDTO
 */
public class CampaignDefaultInfoResDto extends StatusResDto {

    private String id;          //아이디
    private String createBy;    //생성자
    private String modifyBy;    //수정자
    private String createDate;  //생성일시
    private String modifyDate;  //수정일시

    private String offerId;     //오퍼ID
    private String offerName;   //오퍼명
    private String offerTypeCodeName; //오퍼유형

    private String dispNo;      //표시 번호

    private String campaignStatusCode;      //상태 코드
    private String campaignStatusCodeName;  //상태 코드명

    private String campaignName;        //캠페인명
    private String description;         //비고
    private String campaignStartDate;   //시작일
    private String campaignEndDate;     //종료일

    private String planOrgCode;         //기획조직
    private String planOrgCodeName;     //기획조직

    private String exeOrgLvlCode;       //실행 조직 레벨 코드
    private String exeOrgLvlCodeName;   //실행 조직 레벨 코드명

    private String campaignPlanner;     //기획자
    private String campaignPlannerName; //기획자명

    private String campaignPurposeCode;     //캠페인 목적
    private String campaignPurposeCodeName; //캠페인 목적명

    private String campaignMethodCode;      //캠페인 수단
    private String campaignMethodCodeName;  //캠페인 수단명
    private String campaignMethodDesc;      //캠페인 수단비고

    private String channelTypeCode;     //실행 채널 구분
    private String channelTypeCodeName; //실행 채널 구분명

    private String campaignTypeCode;     //캠페인 유형
    private String campaignTypeCodeName; //캠페인 유형명

    private String parCampaignId;   //상위 캠페인 아이디
    private String parDispNo;       //상위 캠페인 번호
    private String programId;       //프로그램 아이디
    private String programName;     //프로그램명

    private String camTemplateUseYn;    //캠페인 템플릿 사용여부

    private String fatigueExceptYn;     //피로도 제외여부

    private String campaignCategoryCodeId;	//캠페인분류코드아이디

    private String ridIntactType;		//인터랙션유형 아이디
    private String intactType1Code;		//인터랙션 유형1 코드
    private String intactType1CodeName;	//인터랙션 유형1 코드명
    private String intactType2Code;		//인터랙션 유형2 코드
    private String intactType2CodeName;	//인터랙션 유형2 코드명

    private String promType;	    //프로모션혜택 유형
    private String promTypeNm;	    //프로모션혜택 유형명
    private String promSubType;		//지급기준유형
    private String promSubTypeNm;	//지급기준유형명
    private String execType;		//산출방법유형
    private String execTypeNm;		//산출방법유형명

    private String ruleProdType;    // 대상상품 혜택
    private String ruleProdTypeNm;  // 대상상품 혜택명

    private String campaignApprovalStatusCode;      //캠페인 승인상태코드
    private String campaignApprovalStatusCodeName;  //캠페인 승인상태코드명

    private String prmsExceptYn;    //퍼미션 검사여부
    private String planId;          //마케팅 플랜 ID
    private String planNm;          //마케팅 플랜 명
    private String camScopeTypeCd;  //캠페인 범위 유형코드
    private String planGroupCd;     //기획그룹코드
    private String promYn;

    private String b2cRefKey;       //연관이벤트
    private String type;            //캠페인 유형 ex)MKT,STN...
    private String eventYn;            //캠페인 유형 ex)MKT,STN...
    
    private String pntAccntBigTypeCd; //대분류
    private String pntAccntMidTypeCd; //중분류
    private String pntAccntSmlTypeCd; //소분류
    private String pntAccntDetailTypeCd; //세분류
    private String pntAccntCustDispTxt; //안내문구
    
    private String pntAccntCodeVal; //회계계정코드

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getEventYn() {
		return eventYn;
	}

	public void setEventYn(String eventYn) {
		this.eventYn = eventYn;
	}

	public String getParDispNo() {
        return parDispNo;
    }

    public void setParDispNo(String parDispNo) {
        this.parDispNo = parDispNo;
    }

    public String getB2cRefKey() {
        return b2cRefKey;
    }

    public void setB2cRefKey(String b2cRefKey) {
        this.b2cRefKey = b2cRefKey;
    }

    public String getPlanNm() {
        return planNm;
    }

    public void setPlanNm(String planNm) {
        this.planNm = planNm;
    }

    public String getPromYn() {
        return promYn;
    }

    public void setPromYn(String promYn) {
        this.promYn = promYn;
    }

    public String getPrmsExceptYn() {
        return prmsExceptYn;
    }

    public void setPrmsExceptYn(String prmsExceptYn) {
        this.prmsExceptYn = prmsExceptYn;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getCamScopeTypeCd() {
        return camScopeTypeCd;
    }

    public void setCamScopeTypeCd(String camScopeTypeCd) {
        this.camScopeTypeCd = camScopeTypeCd;
    }

    public String getPlanGroupCd() {
        return planGroupCd;
    }

    public void setPlanGroupCd(String planGroupCd) {
        this.planGroupCd = planGroupCd;
    }

    public String getCampaignApprovalStatusCode() {
        return campaignApprovalStatusCode;
    }

    public void setCampaignApprovalStatusCode(String campaignApprovalStatusCode) {
        this.campaignApprovalStatusCode = campaignApprovalStatusCode;
    }

    public String getCampaignApprovalStatusCodeName() {
        return campaignApprovalStatusCodeName;
    }

    public void setCampaignApprovalStatusCodeName(String campaignApprovalStatusCodeName) {
        this.campaignApprovalStatusCodeName = campaignApprovalStatusCodeName;
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
    	String camTemplateUseYndata = camTemplateUseYn;
        if ("1".equals(camTemplateUseYndata)) {
        	camTemplateUseYndata = "true";
        } else {
        	camTemplateUseYndata = "false";
        }

        this.camTemplateUseYn = camTemplateUseYndata;
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
    	String fatigueExceptYndata = fatigueExceptYn;
        if ("1".equals(fatigueExceptYndata)) {
        	fatigueExceptYndata = "true";
        } else {
        	fatigueExceptYndata = "false";
        }

        this.fatigueExceptYn = fatigueExceptYn;
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

	public String getRidIntactType() {
		return ridIntactType;
	}

	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}

	public String getPromType() {
		return promType;
	}

	public void setPromType(String promType) {
		this.promType = promType;
	}

	public String getPromTypeNm() {
		return promTypeNm;
	}

	public void setPromTypeNm(String promTypeNm) {
		this.promTypeNm = promTypeNm;
	}

	public String getPromSubType() {
		return promSubType;
	}

	public void setPromSubType(String promSubType) {
		this.promSubType = promSubType;
	}

	public String getPromSubTypeNm() {
		return promSubTypeNm;
	}

	public void setPromSubTypeNm(String promSubTypeNm) {
		this.promSubTypeNm = promSubTypeNm;
	}

	public String getExecType() {
		return execType;
	}

	public void setExecType(String execType) {
		this.execType = execType;
	}

	public String getExecTypeNm() {
		return execTypeNm;
	}

	public void setExecTypeNm(String execTypeNm) {
		this.execTypeNm = execTypeNm;
	}

	public void setIntactType1Code(String intactType1Code) {
		this.intactType1Code = intactType1Code;
	}

    public String getRuleProdType() {
        return ruleProdType;
    }

    public void setRuleProdType(String ruleProdType) {
        this.ruleProdType = ruleProdType;
    }

    public String getRuleProdTypeNm() {
        return ruleProdTypeNm;
    }

    public void setRuleProdTypeNm(String ruleProdTypeNm) {
        this.ruleProdTypeNm = ruleProdTypeNm;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPntAccntBigTypeCd() {
		return pntAccntBigTypeCd;
	}

	public void setPntAccntBigTypeCd(String pntAccntBigTypeCd) {
		this.pntAccntBigTypeCd = pntAccntBigTypeCd;
	}

	public String getPntAccntMidTypeCd() {
		return pntAccntMidTypeCd;
	}

	public void setPntAccntMidTypeCd(String pntAccntMidTypeCd) {
		this.pntAccntMidTypeCd = pntAccntMidTypeCd;
	}

	public String getPntAccntSmlTypeCd() {
		return pntAccntSmlTypeCd;
	}

	public void setPntAccntSmlTypeCd(String pntAccntSmlTypeCd) {
		this.pntAccntSmlTypeCd = pntAccntSmlTypeCd;
	}

	public String getPntAccntDetailTypeCd() {
		return pntAccntDetailTypeCd;
	}

	public void setPntAccntDetailTypeCd(String pntAccntDetailTypeCd) {
		this.pntAccntDetailTypeCd = pntAccntDetailTypeCd;
	}

	public String getPntAccntCustDispTxt() {
		return pntAccntCustDispTxt;
	}

	public void setPntAccntCustDispTxt(String pntAccntCustDispTxt) {
		this.pntAccntCustDispTxt = pntAccntCustDispTxt;
	}

	public String getPntAccntCodeVal() {
		return pntAccntCodeVal;
	}

	public void setPntAccntCodeVal(String pntAccntCodeVal) {
		this.pntAccntCodeVal = pntAccntCodeVal;
	}

}
