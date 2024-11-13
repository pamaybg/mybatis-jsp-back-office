package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferJoinPgmReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridSupplyChnl;
	private String ridOfrgrpSel;
	private String ridStmp;
	
	// 코드
	private String ridOfr;
	private String ridPgm;
	private String descText;
	
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
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
}
