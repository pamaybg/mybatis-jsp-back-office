/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionDefaultInfoReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 24. 오전 2:58:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 24.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionDefaultInfoReqDto
 * 2. 파일명	: LoyPromotionDefaultInfoReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionDefaultInfoReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promNo;
	private String promNm;
	private String descText;
	private String promStatCd;
	private String pgmRid;
	private String promGoalCd;
	private Integer maxRewardCnt;
	private String issDupYn;
	private String promTypeLv1Cd;
	private String promTypeLv2Cd;
	private String ofrRid;
	private String promOfferAmtDefCd;
	private String validStartDate;
	private String validStartTime;
	private String validEndDate;
	private String validEndTime;
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
	private Integer specialTimeFrom;
	private Integer specialTimeTo;
	private String promCalcCd;
	private String tgtGrpRid;
	private String expectTgtGrpRid;
	private String nodeType;
	private String stampRid;
	private String chnlGrpRid;
	private String notiYn;
	
	
	public String getNotiYn() {
		return notiYn;
	}
	public void setNotiYn(String notiYn) {
		this.notiYn = notiYn;
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
	public String getValidStartTime() {
		return validStartTime;
	}
	public void setValidStartTime(String validStartTime) {
		this.validStartTime = validStartTime;
	}
	public String getValidEndTime() {
		return validEndTime;
	}
	public void setValidEndTime(String validEndTime) {
		this.validEndTime = validEndTime;
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
	public String getNodeType() {
		return nodeType;
	}
	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
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
	public Integer getMaxRewardCnt() {
		return maxRewardCnt;
	}
	public void setMaxRewardCnt(Integer maxRewardCnt) {
		this.maxRewardCnt = maxRewardCnt;
	}
	public Integer getSpecialTimeFrom() {
		return specialTimeFrom;
	}
	public void setSpecialTimeFrom(Integer specialTimeFrom) {
		this.specialTimeFrom = specialTimeFrom;
	}
	public Integer getSpecialTimeTo() {
		return specialTimeTo;
	}
	public void setSpecialTimeTo(Integer specialTimeTo) {
		this.specialTimeTo = specialTimeTo;
	}
	
	
}
