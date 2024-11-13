/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrListResDto.java
 * 2. Package	: com.icignal.loyalty.blackMbr.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 10. 오후 3:41:29
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackMbr.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyBlackMbrListResDto
 * 2. 파일명	: LoyBlackMbrListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackMbr.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@PersonalData
@CommCode
public class LoyBlackMbrListResDto extends GridPagingItemResDto{
	private String rid;
	private String blackTypeCd;
	@MarkName(groupCode="LOY_BLACK_REG_CD",codeField="blackTypeCd")
	private String blackTypeCdNm;
	@Decrypted(masked="custNm")
	private String custNm;
	private String birthdt;
	@Decrypted(masked="tel")
	private String hhp;
	@Decrypted(masked="email")
	private String email;
	private String statCd;
	@MarkName(groupCode="LOY_BLACK_REG_STAT_CD",codeField="statCd")
	private String statCdNm;
	private String sbscPlcyCd;
	@MarkName(groupCode="LOY_BLACK_PLCY_SBSC_CD",codeField="sbscPlcyCd")
	private String sbscPlcyCdNm;
	private String blComment;
	private String pgmRid;
	private String pgmNm;
	private String createDate;
	private String createBy;
	@Decrypted(masked="none")
	private String unMaskCustNm;
	@Decrypted(masked="none")
	private String unMaskHhp;
	@Decrypted(masked="none")
	private String unMaskEmail;
	
	
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
	public String getUnMaskEmail() {
		return unMaskEmail;
	}
	public void setUnMaskEmail(String unMaskEmail) {
		this.unMaskEmail = unMaskEmail;
	}
	public String getBlackTypeCdNm() {
		return blackTypeCdNm;
	}
	public void setBlackTypeCdNm(String blackTypeCdNm) {
		this.blackTypeCdNm = blackTypeCdNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getSbscPlcyCdNm() {
		return sbscPlcyCdNm;
	}
	public void setSbscPlcyCdNm(String sbscPlcyCdNm) {
		this.sbscPlcyCdNm = sbscPlcyCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBlackTypeCd() {
		return blackTypeCd;
	}
	public void setBlackTypeCd(String blackTypeCd) {
		this.blackTypeCd = blackTypeCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getBirthdt() {
		return birthdt;
	}
	public void setBirthdt(String birthdt) {
		this.birthdt = birthdt;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSbscPlcyCd() {
		return sbscPlcyCd;
	}
	public void setSbscPlcyCd(String sbscPlcyCd) {
		this.sbscPlcyCd = sbscPlcyCd;
	}
	public String getBlComment() {
		return blComment;
	}
	public void setBlComment(String blComment) {
		this.blComment = blComment;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	
	

}
