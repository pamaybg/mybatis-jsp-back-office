package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferGroupReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 코드
	private String ofrgrpType;
	private String statCd;
	
	// 릴레이션
	private String ridOfr;

	// 기본 필드
	private String ofrgrpNo;
	private String ofrgrpNm;
	private String descText;
	private String totAmt;

	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfrgrpType() {
		return ofrgrpType;
	}
	public void setOfrgrpType(String ofrgrpType) {
		this.ofrgrpType = ofrgrpType;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getOfrgrpNo() {
		return ofrgrpNo;
	}
	public void setOfrgrpNo(String ofrgrpNo) {
		this.ofrgrpNo = ofrgrpNo;
	}
	public String getOfrgrpNm() {
		return ofrgrpNm;
	}
	public void setOfrgrpNm(String ofrgrpNm) {
		this.ofrgrpNm = ofrgrpNm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}

}
