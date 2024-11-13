package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferCpnPoolListCondReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	
	// 코드
	private String ridOfr;
	private String ridCpnM;
	private String issueTypeCd;
	private String cpnStateCd;
	
	//getter, setter
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getIssueTypeCd() {
		return issueTypeCd;
	}
	public void setIssueTypeCd(String issueTypeCd) {
		this.issueTypeCd = issueTypeCd;
	}
	public String getCpnStateCd() {
		return cpnStateCd;
	}
	public void setCpnStateCd(String cpnStateCd) {
		this.cpnStateCd = cpnStateCd;
	}
}
