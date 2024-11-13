/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierApprovalReqDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 29. 오후 3:13:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 29.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierApprovalReqDto
 * 2. 파일명	: LoyTierApprovalReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierApprovalReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierGrpRid;
	private String mbrRid;
	private String custNm;
	private String tierRid;
	private String modifyTierNm;
	private String tierNm;
	private String approvalReqNm;
	private String approvalNm;
	private String empId;
	private String reqEmpId;
	private String tierMnlReasonDesc;
	private String upKeepMm;
	private String mbrTierCol;
	private String tierGrpNm;
	private String prevTierRid;
	private String prevTierSeqNo;
	private String elecAprvNo;
	private String reqEmpDiv;
	private String reqEmpDivId;
	private String aprvoRid;
	private String modifyOrgID;
	private String tierHistRid;
	private String tierReason;
	private String tierRstCd;
	private String tierMnlReasonCd;
	
	
	public String getTierMnlReasonCd() {
		return tierMnlReasonCd;
	}
	public void setTierMnlReasonCd(String tierMnlReasonCd) {
		this.tierMnlReasonCd = tierMnlReasonCd;
	}
	public String getTierRstCd() {
		return tierRstCd;
	}
	public void setTierRstCd(String tierRstCd) {
		this.tierRstCd = tierRstCd;
	}
	public String getTierReason() {
		return tierReason;
	}
	public void setTierReason(String tierReason) {
		this.tierReason = tierReason;
	}
	public String getTierHistRid() {
		return tierHistRid;
	}
	public void setTierHistRid(String tierHistRid) {
		this.tierHistRid = tierHistRid;
	}
	public String getModifyOrgID() {
		return modifyOrgID;
	}
	public void setModifyOrgID(String modifyOrgID) {
		this.modifyOrgID = modifyOrgID;
	}
	public String getAprvoRid() {
		return aprvoRid;
	}
	public void setAprvoRid(String aprvoRid) {
		this.aprvoRid = aprvoRid;
	}
	public String getReqEmpDivId() {
		return reqEmpDivId;
	}
	public void setReqEmpDivId(String reqEmpDivId) {
		this.reqEmpDivId = reqEmpDivId;
	}
	public String getReqEmpDiv() {
		return reqEmpDiv;
	}
	public void setReqEmpDiv(String reqEmpDiv) {
		this.reqEmpDiv = reqEmpDiv;
	}
	public String getElecAprvNo() {
		return elecAprvNo;
	}
	public void setElecAprvNo(String elecAprvNo) {
		this.elecAprvNo = elecAprvNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierGrpRid() {
		return tierGrpRid;
	}
	public void setTierGrpRid(String tierGrpRid) {
		this.tierGrpRid = tierGrpRid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getModifyTierNm() {
		return modifyTierNm;
	}
	public void setModifyTierNm(String modifyTierNm) {
		this.modifyTierNm = modifyTierNm;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getApprovalReqNm() {
		return approvalReqNm;
	}
	public void setApprovalReqNm(String approvalReqNm) {
		this.approvalReqNm = approvalReqNm;
	}
	public String getApprovalNm() {
		return approvalNm;
	}
	public void setApprovalNm(String approvalNm) {
		this.approvalNm = approvalNm;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getReqEmpId() {
		return reqEmpId;
	}
	public void setReqEmpId(String reqEmpId) {
		this.reqEmpId = reqEmpId;
	}
	public String getTierMnlReasonDesc() {
		return tierMnlReasonDesc;
	}
	public void setTierMnlReasonDesc(String tierMnlReasonDesc) {
		this.tierMnlReasonDesc = tierMnlReasonDesc;
	}
	public String getUpKeepMm() {
		return upKeepMm;
	}
	public void setUpKeepMm(String upKeepMm) {
		this.upKeepMm = upKeepMm;
	}
	public String getMbrTierCol() {
		return mbrTierCol;
	}
	public void setMbrTierCol(String mbrTierCol) {
		this.mbrTierCol = mbrTierCol;
	}
	public String getTierGrpNm() {
		return tierGrpNm;
	}
	public void setTierGrpNm(String tierGrpNm) {
		this.tierGrpNm = tierGrpNm;
	}
	public String getPrevTierRid() {
		return prevTierRid;
	}
	public void setPrevTierRid(String prevTierRid) {
		this.prevTierRid = prevTierRid;
	}
	public String getPrevTierSeqNo() {
		return prevTierSeqNo;
	}
	public void setPrevTierSeqNo(String prevTierSeqNo) {
		this.prevTierSeqNo = prevTierSeqNo;
	}
	
	
}
