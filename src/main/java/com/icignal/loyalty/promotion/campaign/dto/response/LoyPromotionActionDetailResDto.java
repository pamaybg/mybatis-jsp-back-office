/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionActionDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 30. 오전 9:16:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 30.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import java.util.ArrayList;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionActionDetailResDto
 * 2. 파일명	: LoyPromotionActionDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionActionDetailResDto extends StatusResDto{
	private String rid;
	private String promRid;
	private String maxAmt;
	private String effStrtDayCnt;
	private String effStrtDate;
	private String effDateType;
	private String stmpYn;
	private String tgtGrpActionRid;
	private String qpntTypeCd;
	private String qpntAmt;
	private String tgtGrpNm;
	private String tgtGrpNo;
	private String modifyDate;
	private String tiersYn;
	private String ofrType;
	private String cpnYn;
	
	
	private ArrayList<LoyPromotionTierActionDetailResDto> promotionTierAction;

	
	
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

	public String getTiersYn() {
		return tiersYn;
	}

	public void setTiersYn(String tiersYn) {
		this.tiersYn = tiersYn;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
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

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getMaxAmt() {
		return maxAmt;
	}

	public void setMaxAmt(String maxAmt) {
		this.maxAmt = maxAmt;
	}

	public String getEffStrtDayCnt() {
		return effStrtDayCnt;
	}

	public void setEffStrtDayCnt(String effStrtDayCnt) {
		this.effStrtDayCnt = effStrtDayCnt;
	}

	public String getEffStrtDate() {
		return effStrtDate;
	}

	public void setEffStrtDate(String effStrtDate) {
		this.effStrtDate = effStrtDate;
	}

	public String getEffDateType() {
		return effDateType;
	}

	public void setEffDateType(String effDateType) {
		this.effDateType = effDateType;
	}

	public String getStmpYn() {
		return stmpYn;
	}

	public void setStmpYn(String stmpYn) {
		this.stmpYn = stmpYn;
	}

	public String getTgtGrpActionRid() {
		return tgtGrpActionRid;
	}

	public void setTgtGrpActionRid(String tgtGrpActionRid) {
		this.tgtGrpActionRid = tgtGrpActionRid;
	}

	public String getQpntTypeCd() {
		return qpntTypeCd;
	}

	public void setQpntTypeCd(String qpntTypeCd) {
		this.qpntTypeCd = qpntTypeCd;
	}

	public String getQpntAmt() {
		return qpntAmt;
	}

	public void setQpntAmt(String qpntAmt) {
		this.qpntAmt = qpntAmt;
	}

	public ArrayList<LoyPromotionTierActionDetailResDto> getPromotionTierAction() {
		return promotionTierAction;
	}

	public void setPromotionTierAction(ArrayList<LoyPromotionTierActionDetailResDto> promotionTierAction) {
		this.promotionTierAction = promotionTierAction;
	}

	public String getPromRid() {
		return promRid;
	}

	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	
	
	
	
}
