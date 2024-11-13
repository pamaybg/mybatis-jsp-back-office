/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionDefaultInfoResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 24. 오전 10:53:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 24.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionDefaultInfoResDto
 * 2. 파일명	: LoyPromotionDefaultInfoResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionDefaultInfoResDto extends StatusResDto{
	private String rid;
	private String promNo;
	private String promNm;
	private String descText;
	private String promStatCd;
	private String pgmRid;
	private String pgmNm;
	private String promGoalCd;
	private String maxRewardCnt;
	private String issDupYn;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
	private String ofrRid;
	private String ofrNm;
	private String ofrNo;
	private String stampRid;
	private String stampNo;
	private String stampNm;
	private String promOfferAmtDefCd;
	private String validStartDate;
	private String validEndDate;
	private String promCycleCd;
	private String cycleMonYn;
	private String cycleTueYn;
	private String cycleWedYn;
	private String cycleThuYn;
	private String cycleFriYn;
	private String cycleSatYn;
	private String cycleSunYn;
	private String specialDayFrom;
	private String specialDayTo;
	private String specialTimeFrom;
	private String specialTimeTo;
	private String promCalcCd;
	private String tgtGrpRid;
	private String expectTgtGrpRid;
	private String tgtGrpNm;
	private String tgtGrpNo;
	private String expectTgtGrpNo;
	private String expectTgtGrpNm;
	
	private String nodeType;
	private String modifyDate;
	private String promYn;
	private String campaignTypeCode;
	private String promSubType;
	
	private String createDate;
	private String name;
	private String divNm;
	
	private String id;
	private String chnlGrpRid;
	private String chnlGrpNo;
	private String chnlGrpNm;
	
	private String notiYn;
	private String ofrType;
	private String cpnYn;
	
	
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getNotiYn() {
		return notiYn;
	}
	public void setNotiYn(String notiYn) {
		this.notiYn = notiYn;
	}
	public String getChnlGrpNo() {
		return chnlGrpNo;
	}
	public void setChnlGrpNo(String chnlGrpNo) {
		this.chnlGrpNo = chnlGrpNo;
	}
	public String getChnlGrpNm() {
		return chnlGrpNm;
	}
	public void setChnlGrpNm(String chnlGrpNm) {
		this.chnlGrpNm = chnlGrpNm;
	}
	public String getChnlGrpRid() {
		return chnlGrpRid;
	}
	public void setChnlGrpRid(String chnlGrpRid) {
		this.chnlGrpRid = chnlGrpRid;
	}
	public String getStampRid() {
		return stampRid;
	}
	public void setStampRid(String stampRid) {
		this.stampRid = stampRid;
	}
	public String getStampNo() {
		return stampNo;
	}
	public void setStampNo(String stampNo) {
		this.stampNo = stampNo;
	}
	public String getStampNm() {
		return stampNm;
	}
	public void setStampNm(String stampNm) {
		this.stampNm = stampNm;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDivNm() {
		return divNm;
	}
	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getTgtGrpNm() {
		return tgtGrpNm;
	}
	public void setTgtGrpNm(String tgtGrpNm) {
		this.tgtGrpNm = tgtGrpNm;
	}
	public String getTgtGrpNo() {
		return tgtGrpNo;
	}
	public void setTgtGrpNo(String tgtGrpNo) {
		this.tgtGrpNo = tgtGrpNo;
	}
	public String getExpectTgtGrpNo() {
		return expectTgtGrpNo;
	}
	public void setExpectTgtGrpNo(String expectTgtGrpNo) {
		this.expectTgtGrpNo = expectTgtGrpNo;
	}
	public String getExpectTgtGrpNm() {
		return expectTgtGrpNm;
	}
	public void setExpectTgtGrpNm(String expectTgtGrpNm) {
		this.expectTgtGrpNm = expectTgtGrpNm;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getCampaignTypeCode() {
		return campaignTypeCode;
	}
	public void setCampaignTypeCode(String campaignTypeCode) {
		this.campaignTypeCode = campaignTypeCode;
	}
	public String getPromSubType() {
		return promSubType;
	}
	public void setPromSubType(String promSubType) {
		this.promSubType = promSubType;
	}
	public String getPromYn() {
		return promYn;
	}
	public void setPromYn(String promYn) {
		this.promYn = promYn;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getPromStatCd() {
		return promStatCd;
	}
	public void setPromStatCd(String promStatCd) {
		this.promStatCd = promStatCd;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getPromGoalCd() {
		return promGoalCd;
	}
	public void setPromGoalCd(String promGoalCd) {
		this.promGoalCd = promGoalCd;
	}
	public String getMaxRewardCnt() {
		return maxRewardCnt;
	}
	public void setMaxRewardCnt(String maxRewardCnt) {
		this.maxRewardCnt = maxRewardCnt;
	}
	public String getIssDupYn() {
		return issDupYn;
	}
	public void setIssDupYn(String issDupYn) {
		this.issDupYn = issDupYn;
	}
	public String getPromTypeLv1Cd() {
		return promTypeLv1Cd;
	}
	public void setPromTypeLv1Cd(String promTypeLv1Cd) {
		this.promTypeLv1Cd = promTypeLv1Cd;
	}
	public String getPromTypeLv2Cd() {
		return promTypeLv2Cd;
	}
	public void setPromTypeLv2Cd(String promTypeLv2Cd) {
		this.promTypeLv2Cd = promTypeLv2Cd;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getPromOfferAmtDefCd() {
		return promOfferAmtDefCd;
	}
	public void setPromOfferAmtDefCd(String promOfferAmtDefCd) {
		this.promOfferAmtDefCd = promOfferAmtDefCd;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getPromCycleCd() {
		return promCycleCd;
	}
	public void setPromCycleCd(String promCycleCd) {
		this.promCycleCd = promCycleCd;
	}
	public String getSpecialDayFrom() {
		return specialDayFrom;
	}
	public void setSpecialDayFrom(String specialDayFrom) {
		this.specialDayFrom = specialDayFrom;
	}
	public String getSpecialDayTo() {
		return specialDayTo;
	}
	public void setSpecialDayTo(String specialDayTo) {
		this.specialDayTo = specialDayTo;
	}
	public String getSpecialTimeFrom() {
		return specialTimeFrom;
	}
	public void setSpecialTimeFrom(String specialTimeFrom) {
		this.specialTimeFrom = specialTimeFrom;
	}
	public String getSpecialTimeTo() {
		return specialTimeTo;
	}
	public void setSpecialTimeTo(String specialTimeTo) {
		this.specialTimeTo = specialTimeTo;
	}
	public String getPromCalcCd() {
		return promCalcCd;
	}
	public void setPromCalcCd(String promCalcCd) {
		this.promCalcCd = promCalcCd;
	}
	public String getTgtGrpRid() {
		return tgtGrpRid;
	}
	public void setTgtGrpRid(String tgtGrpRid) {
		this.tgtGrpRid = tgtGrpRid;
	}
	public String getExpectTgtGrpRid() {
		return expectTgtGrpRid;
	}
	public void setExpectTgtGrpRid(String expectTgtGrpRid) {
		this.expectTgtGrpRid = expectTgtGrpRid;
	}
	public String getNodeType() {
		return nodeType;
	}
	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}
	public String getCycleMonYn() {
		return cycleMonYn;
	}
	public void setCycleMonYn(String cycleMonYn) {
		this.cycleMonYn = cycleMonYn;
	}
	public String getCycleTueYn() {
		return cycleTueYn;
	}
	public void setCycleTueYn(String cycleTueYn) {
		this.cycleTueYn = cycleTueYn;
	}
	public String getCycleWedYn() {
		return cycleWedYn;
	}
	public void setCycleWedYn(String cycleWedYn) {
		this.cycleWedYn = cycleWedYn;
	}
	public String getCycleThuYn() {
		return cycleThuYn;
	}
	public void setCycleThuYn(String cycleThuYn) {
		this.cycleThuYn = cycleThuYn;
	}
	public String getCycleFriYn() {
		return cycleFriYn;
	}
	public void setCycleFriYn(String cycleFriYn) {
		this.cycleFriYn = cycleFriYn;
	}
	public String getCycleSatYn() {
		return cycleSatYn;
	}
	public void setCycleSatYn(String cycleSatYn) {
		this.cycleSatYn = cycleSatYn;
	}
	public String getCycleSunYn() {
		return cycleSunYn;
	}
	public void setCycleSunYn(String cycleSunYn) {
		this.cycleSunYn = cycleSunYn;
	}
	
	
}
