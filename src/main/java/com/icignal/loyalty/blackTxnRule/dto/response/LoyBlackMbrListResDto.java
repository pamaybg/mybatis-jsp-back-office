/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrListResDto.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 5. 오후 5:25:27
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 5.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyBlackMbrListResDto
 * 2. 파일명	: LoyBlackMbrListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
@PersonalData
public class LoyBlackMbrListResDto extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String overAcrlCnt;
	private String acrlCanlCnt;
	private String claimCnt;
	private String statCd;
	@MarkName(groupCode="LOY_BL_MEM_STAT_CD", codeField="statCd")
	private String statCdNm;
	@Decrypted(masked = "tel")
	private String hhp;
	private String contents;
	private String validStartDate;
	private String validEndDate;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	private String confirmDate;
	private String cancelDate;
	private String createDate;
	private String totCnt;
	
	
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}
	public String getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(String cancelDate) {
		this.cancelDate = cancelDate;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getOverAcrlCnt() {
		return overAcrlCnt;
	}
	public void setOverAcrlCnt(String overAcrlCnt) {
		this.overAcrlCnt = overAcrlCnt;
	}
	public String getAcrlCanlCnt() {
		return acrlCanlCnt;
	}
	public void setAcrlCanlCnt(String acrlCanlCnt) {
		this.acrlCanlCnt = acrlCanlCnt;
	}
	public String getClaimCnt() {
		return claimCnt;
	}
	public void setClaimCnt(String claimCnt) {
		this.claimCnt = claimCnt;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
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
	
	
}
