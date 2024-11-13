package com.icignal.common.base.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyMbrListPopResDto
 * 2. 파일명	: LoyMbrListPopResDto.java
 * 3. 패키지명	: com.icignal.loyalty.club.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		회원 조회 리스트 DTO
 * </PRE>
 */ 
@PersonalData
@CommCode
public class LoyMbrListPopResDto  extends GridPagingItemResDto{

	private String rid;
	private String mbrNo;
	@Decrypted(masked = "none")
	private String custNm;
	@Decrypted(masked = "none")
	private String hhp;
	@MarkName(groupCode = "LOY_MBR_TYPE_CD", codeField = "mbrTypeCd")
	private String mbrTypeCdNm;
	private String mbrTypeCd;
	@MarkName(groupCode = "LOY_MBR_STAT_CD", codeField = "mbrStatCd")
	private String mbrStatCdNm;
	private String mbrStatCd;
	private String sbscDate;
	private String ridSbscChnl;
	private String createDate;
	@Decrypted(masked = "none")
	private String email;
	private String custRid;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	@Decrypted(masked = "none")
	private String unMaskEmail;
	private String bizrNo;
	
	
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
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getRidSbscChnl() {
		return ridSbscChnl;
	}
	public void setRidSbscChnl(String ridSbscChnl) {
		this.ridSbscChnl = ridSbscChnl;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCustRid() {
		return custRid;
	}
	public void setCustRid(String custRid) {
		this.custRid = custRid;
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
	public String getUnMaskEmail() {
		return unMaskEmail;
	}
	public void setUnMaskEmail(String unMaskEmail) {
		this.unMaskEmail = unMaskEmail;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	
}
