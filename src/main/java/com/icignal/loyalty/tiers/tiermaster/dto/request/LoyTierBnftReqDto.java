/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierBnftReqDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 2. 오후 2:02:33
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierBnftReqDto
 * 2. 파일명	: LoyTierBnftReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierBnftReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierBnftTypeCd;
	private String qty;
	private String bnftNm;
	private String offerRid;
	private String tierBnftGiveCycleCd;
	private String tierRid;
	private String bnftActCycleCd;
	private String bnftActRotCycleCd;
	private String amt;
	
	
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
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
