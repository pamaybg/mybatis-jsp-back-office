/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromotionTierActionDetailResDto.java
 * 2. Package	: com.icignal.loyalty.promotion.campaign.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 30. 오전 9:18:07
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 30.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyPromotionTierActionDetailResDto
 * 2. 파일명	: LoyPromotionTierActionDetailResDto.java
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

public class LoyPromotionTierActionDetailResDto extends StatusResDto{
	private String rid;
	private String promRid;
	private String promActRid;
	private String seqNo;
	private String tierGroupRid;
	private String tierRid;
	private String ofrAmt;
	private String ofrAmtType;
	private String effStrtDayCnt;
	private String tierGrpNm;
	private String tierNm;
	private String tierTypeCd;
	private String tierEffStrtDayCnt;
	
	
	public String getTierEffStrtDayCnt() {
		return tierEffStrtDayCnt;
	}
	public void setTierEffStrtDayCnt(String tierEffStrtDayCnt) {
		this.tierEffStrtDayCnt = tierEffStrtDayCnt;
	}
	public String getOfrAmt() {
		return ofrAmt;
	}
	public void setOfrAmt(String ofrAmt) {
		this.ofrAmt = ofrAmt;
	}
	public String getTierTypeCd() {
		return tierTypeCd;
	}
	public void setTierTypeCd(String tierTypeCd) {
		this.tierTypeCd = tierTypeCd;
	}
	public String getTierGrpNm() {
		return tierGrpNm;
	}
	public void setTierGrpNm(String tierGrpNm) {
		this.tierGrpNm = tierGrpNm;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getPromActRid() {
		return promActRid;
	}
	public void setPromActRid(String promActRid) {
		this.promActRid = promActRid;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getTierGroupRid() {
		return tierGroupRid;
	}
	public void setTierGroupRid(String tierGroupRid) {
		this.tierGroupRid = tierGroupRid;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getOfrAmtType() {
		return ofrAmtType;
	}
	public void setOfrAmtType(String ofrAmtType) {
		this.ofrAmtType = ofrAmtType;
	}
	public String getEffStrtDayCnt() {
		return effStrtDayCnt;
	}
	public void setEffStrtDayCnt(String effStrtDayCnt) {
		this.effStrtDayCnt = effStrtDayCnt;
	}
	
	
}
