package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * 
* <pre>
* infavor.loyalty.common.dto.response
*  |_ LOYMbrMstListResponseDTO.java
* </pre>
* @작성일		: 2017. 1. 5. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
@PersonalData
public class LoyMbrMstListResDto extends GridPagingItemResDto{
	
	private String rid;
	private String ridPgm;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String ridTierCur;
	private String tierNm;
	private String mbrTypeCd;
	private String mbrTypeNm;
	private String mbrStatCd;
	private String mbrStatNm;
	@Decrypted(masked = "tel")
	private String hhpNo;
	@Decrypted(masked = "email")
	private String emailAddr;
	private String custTypeCd;
	private String identiTypeCd;
	private String identiVal;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
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
	public String getRidTierCur() {
		return ridTierCur;
	}
	public void setRidTierCur(String ridTierCur) {
		this.ridTierCur = ridTierCur;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeNm() {
		return mbrTypeNm;
	}
	public void setMbrTypeNm(String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatNm() {
		return mbrStatNm;
	}
	public void setMbrStatNm(String mbrStatNm) {
		this.mbrStatNm = mbrStatNm;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getIdentiTypeCd() {
		return identiTypeCd;
	}
	public void setIdentiTypeCd(String identiTypeCd) {
		this.identiTypeCd = identiTypeCd;
	}
	public String getIdentiVal() {
		return identiVal;
	}
	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
	}
	

}
