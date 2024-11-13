package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
* @name : infavor.loyalty.campaign.dto.response.LOYCampaignListResponseDTO
* @date : 2018. 11. 19.
* @author : hy.jun
* @description :
*/

@CommCode
public class LOYCampaignListResDto extends GridPagingItemResDto{
	
    private String id;           //아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자
    private String createDate;   //생성일시
    private String modifyDate;   //수정일시
    
    private String offerId;      //오퍼ID
    private String offerNo; 	//오퍼번호
    private String offerName;    //오퍼명
    private String offerType;    //오퍼유형코드
    
    @MarkName(groupCode = "OFFER_TYPE_CD", codeField = "offerType")
    private String offerTypeName;    //오퍼유형코드명
    
    private String dispNo;       //표시 번호
    
    private String campaignStatusCode;     //상태 코드
    
    @MarkName(groupCode = "MKT_CAM_STAT", codeField = "campaignStatusCode")
    private String campaignStatusCodeName; //상태 코드명
    
    private String campaignName;        //캠페인명
    private String description;         //비고
    private String campaignStartDate;   //시작일
    private String campaignEndDate;     //종료일
    
    private String planOrgCode;         //기획조직
    private String planOrgCodeName;     //기획조직
    
    private String exeOrgLvlCode;       //실행 조직 레벨 코드
    
    @MarkName(groupCode = "ORG_LEVEL_CD", codeField = "exeOrgLvlCode")
    private String exeOrgLvlCodeName;   //실행 조직 레벨 코드명
    
    private String campaignPlanner;     //기획자
    private String campaignPlannerName; //기획자
    
    private String campaignPurposeCode;     //캠페인 목적
    @MarkName(groupCode = "MKT_CAM_GOAL_CD", codeField = "campaignPurposeCode")
    private String campaignPurposeCodeName; //캠페인 목적명
    
    private String campaignMethodCode;      //캠페인 수단
    @MarkName(groupCode = "MKT_CAM_SUB_GOAL_CD", codeField = "campaignMethodCode")
    private String campaignMethodCodeName;  //캠페인 수단명
    
    private String campaignMethodDesc;      //캠페인 수단비고
    
    private String channelTypeCode;     //실행 채널 구분
    
    @MarkName(groupCode = "MKT_CAM_CHNL_TYPE_CD", codeField = "channelTypeCode")
    private String channelTypeCodeName; //실행 채널 구분명
    
    private String campaignTypeCode;        //캠페인 유형
    
