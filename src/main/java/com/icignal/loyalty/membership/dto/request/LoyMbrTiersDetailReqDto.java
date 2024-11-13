/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTiersDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 28. 오후 7:42:15
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 28.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyMbrTiersDetailReqDto
 * 2. 파일명	: LoyMbrTiersDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyMbrTiersDetailReqDto extends CommonDataAuthReqDto{
	private String tierGrpRid;
	private String mbrRid;
	private String tierRid;
	private String modifyTierNm;
	private String modifyTierRid;
	private String tierNm;
	private String approvalReqNm;
	private String approvalNm;
	private String empId;
	private String tierMnlReasonDesc;
	private String rid;
	private String upKeepMm;
	private String mbrTierCol;
	private String tierRstCd;
	private String tierMnlReasonCd;
	private String approValId;
	private String pRst;
	private String pRstCd;
	private String pRstMsg;
	
	
	public String getpRst() {
		return pRst;
	}
	public void setpRst(String pRst) {
		this.pRst = pRst;
	}
	public String getpRstCd() {
		return pRstCd;
	}
	public void setpRstCd(String pRstCd) {
		this.pRstCd = pRstCd;
	}
	public String getpRstMsg() {
		return pRstMsg;
	}
	public void setpRstMsg(String pRstMsg) {
		this.pRstMsg = pRstMsg;
	}
	public String getApproValId() {
		return approValId;
	}
	public void setApproValId(String approValId) {
		this.approValId = approValId;
	}
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
	public String getMbrTierCol() {
		return mbrTierCol;
	}
	public void setMbrTierCol(String mbrTierCol) {
		this.mbrTierCol = mbrTierCol;
	}
	public String getUpKeepMm() {
		return upKeepMm;
	}
	public void setUpKeepMm(String upKeepMm) {
		this.upKeepMm = upKeepMm;
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
	public String getModifyTierRid() {
		return modifyTierRid;
	}
	public void setModifyTierRid(String modifyTierRid) {
		this.modifyTierRid = modifyTierRid;
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
	public String getTierMnlReasonDesc() {
		return tierMnlReasonDesc;
	}
	public void setTierMnlReasonDesc(String tierMnlReasonDesc) {
		this.tierMnlReasonDesc = tierMnlReasonDesc;
	}
	
	
}
