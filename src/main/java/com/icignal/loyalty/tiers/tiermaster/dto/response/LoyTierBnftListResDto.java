/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierBnftListResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 2. 오전 11:27:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 2.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyTierBnftListResDto
 * 2. 파일명	: LoyTierBnftListResDto.java
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
@CommCode
public class LoyTierBnftListResDto extends GridPagingItemResDto{
	private String rid;
	private String tierBnftTypeCd;
	@MarkName(groupCode="LOY_TIER_BNFT_TYPE_CD",codeField="tierBnftTypeCd")
	private String tierBnftTypeCdNm;
	private String qty;
	private String bnftNm;
	private String offerRid;
	private String ofrNm;
	private String tierBnftGiveCycleCd;
	@MarkName(groupCode="LOY_TIER_BNFT_GIVE_CYCLE",codeField="tierBnftGiveCycleCd")
	private String tierBnftGiveCycleCdNm;
	private String tierRid;
	private String ofrType;
	@MarkName(groupCode="LOY_OFR_TYPE",codeField="ofrType")
	private String ofrTypeNm;
	private String ofrSubType;
	@MarkName(groupCode="LOY_OFR_SUB_TYPE",codeField="ofrSubType")
	private String ofrSubTypeNm;
	private String ofrValType;
	@MarkName(groupCode="LOY_OFR_VAL_TYPE",codeField="ofrValType")
	private String ofrValTypeNm;
	private String ofrNo;
	private String ofrValAmt;
	private String cpnYn;
	private String ofrTypeCd;
	@MarkName(groupCode="LOY_TIER_BNFT_ACT_CYCLE",codeField="bnftActCycleCd")
	private String bnftActCycleCdNm;
	@MarkName(groupCode="LOY_TIER_BNFT_ACT_ROT_CYCLE",codeField="bnftActRotCycleCd")
	private String bnftActRotCycleCdNm;
	private String bnftActCycleCd;
	private String bnftActRotCycleCd;
	private String amt;
	
	
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getBnftActCycleCdNm() {
		return bnftActCycleCdNm;
	}
	public void setBnftActCycleCdNm(String bnftActCycleCdNm) {
		this.bnftActCycleCdNm = bnftActCycleCdNm;
	}
	public String getBnftActRotCycleCdNm() {
		return bnftActRotCycleCdNm;
	}
	public void setBnftActRotCycleCdNm(String bnftActRotCycleCdNm) {
		this.bnftActRotCycleCdNm = bnftActRotCycleCdNm;
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
	public String getOfrTypeCd() {
		return ofrTypeCd;
	}
	public void setOfrTypeCd(String ofrTypeCd) {
		this.ofrTypeCd = ofrTypeCd;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getOfrValTypeNm() {
		return ofrValTypeNm;
	}
	public void setOfrValTypeNm(String ofrValTypeNm) {
		this.ofrValTypeNm = ofrValTypeNm;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getOfrTypeNm() {
		return ofrTypeNm;
	}
	public void setOfrTypeNm(String ofrTypeNm) {
		this.ofrTypeNm = ofrTypeNm;
	}
	public String getOfrSubType() {
		return ofrSubType;
	}
	public void setOfrSubType(String ofrSubType) {
		this.ofrSubType = ofrSubType;
	}
	public String getOfrSubTypeNm() {
		return ofrSubTypeNm;
	}
	public void setOfrSubTypeNm(String ofrSubTypeNm) {
		this.ofrSubTypeNm = ofrSubTypeNm;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
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
	public String getTierBnftTypeCdNm() {
		return tierBnftTypeCdNm;
	}
	public void setTierBnftTypeCdNm(String tierBnftTypeCdNm) {
		this.tierBnftTypeCdNm = tierBnftTypeCdNm;
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
	
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getTierBnftGiveCycleCd() {
		return tierBnftGiveCycleCd;
	}
	public void setTierBnftGiveCycleCd(String tierBnftGiveCycleCd) {
		this.tierBnftGiveCycleCd = tierBnftGiveCycleCd;
	}
	public String getTierBnftGiveCycleCdNm() {
		return tierBnftGiveCycleCdNm;
	}
	public void setTierBnftGiveCycleCdNm(String tierBnftGiveCycleCdNm) {
		this.tierBnftGiveCycleCdNm = tierBnftGiveCycleCdNm;
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
