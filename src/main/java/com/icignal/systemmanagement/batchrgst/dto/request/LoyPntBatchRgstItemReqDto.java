/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPntBatchRgstItemReqDto.java
 * 2. Package	: com.icignal.systemmanagement.batchrgst.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 16. 오후 3:54:15
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyPntBatchRgstItemReqDto
 * 2. 파일명	: LoyPntBatchRgstItemReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyPntBatchRgstItemReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String ridPntUpload;
	private String mbrNo;
	private String targetNm;
	private String targetHhpNo;
	private String acrlAmt;
	private String validStartDate;
	private String validEndDate;
	private String batchResultCd;
	private String batchErrorDesc;
	private String ridMbr;
	private String dispNo; //프로모션 캠페인코드

	//ridMbr 기준으로 조회된 회원정보
	private String mbrNoChk;
	private String custNmChk;
	private String mbrStatCdChk;
	private String mbrStatCdNmChk;

	private String cipherKey;

	private String ci;

	private String approvalNum;
	private String txnNum;
	private String requestDt;

	private String ridMbrUpload;
	private String hhpNo;
	private String custNm;
	private String ridCam;
	private String webId;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPntUpload() {
		return ridPntUpload;
	}
	public void setRidPntUpload(String ridPntUpload) {
		this.ridPntUpload = ridPntUpload;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getTargetNm() {
		return targetNm;
	}
	public void setTargetNm(String targetNm) {
		this.targetNm = targetNm;
	}
	public String getTargetHhpNo() {
		return targetHhpNo;
	}
	public void setTargetHhpNo(String targetHhpNo) {
		this.targetHhpNo = targetHhpNo;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getBatchResultCd() {
		return batchResultCd;
	}
	public void setBatchResultCd(String batchResultCd) {
		this.batchResultCd = batchResultCd;
	}
	public String getBatchErrorDesc() {
		return batchErrorDesc;
	}
	public void setBatchErrorDesc(String batchErrorDesc) {
		this.batchErrorDesc = batchErrorDesc;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getMbrNoChk() {
		return mbrNoChk;
	}
	public void setMbrNoChk(String mbrNoChk) {
		this.mbrNoChk = mbrNoChk;
	}
	public String getCustNmChk() {
		return custNmChk;
	}
	public void setCustNmChk(String custNmChk) {
		this.custNmChk = custNmChk;
	}
	public String getMbrStatCdChk() {
		return mbrStatCdChk;
	}
	public void setMbrStatCdChk(String mbrStatCdChk) {
		this.mbrStatCdChk = mbrStatCdChk;
	}
	public String getMbrStatCdNmChk() {
		return mbrStatCdNmChk;
	}
	public void setMbrStatCdNmChk(String mbrStatCdNmChk) {
		this.mbrStatCdNmChk = mbrStatCdNmChk;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}
	public String getApprovalNum() {
		return approvalNum;
	}
	public void setApprovalNum(String approvalNum) {
		this.approvalNum = approvalNum;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getRequestDt() {
		return requestDt;
	}
	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}
	public String getRidMbrUpload() {
		return ridMbrUpload;
	}
	public void setRidMbrUpload(String ridMbrUpload) {
		this.ridMbrUpload = ridMbrUpload;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRidCam() {
		return ridCam;
	}
	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	
	
	
	
}
