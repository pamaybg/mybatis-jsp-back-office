package com.icignal.loyalty.membership.dto.request;

public class LoyNewCustAddTermReqDto {
	
	private String agreTypeCd;
	private String agreYn;
	private String regDt;
	private String termsVerNo;
	
	public String getAgreTypeCd() {
		return agreTypeCd;
	}
	public void setAgreTypeCd(String agreTypeCd) {
		this.agreTypeCd = agreTypeCd;
	}
	public String getAgreYn() {
		return agreYn;
	}
	public void setAgreYn(String agreYn) {
		this.agreYn = agreYn;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getTermsVerNo() {
		return termsVerNo;
	}
	public void setTermsVerNo(String termsVerNo) {
		this.termsVerNo = termsVerNo;
	}
}
