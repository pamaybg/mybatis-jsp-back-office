/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: KprReportOnlinePerfomResDto.java
 * 2. Package	: com.icignal.kepler.report.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 5. 26. 오전 9:14:29
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021. 5. 26.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: KprReportOnlinePerfomResDto
 * 2. 파일명	: KprReportOnlinePerfomResDto.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2021. 5. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class KprReportOnlinePerfomResDto extends GridPagingItemResDto{
	private String yyyymmdd;
	private String registDate;
	private String depositDate;
	private String orderSeq;
	@MarkName(groupCode = "LOY_PUR_STAT_CD", codeField = "stepCd")
	private String step;
	private String stepCd;
	private String custTypeCd;
	@MarkName(groupCode = "LOY_CUST_TYPE_CD", codeField = "custTypeCd")
	private String custTypeCdNm;
	private String mbrTypeCd;
	@MarkName(groupCode = "LOY_MBR_TYPE_CD", codeField = "mbrTypeCd")
	private String mbrTypeCdNm;
	private String sbscTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscTypeCd")
	private String sbscTypeCdNm;
	private String mbrStatCd;
	@MarkName(groupCode = "LOY_MBR_STAT_CD", codeField = "mbrStatCd")
	private String mbrStatCdNm;
	private String sellAmt;
	private String settleAmt;
	private String discntAmt;
	private String shippingCost;
	private String emoney;
	private String mbrNo;
	
	//주문 옵션
	private String price; 
	private String ea; 
	private String memberSale;
	private String memberSaleRest;
	private String eventSale;
	private String couponSaleUnit;
	private String couponSaleRest;
	private String itemSeq;
	private String goodsName;
	private String optionCode1;
	private String goodsCode;
	
	
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getOptionCode1() {
		return optionCode1;
	}
	public void setOptionCode1(String optionCode1) {
		this.optionCode1 = optionCode1;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getEa() {
		return ea;
	}
	public void setEa(String ea) {
		this.ea = ea;
	}
	public String getMemberSale() {
		return memberSale;
	}
	public void setMemberSale(String memberSale) {
		this.memberSale = memberSale;
	}
	public String getMemberSaleRest() {
		return memberSaleRest;
	}
	public void setMemberSaleRest(String memberSaleRest) {
		this.memberSaleRest = memberSaleRest;
	}
	public String getEventSale() {
		return eventSale;
	}
	public void setEventSale(String eventSale) {
		this.eventSale = eventSale;
	}
	public String getCouponSaleUnit() {
		return couponSaleUnit;
	}
	public void setCouponSaleUnit(String couponSaleUnit) {
		this.couponSaleUnit = couponSaleUnit;
	}
	public String getCouponSaleRest() {
		return couponSaleRest;
	}
	public void setCouponSaleRest(String couponSaleRest) {
		this.couponSaleRest = couponSaleRest;
	}
	public String getItemSeq() {
		return itemSeq;
	}
	public void setItemSeq(String itemSeq) {
		this.itemSeq = itemSeq;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(String shippingCost) {
		this.shippingCost = shippingCost;
	}
	public String getEmoney() {
		return emoney;
	}
	public void setEmoney(String emoney) {
		this.emoney = emoney;
	}
	public String getStepCd() {
		return stepCd;
	}
	public void setStepCd(String stepCd) {
		this.stepCd = stepCd;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getRegistDate() {
		return registDate;
	}
	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	public String getDepositDate() {
		return depositDate;
	}
	public void setDepositDate(String depositDate) {
		this.depositDate = depositDate;
	}
	public String getOrderSeq() {
		return orderSeq;
	}
	public void setOrderSeq(String orderSeq) {
		this.orderSeq = orderSeq;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
	}
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getSellAmt() {
		return sellAmt;
	}
	public void setSellAmt(String sellAmt) {
		this.sellAmt = sellAmt;
	}
	public String getSettleAmt() {
		return settleAmt;
	}
	public void setSettleAmt(String settleAmt) {
		this.settleAmt = settleAmt;
	}
	public String getDiscntAmt() {
		return discntAmt;
	}
	public void setDiscntAmt(String discntAmt) {
		this.discntAmt = discntAmt;
	}
	
	
}
