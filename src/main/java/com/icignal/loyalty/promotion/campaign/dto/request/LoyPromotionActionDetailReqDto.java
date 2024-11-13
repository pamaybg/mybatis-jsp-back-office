/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionActionDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 29. 오후 6:50:51
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 29.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPromotionActionDetailReqDto
 * 2. 파일명	: LoyPromotionActionDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.promotion.campaign.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPromotionActionDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String promRid;
	private String maxAmt;
	private String effStrtDayCnt;
	private String effStrtDate;
	private String effDateType;
	private String stmpYn;
	private String actionTgtGrpRid;
	private String qpntTypeCd;
	private Integer qpntAmt;
	private String promActionRid;
	private String tgtGrpActionRid;
	private String tiersYn;
	
	private ArrayList<LoyPromotionTierActionReqDto> promotionTierAction;

	
	
	public String getTiersYn() {
		return tiersYn;
	}

	public void setTiersYn(String tiersYn) {
		this.tiersYn = tiersYn;
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

	public String getPromRid() {
		return promRid;
	}

	public void setPromRid(String promRid) {
		this.promRid = promRid;
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

	public String getActionTgtGrpRid() {
		return actionTgtGrpRid;
	}

	public void setActionTgtGrpRid(String actionTgtGrpRid) {
		this.actionTgtGrpRid = actionTgtGrpRid;
	}

	

	public Integer getQpntAmt() {
		return qpntAmt;
	}

	public void setQpntAmt(Integer qpntAmt) {
		this.qpntAmt = qpntAmt;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public ArrayList<LoyPromotionTierActionReqDto> getPromotionTierAction() {
		return promotionTierAction;
	}

	public void setPromotionTierAction(ArrayList<LoyPromotionTierActionReqDto> promotionTierAction) {
		this.promotionTierAction = promotionTierAction;
	}

	public String getPromActionRid() {
		return promActionRid;
	}

	public void setPromActionRid(String promActionRid) {
		this.promActionRid = promActionRid;
	}
	
	

}
