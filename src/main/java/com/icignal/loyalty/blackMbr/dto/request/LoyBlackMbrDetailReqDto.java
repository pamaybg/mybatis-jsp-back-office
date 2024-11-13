/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.blackMbr.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 10. 오후 3:42:28
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackMbr.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyBlackMbrDetailReqDto
 * 2. 파일명	: LoyBlackMbrDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.blackMbr.dto.request
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
public class LoyBlackMbrDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String blackTypeCd;
	@Encrypted
	private String custNm;
	private String birthdt;
	@Encrypted
	private String hhp;
	@Encrypted
	private String email;
	private String statCd;
	private String sbscPlcyCd;
	private String blComment;
	private String pgmRid;
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
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
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
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	
	

}
