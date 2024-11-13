package com.icignal.loyalty.promotion.campaign.dto.request;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
/**
 * @name : MKTCampaignResponseDTO.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 기획/실행 기본정보 ResponseDTO
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignDefaultInfoReqDto extends CommonDataAuthReqDto {

	private String id;                     //아이디
	private String createDate;             //생성일시
	private String modifyDate;             //수정일시

	private String offerId;                //오퍼ID
	private String dispNo;                 //표시 번호

	private String campaignStatusCode;     //상태 코드
	private String campaignStatusCodeName; //상태 코드명

	private String campaignName;           //캠페인명
	private String description;            //비고
	private String campaignStartDate;      //시작일
	private String campaignEndDate;        //종료일

	private String planOrgCode;            //기획조직
	private String planOrgCodeName;        //기획조직

	private String exeOrgLvlCode;          //실행 조직 레벨 코드
	private String exeOrgLvlCodeName;      //실행 조직 레벨 코드명

	private String campaignPlanner;        //기획자

	private String campaignPurposeCode;    //캠페인 목적
	private String campaignPurposeCodeName;//캠페인 목적명

	private String campaignMethodCode;     //캠페인 수단
	private String campaignMethodCodeName; //캠페인 수단명
	private String campaignMethodDesc;     //캠페인 수단비고

	private String channelTypeCode;        //실행 채널 구분
	private String channelTypeCodeName;    //실행 채널 구분명

	private String campaignTypeCode;       //캠페인 유형
	private String campaignTypeCodeName;   //캠페인 유형명

	private String parCampaignId;          //상위 캠페인 아이디
	private String programId;              //프로그램 아이디

	private String camTemplateUseYn;       //캠페인 템플릿 사용여부

	private String fatigueExceptYn;        //피로도 제외여부

	private String campaignCategoryCodeId; //캠페인분류코드아이디
    private String ridIntactType;		   //인터랙션유형 아이디

    private String type;                   //MAK/LOY 마케팅과 로얄티 구분

    private String prmsExceptYn;           //퍼미션 검사여부
    private String promYn;                 //프로모션여부
    private String planId;                 //마케팅플랜ID
    private String camScopeTypeCd;         //캠페인 범위유형코드
    private String planGroupCd;            //기획그룹코드

    private String b2cRefKey;              //연관이벤트
    private String eventYn;                //이벤트여부

    private String pntAccntBigTypeCd; //대분류
    private String pntAccntMidTypeCd; //중분류
    private String pntAccntSmlTypeCd; //소분류
    private String pntAccntDetailTypeCd; //세분류
    private String pntAccntCustDispTxt; //안내문구
    
    private String pntAccntCodeVal; //회계계정코드
    
    private String promStatCd;
    
    
    
	public String getPromStatCd() {
		return promStatCd;
	}

	public void setPromStatCd(String promStatCd) {
		this.promStatCd = promStatCd;
	}

	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getEventYn() {
		return eventYn;
	}

	public void setEventYn(String eventYn) {
		String eventYndata = eventYn;
        if ("true".equals(eventYndata)) {
        	eventYndata = "1";
        } else {
        	eventYndata = "0";
        }
        this.eventYn = eventYndata;
    }

	public String getB2cRefKey() {
        return b2cRefKey;
    }

    public void setB2cRefKey(String b2cRefKey) {
        this.b2cRefKey = b2cRefKey;
    }

    public String getPrmsExceptYn() {
        return prmsExceptYn;
    }

    public void setPrmsExceptYn(String prmsExceptYn) {
    	String prmsExceptYndata = prmsExceptYn;
        if ("true".equals(prmsExceptYndata)) {
        	prmsExceptYndata = "1";
        } else {
        	prmsExceptYndata = "0";
        }

        this.prmsExceptYn = prmsExceptYndata;
    }

    public String getPromYn() {
        return promYn;
    }

    public void setPromYn(String promYn) {
    	String promYndata =promYn;
        if ("true".equals(promYndata)) {
        	promYndata = "1";
        } else {
        	promYndata = "0";
        }

        this.promYn = promYndata;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
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
        if ("true".equals(camTemplateUseYndata)) {
        	camTemplateUseYndata = "1";
        } else {
        	camTemplateUseYndata = "0";
        }

        this.camTemplateUseYn = camTemplateUseYndata;
    }

    public String getFatigueExceptYn() {
        return fatigueExceptYn;
    }

    public void setFatigueExceptYn(String fatigueExceptYn) {
    	String fatigueExceptYndata = fatigueExceptYn;
        if ("true".equals(fatigueExceptYndata)) {
        	fatigueExceptYndata = "1";
        } else {
        	fatigueExceptYndata = "0";
        }

        this.fatigueExceptYn = fatigueExceptYndata;
    }

	public String getCampaignCategoryCodeId() {
		return campaignCategoryCodeId;
	}

	public void setCampaignCategoryCodeId(String campaignCategoryCodeId) {
		this.campaignCategoryCodeId = campaignCategoryCodeId;
	}

	public String getRidIntactType() {
		return ridIntactType;
	}

	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
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
