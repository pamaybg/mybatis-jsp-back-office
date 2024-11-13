package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@SuppressWarnings("serial")
@PersonalData
public class LoyTransPointListResDto extends GridPagingItemResDto {
	private String ridMbr         ;
	private String mbrStatCd      ;
	private String custNm         ;
	@Decrypted(masked = "te;")
	private String hhpNo          ;
	@Decrypted(masked = "email")
	private String emailAddr      ;
	private String birthDt        ;
	private String mbrNo          ;
	private String pntUse         ;
	private String pntPreUse      ;
	private String cdFlag;
	
	
	public String getCdFlag() {
		return cdFlag;
	}
	public void setCdFlag(String cdFlag) {
		this.cdFlag = cdFlag;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getPntUse() {
		return pntUse;
	}
	public void setPntUse(String pntUse) {
		this.pntUse = pntUse;
	}
	public String getPntPreUse() {
		return pntPreUse;
	}
	public void setPntPreUse(String pntPreUse) {
		this.pntPreUse = pntPreUse;
	}

	
}
