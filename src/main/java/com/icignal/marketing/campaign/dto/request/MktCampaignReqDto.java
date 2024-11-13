package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MktCampaignReqDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 기획/실행 ReqDto
 */
public class MktCampaignReqDto extends CommonDataAuthReqDto {
	
    private String id;     //아이디
    private String createDate;     //생성일시
    private String modifyDate;     //수정일시
    
    private String offerId;    //오퍼ID
    private String offerName;    //오퍼명
    private String offerTypeCodeName;    //오퍼유형
    
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
    
    private String camTemplateUseYn;    //캠페인 템플릿 사용여부
    
    private String segId;			//세그먼트 아이디
    private String chnlType;		//채널 유형
    
    private String nodeType;        //노드 유형
	
    private String type;
    private String camStoreUseYn;		//스토어사용여부
    
    private String resultCd;			//procCamCopy 실행 결과 코드
    private String resultMsg;			//procCamCopy 실행 결과 메세지

    private String empId;
    private String empType;
    private String authType;
    private String divRid;
    private String brandCd;

    private String offerTableName;

    @Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
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
        this.camTemplateUseYn = camTemplateUseYn;
    }

	public String getSegId() {
		return segId;
	}

	public void setSegId(String segId) {
		this.segId = segId;
	}

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}

    public String getNodeType() {
        return nodeType;
    }

    public void setNodeType(String nodeType) {
        this.nodeType = nodeType;
    }

	public String getCamStoreUseYn() {
		return camStoreUseYn;
	}

	public void setCamStoreUseYn(String camStoreUseYn) {
		this.camStoreUseYn = camStoreUseYn;
	}
	
	public String getResultCd() {
		return resultCd;
	}

	public void setResultCd(String resultCd) {
		this.resultCd = resultCd;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

    public String getEmpId() {return empId;}

    public void setEmpId(String empId) {this.empId = empId;}

    public String getEmpType() {return empType;}

    public void setEmpType(String empType) {this.empType = empType;}

    public String getAuthType() {return authType;}

    public void setAuthType(String authType) {this.authType = authType;}

    public String getDivRid() {return divRid;}

    public void setDivRid(String divRid) {this.divRid = divRid;}

    public String getBrandCd() {return brandCd;}

    public void setBrandCd(String brandCd) {this.brandCd = brandCd;}

    public String getOfferTableName() {
        return offerTableName;
    }

    public void setOfferTableName(String offerTableName) {
        this.offerTableName = offerTableName;
    }
}
