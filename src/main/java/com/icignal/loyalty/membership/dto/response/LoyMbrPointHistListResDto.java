/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrPointHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 12. 오후 6:02:41
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 12.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrPointHistListResDto
 * 2. 파일명	: LoyMbrPointHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyMbrPointHistListResDto extends GridPagingItemResDto{
	private String txnDt;
	private String txnStatCd;
	private String apprNo;
	private String apprDt;
	private String ptnTxnType1Cd;
	private String ptnTxnType1CdNm;
	private String pntTxnType2Cd;
	private String pntTxnType2CdNm;
	private String ChnlNm;
	private String pntAmt;
	private String txnAmt;
	
	//포인트 양도이력
	private String txnUniqNo;
	private String txnDate;
	@Decrypted(masked = "none")
	private String custNm;
	@Decrypted(masked = "none")
	private String tgtCustNm;
	private String feeAmt;
	@MarkName(groupCode = "LOY_GIFT_FEE_LEVY_CD", codeField = "feeLevyCd")
	private String feeLevyCdNm;
	private String feeLevyCd;
	private String feeRcptNo;
	private String giftComment;
	private String rid;
	
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
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
	public String getPtnTxnType1Cd() {
		return ptnTxnType1Cd;
	}
	public void setPtnTxnType1Cd(String ptnTxnType1Cd) {
		this.ptnTxnType1Cd = ptnTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getChnlNm() {
		return ChnlNm;
	}
	public void setChnlNm(String chnlNm) {
		ChnlNm = chnlNm;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getPtnTxnType1CdNm() {
		return ptnTxnType1CdNm;
	}
	public void setPtnTxnType1CdNm(String ptnTxnType1CdNm) {
		this.ptnTxnType1CdNm = ptnTxnType1CdNm;
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
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getTgtCustNm() {
		return tgtCustNm;
	}
	public void setTgtCustNm(String tgtCustNm) {
		this.tgtCustNm = tgtCustNm;
	}
	public String getFeeAmt() {
		return feeAmt;
	}
	public void setFeeAmt(String feeAmt) {
		this.feeAmt = feeAmt;
	}
	public String getFeeLevyCd() {
		return feeLevyCd;
	}
	public void setFeeLevyCd(String feeLevyCd) {
		this.feeLevyCd = feeLevyCd;
	}
	public String getFeeRcptNo() {
		return feeRcptNo;
	}
	public void setFeeRcptNo(String feeRcptNo) {
		this.feeRcptNo = feeRcptNo;
	}
	public String getGiftComment() {
		return giftComment;
	}
	public void setGiftComment(String giftComment) {
		this.giftComment = giftComment;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFeeLevyCdNm() {
		return feeLevyCdNm;
	}
	public void setFeeLevyCdNm(String feeLevyCdNm) {
		this.feeLevyCdNm = feeLevyCdNm;
	}

}