    @MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "campaignTypeCode")
    private String campaignTypeCodeName;    //캠페인 유형명
    
    private String parCampaignId;           //상위 캠페인 아이디
    private String programId;               //프로그램 아이디
    
    private String camTemplateUseYn;        //캠페인 템플릿 사용여부
    
    private String campaignApprovalStatusCode;      //캠페인 승인상태코드
    
    @MarkName(groupCode = "EL_APPROVAL_STATUS_CD", codeField = "campaignApprovalStatusCode")
    private String campaignApprovalStatusCodeName;  //캠페인 승인상태코드명;
    
    private String planId;          //마케팅 플랜 ID
    
    private String camScopeTypeCd;  //캠페인 범위 유형코드
    @MarkName(groupCode = "CAM_SCOPE_TYPE_CD", codeField = "camScopeTypeCd")
    private String camScopeTypeNm;  //캠페인 범위 유형명
    
    private String planGroupCd;     //기획그룹코드
    
    @MarkName(groupCode = "PLAN_GROUP_CD", codeField = "planGroupCd")
    private String planGroupNm;     //기획그룹명
    
    private String type;        // 유형

    private String promYn;        //프로모션여부
    private String camTgtTypeCd;  //타겟유형
    private String camTgtTypeNm;  //타겟유형명
    private String camTgtCnt;     //타겟건수
    
    private String pntAccntBigTypeCdNm; //대분류
    private String pntAccntMidTypeCdNm; //중분류
    private String pntAccntSmlTypeCdNm; //소분류
    private String pntAccntDetailTypeCdNm; //세분류
    
    private String validStartdtBasCdNm; //기준일자유형
    private String validStartDtnum; //혜택시작일
    private String validEndDtnum; //소멸예정월
    private String rdmSeq; //차감순서
    private String dividorChnlNo; //재원부서코드
    private String dividorChnlNm; //재원부서명
    private String pntAccntCodeVal; //회계코드

    private String pntAccntDetailTypeCd;
    
    private int selfTotAmt; //혜택금액

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

	public String getOfferNo() {
		return offerNo;
	}

	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}

	public String getOfferName() {
		return offerName;
	}

	public void setOfferName(String offerName) {
		this.offerName = offerName;
	}

	public String getOfferType() {
		return offerType;
	}

	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}

	public String getOfferTypeName() {
		return offerTypeName;
	}

	public void setOfferTypeName(String offerTypeName) {
		this.offerTypeName = offerTypeName;
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

	public String getCamScopeTypeNm() {
		return camScopeTypeNm;
	}

	public void setCamScopeTypeNm(String camScopeTypeNm) {
		this.camScopeTypeNm = camScopeTypeNm;
	}

	public String getPlanGroupCd() {
		return planGroupCd;
	}

	public void setPlanGroupCd(String planGroupCd) {
		this.planGroupCd = planGroupCd;
	}

	public String getPlanGroupNm() {
		return planGroupNm;
	}

	public void setPlanGroupNm(String planGroupNm) {
		this.planGroupNm = planGroupNm;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPromYn() {
		return promYn;
	}

	public void setPromYn(String promYn) {
		this.promYn = promYn;
	}

	public String getCamTgtTypeCd() {
		return camTgtTypeCd;
	}

	public void setCamTgtTypeCd(String camTgtTypeCd) {
		this.camTgtTypeCd = camTgtTypeCd;
	}

	public String getCamTgtTypeNm() {
		return camTgtTypeNm;
	}

	public void setCamTgtTypeNm(String camTgtTypeNm) {
		this.camTgtTypeNm = camTgtTypeNm;
	}

	public String getCamTgtCnt() {
		return camTgtCnt;
	}

	public void setCamTgtCnt(String camTgtCnt) {
		this.camTgtCnt = camTgtCnt;
	}

	public String getPntAccntBigTypeCdNm() {
		return pntAccntBigTypeCdNm;
	}

	public void setPntAccntBigTypeCdNm(String pntAccntBigTypeCdNm) {
		this.pntAccntBigTypeCdNm = pntAccntBigTypeCdNm;
	}

	public String getPntAccntMidTypeCdNm() {
		return pntAccntMidTypeCdNm;
	}

	public void setPntAccntMidTypeCdNm(String pntAccntMidTypeCdNm) {
		this.pntAccntMidTypeCdNm = pntAccntMidTypeCdNm;
	}

	public String getPntAccntSmlTypeCdNm() {
		return pntAccntSmlTypeCdNm;
	}

	public void setPntAccntSmlTypeCdNm(String pntAccntSmlTypeCdNm) {
		this.pntAccntSmlTypeCdNm = pntAccntSmlTypeCdNm;
	}

	public String getPntAccntDetailTypeCdNm() {
		return pntAccntDetailTypeCdNm;
	}

	public void setPntAccntDetailTypeCdNm(String pntAccntDetailTypeCdNm) {
		this.pntAccntDetailTypeCdNm = pntAccntDetailTypeCdNm;
	}

	public String getValidStartdtBasCdNm() {
		return validStartdtBasCdNm;
	}

	public void setValidStartdtBasCdNm(String validStartdtBasCdNm) {
		this.validStartdtBasCdNm = validStartdtBasCdNm;
	}

	public String getValidStartDtnum() {
		return validStartDtnum;
	}

	public void setValidStartDtnum(String validStartDtnum) {
		this.validStartDtnum = validStartDtnum;
	}

	public String getValidEndDtnum() {
		return validEndDtnum;
	}

	public void setValidEndDtnum(String validEndDtnum) {
		this.validEndDtnum = validEndDtnum;
	}

	public String getRdmSeq() {
		return rdmSeq;
	}

	public void setRdmSeq(String rdmSeq) {
		this.rdmSeq = rdmSeq;
	}

	public String getDividorChnlNo() {
		return dividorChnlNo;
	}

	public void setDividorChnlNo(String dividorChnlNo) {
		this.dividorChnlNo = dividorChnlNo;
	}

	public String getDividorChnlNm() {
		return dividorChnlNm;
	}

	public void setDividorChnlNm(String dividorChnlNm) {
		this.dividorChnlNm = dividorChnlNm;
	}

	public String getPntAccntCodeVal() {
		return pntAccntCodeVal;
	}

	public void setPntAccntCodeVal(String pntAccntCodeVal) {
		this.pntAccntCodeVal = pntAccntCodeVal;
	}

	public String getPntAccntDetailTypeCd() {
		return pntAccntDetailTypeCd;
	}

	public void setPntAccntDetailTypeCd(String pntAccntDetailTypeCd) {
		this.pntAccntDetailTypeCd = pntAccntDetailTypeCd;
	}

	public int getSelfTotAmt() {
		return selfTotAmt;
	}

	public void setSelfTotAmt(int selfTotAmt) {
		this.selfTotAmt = selfTotAmt;
	}


}
