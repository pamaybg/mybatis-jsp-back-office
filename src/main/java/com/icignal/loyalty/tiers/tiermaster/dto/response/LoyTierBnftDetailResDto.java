/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierBnftDetailResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 2. 오후 1:52:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyTierBnftDetailResDto
 * 2. 파일명	: LoyTierBnftDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierBnftDetailResDto extends StatusResDto{
	private String rid;
	private String tierBnftTypeCd;
	private String qty;
	private String bnftNm;
	private String offerRid;
	private String offerNm;
	private String tierBnftGiveCycleCd;
	private String tierRid;
	private String offerNo;
	private String cpnYn;
	private String bnftActCycleCd;
	private String bnftActRotCycleCd;
	private String ofrType;
	private String ofrSubType;
	private String ofrValType;
	private String ofrValAmt;
	private String amt;
	
	
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getOfrSubType() {
		return ofrSubType;
	}
	public void setOfrSubType(String ofrSubType) {
		this.ofrSubType = ofrSubType;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getBnftActCycleCd() {
		return bnftActCycleCd;
	}
	public void setBnftActCycleCd(String bnftActCycleCd) {
		this.bnftActCycleCd = bnftActCycleCd;
	}
	public String getBnftActRotCycleCd() {
		return bnftActRotCycleCd;
	}
	public void setBnftActRotCycleCd(String bnftActRotCycleCd) {
		this.bnftActRotCycleCd = bnftActRotCycleCd;
	}
	public String getOfferNo() {
		return offerNo;
	}
	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getBnftNm() {
		return bnftNm;
	}
	public void setBnftNm(String bnftNm) {
		this.bnftNm = bnftNm;
	}
	public String getOfferRid() {
		return offerRid;
	}
	public void setOfferRid(String offerRid) {
		this.offerRid = offerRid;
	}
	public String getOfferNm() {
		return offerNm;
	}
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}
	public String getTierBnftGiveCycleCd() {
		return tierBnftGiveCycleCd;
	}
	public void setTierBnftGiveCycleCd(String tierBnftGiveCycleCd) {
		this.tierBnftGiveCycleCd = tierBnftGiveCycleCd;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getTierBnftTypeCd() {
		return tierBnftTypeCd;
	}
	public void setTierBnftTypeCd(String tierBnftTypeCd) {
		this.tierBnftTypeCd = tierBnftTypeCd;
	}
	
	
}
