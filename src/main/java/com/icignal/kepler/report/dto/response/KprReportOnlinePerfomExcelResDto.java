/*
 * Copyright 2016-2021 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: KprReportOnlinePerfomExcelResDto.java
 * 2. Package	: com.icignal.kepler.report.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2021. 5. 26. 오전 10:32:34
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
 * 1. 클래스명	: KprReportOnlinePerfomExcelResDto
 * 2. 파일명	: KprReportOnlinePerfomExcelResDto.java
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
public class KprReportOnlinePerfomExcelResDto extends GridPagingItemResDto{
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
	public String getStepCd() {
		return stepCd;
	}
	public void setStepCd(String stepCd) {
		this.stepCd = stepCd;
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
