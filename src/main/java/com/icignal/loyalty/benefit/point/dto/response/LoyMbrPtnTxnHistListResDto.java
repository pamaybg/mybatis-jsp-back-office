/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrPtnTxnHistListResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 13. 오후 2:47:22
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrPtnTxnHistListResDto
 * 2. 파일명	: LoyMbrPtnTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrPtnTxnHistListResDto extends GridPagingItemResDto {
	private String rid;
	private String txnNum;
	private String txnStatCd;
	@MarkName(groupCode="PNT_TXN_STAT_CD", codeField="txnStatCd")
	private String txnStatCdNm;
	private String apprNo;
	private String apprDt;
	@MarkName(groupCode="PNT_TXN_TYPE", codeField="pntTxnType1Cd")
	private String pntTxnTpye1CdNm;
	private String pntTxnType1Cd;
	@MarkName(groupCode="PNT_TXN_DTL_TYPE", codeField="pntTxnType2Cd")
	private String pntTxnType2CdNm;
	private String pntTxnType2Cd;
	private String chnlNm;
	private String txnAmt;
	private String pntAmt;
	private String txnDt;
	private String txnUniqNo;
	private String rceptNo; //영수증
	private String txnDate;
	private String txnTypeNm;
	private String txnSubTypeNm;
	private String txnDesc;
	private String salesAmt;
	private String mbrNo;
	private String ridMbrInt;
	private String usablePnt;
	private String txnDtlDesc;
	
	
	
	public String getTxnDtlDesc() {
		return txnDtlDesc;
	}
	public void setTxnDtlDesc(String txnDtlDesc) {
		this.txnDtlDesc = txnDtlDesc;
	}
	public String getUsablePnt() {
		return usablePnt;
	}
	public void setUsablePnt(String usablePnt) {
		this.usablePnt = usablePnt;
	}
	public String getRceptNo() {
		return rceptNo;
	}
	public void setRceptNo(String rceptNo) {
		this.rceptNo = rceptNo;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getTxnTypeNm() {
		return txnTypeNm;
	}
	public void setTxnTypeNm(String txnTypeNm) {
		this.txnTypeNm = txnTypeNm;
	}
	public String getTxnSubTypeNm() {
		return txnSubTypeNm;
	}
	public void setTxnSubTypeNm(String txnSubTypeNm) {
		this.txnSubTypeNm = txnSubTypeNm;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	private String apprDate;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getTxnStatCd() {
		return txnStatCd;
	}
	public void setTxnStatCd(String txnStatCd) {
		this.txnStatCd = txnStatCd;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getApprDt() {
		return apprDt;
	}
	public void setApprDt(String apprDt) {
		this.apprDt = apprDt;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getTxnStatCdNm() {
		return txnStatCdNm;
	}
	public void setTxnStatCdNm(String txnStatCdNm) {
		this.txnStatCdNm = txnStatCdNm;
	}
	public String getPntTxnTpye1CdNm() {
		return pntTxnTpye1CdNm;
	}
	public void setPntTxnTpye1CdNm(String pntTxnTpye1CdNm) {
		this.pntTxnTpye1CdNm = pntTxnTpye1CdNm;
	}
	public String getPntTxnType2CdNm() {
		return pntTxnType2CdNm;
	}
	public void setPntTxnType2CdNm(String pntTxnType2CdNm) {
		this.pntTxnType2CdNm = pntTxnType2CdNm;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getTxnDesc() {
		return txnDesc;
	}
	public void setTxnDesc(String txnDesc) {
		this.txnDesc = txnDesc;
	}
	public String getSalesAmt() {
		return salesAmt;
	}
	public void setSalesAmt(String salesAmt) {
		this.salesAmt = salesAmt;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRidMbrInt() {
		return ridMbrInt;
	}
	public void setRidMbrInt(String ridMbrInt) {
		this.ridMbrInt = ridMbrInt;
	}

	
}
