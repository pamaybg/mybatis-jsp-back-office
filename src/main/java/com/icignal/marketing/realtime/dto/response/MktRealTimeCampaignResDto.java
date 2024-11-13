package com.icignal.marketing.realtime.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;



public class MktRealTimeCampaignResDto  extends GridPagingItemResDto{

	 private String id;
	    private String createBy;
	    private String modifyBy;
	    private String createDate;
	    private String modifyDate;
	    private String offerId;
	    private String offerName;
	    private String accountId;
	    private String dispNo;
	    private String campaignName;
	    private String description;
	    private String campaignStartDate;
	    private String campaignEndDate;
	    private String planOrgCode;
	    private String planOrgCodeName;
	    private String campaignPlanner;
	    private String campaignPlannerName;
	    private String offerTypeName;
	    private String campaignStatusCode;
	    private String campaignStatusCodeName;
	    private String exeOrgLvlCode;
	    private String exeOrgLvlCodeName;
	    private String campaignPurposeCode;
	    private String campaignPurposeCodeName;
	    private String campaignMethodCode;
	    private String campaignMethodCodeName;
	    private String channelTypeCode;
	    private String channelTypeCodeName;
	    private String campaignTypeCode;
	    private String campaignTypeCodeName;
	    private String campaignApprovalStatusCode;
	    private String campaignApprovalStatusCodeName;
	    private String campaignMethodDesc;
	    private String parCampaignId;
	    private String programId;
	    private String planId;
	    private String camScopeTypeCd;
	    private String camScopeTypeNm;
	    private String planGroupCd;
	    private String planGroupNm;
	    private String promYn;
	    private Integer eventDataCnt;       // 이벤트 발생 건수
	    private Integer epntCnt;       // 포인트 적립 건수
	    private Integer foodOfferCnt;       // 개인화오퍼(유통) 제공건수
	    private Integer retailOfferCnt;  //개인화오퍼(외식) 제공건수
	    private Integer smsCnt;  //SMS 전송건수
	    private Integer lmsCnt;  //LMS 전송건수
	    private Integer mmsCnt;  //MMS 전송건수
	    private Integer kakaoCnt;  //카카오 친구톡 전송건수
	    private Integer pushCnt;  //PUSH 전송건수
	    private Integer emailCnt;  //EMAIL 전송 건수
	    private Integer kkoChatBotCnt; //카카오 챗봇 전송 건수
	    private String camNm;
	    
		public Integer getEventDataCnt() {
			return eventDataCnt;
		}
		public void setEventDataCnt(Integer eventDataCnt) {
			this.eventDataCnt = eventDataCnt;
		}
		public Integer getEpntCnt() {
			return epntCnt;
		}
		public void setEpntCnt(Integer epntCnt) {
			this.epntCnt = epntCnt;
		}
		public Integer getFoodOfferCnt() {
			return foodOfferCnt;
		}
		public void setFoodOfferCnt(Integer foodOfferCnt) {
			this.foodOfferCnt = foodOfferCnt;
		}
		public Integer getRetailOfferCnt() {
			return retailOfferCnt;
		}
		public void setRetailOfferCnt(Integer retailOfferCnt) {
			this.retailOfferCnt = retailOfferCnt;
		}
		public Integer getSmsCnt() {
			return smsCnt;
		}
		public void setSmsCnt(Integer smsCnt) {
			this.smsCnt = smsCnt;
		}
		public Integer getLmsCnt() {
			return lmsCnt;
		}
		public void setLmsCnt(Integer lmsCnt) {
			this.lmsCnt = lmsCnt;
		}
		public Integer getMmsCnt() {
			return mmsCnt;
		}
		public void setMmsCnt(Integer mmsCnt) {
			this.mmsCnt = mmsCnt;
		}
		public Integer getKakaoCnt() {
			return kakaoCnt;
		}
		public void setKakaoCnt(Integer kakaoCnt) {
			this.kakaoCnt = kakaoCnt;
		}
		public Integer getPushCnt() {
			return pushCnt;
		}
		public void setPushCnt(Integer pushCnt) {
			this.pushCnt = pushCnt;
		}
		public Integer getEmailCnt() {
			return emailCnt;
		}
		public void setEmailCnt(Integer emailCnt) {
			this.emailCnt = emailCnt;
		}
		public Integer getKkoChatBotCnt() {
			return kkoChatBotCnt;
		}
		public void setKkoChatBotCnt(Integer kkoChatBotCnt) {
			this.kkoChatBotCnt = kkoChatBotCnt;
		}
		public String getCamNm() {
			return camNm;
		}
		public void setCamNm(String camNm) {
			this.camNm = camNm;
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
		public String getOfferTypeName() {
			return offerTypeName;
		}
		public void setOfferTypeName(String offerTypeName) {
			this.offerTypeName = offerTypeName;
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
		public String getCampaignMethodDesc() {
			return campaignMethodDesc;
		}
		public void setCampaignMethodDesc(String campaignMethodDesc) {
			this.campaignMethodDesc = campaignMethodDesc;
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
		public String getPromYn() {
			return promYn;
		}
		public void setPromYn(String promYn) {
			this.promYn = promYn;
		}
	
}
