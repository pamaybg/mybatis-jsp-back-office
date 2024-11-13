package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferCouponPoolReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridSupplyChnl;
	private String ridOfrgrpSel;
	private String ridStmp;
	
	// 코드
	private String ridOfr;
	private String ridCpnM;
	private String ridMbr;
	private String issueTypeCd;
	private String cpnNo;
	private String cpnStateCd;
	private String mbrNo;
	
	//getter, setter
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidSupplyChnl() {
		return ridSupplyChnl;
	}
	public void setRidSupplyChnl(String ridSupplyChnl) {
		this.ridSupplyChnl = ridSupplyChnl;
	}
	public String getRidOfrgrpSel() {
		return ridOfrgrpSel;
	}
	public void setRidOfrgrpSel(String ridOfrgrpSel) {
		this.ridOfrgrpSel = ridOfrgrpSel;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidCpnM() {
		return ridCpnM;
	}
	public void setRidCpnM(String ridCpnM) {
		this.ridCpnM = ridCpnM;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getIssueTypeCd() {
		return issueTypeCd;
	}
	public void setIssueTypeCd(String issueTypeCd) {
		this.issueTypeCd = issueTypeCd;
	}
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getCpnStateCd() {
		return cpnStateCd;
	}
	public void setCpnStateCd(String cpnStateCd) {
		this.cpnStateCd = cpnStateCd;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
}
