/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackTxnRuleDetailResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 6:41:26
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: LoyBlackTxnRuleDetailResDto
 * 2. 파일명	: LoyBlackTxnRuleDetailResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyBlackTxnRuleDetailResDto extends StatusResDto{
	private String rid;
	private String blCd;
	private String blNm;
	private String statCd;
	private String contents;
	private String pntAcrlLimitYn;
	private String pntRdmLimitYn;
	private String coupUsedLimitYn;
	private String salesLimitYn;
	private String periodMm;
	private String pgmRid;
	private String dayLimitYn;
	private String pgmNm;
	private String mgtAlertYn;
	private String fraudTypeCd;
	private String fraudSubTypeCd;
	
	
	public String getFraudTypeCd() {
		return fraudTypeCd;
	}
	public void setFraudTypeCd(String fraudTypeCd) {
		this.fraudTypeCd = fraudTypeCd;
	}
	public String getMgtAlertYn() {
		return mgtAlertYn;
	}
	public void setMgtAlertYn(String mgtAlertYn) {
		this.mgtAlertYn = mgtAlertYn;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBlCd() {
		return blCd;
	}
	public void setBlCd(String blCd) {
		this.blCd = blCd;
	}
	public String getBlNm() {
		return blNm;
	}
	public void setBlNm(String blNm) {
		this.blNm = blNm;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getPntAcrlLimitYn() {
		return pntAcrlLimitYn;
	}
	public void setPntAcrlLimitYn(String pntAcrlLimitYn) {
		this.pntAcrlLimitYn = pntAcrlLimitYn;
	}
	public String getPntRdmLimitYn() {
		return pntRdmLimitYn;
	}
	public void setPntRdmLimitYn(String pntRdmLimitYn) {
		this.pntRdmLimitYn = pntRdmLimitYn;
	}
	public String getCoupUsedLimitYn() {
		return coupUsedLimitYn;
	}
	public void setCoupUsedLimitYn(String coupUsedLimitYn) {
		this.coupUsedLimitYn = coupUsedLimitYn;
	}
	public String getSalesLimitYn() {
		return salesLimitYn;
	}
	public void setSalesLimitYn(String salesLimitYn) {
		this.salesLimitYn = salesLimitYn;
	}
	public String getPeriodMm() {
		return periodMm;
	}
	public void setPeriodMm(String periodMm) {
		this.periodMm = periodMm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getDayLimitYn() {
		return dayLimitYn;
	}
	public void setDayLimitYn(String dayLimitYn) {
		this.dayLimitYn = dayLimitYn;
	}
	public String getFraudSubTypeCd() {
		return fraudSubTypeCd;
	}
	public void setFraudSubTypeCd(String fraudSubTypeCd) {
		this.fraudSubTypeCd = fraudSubTypeCd;
	}
	
	
	
	
}
