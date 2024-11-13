package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class ChildOfferReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridOfr;
	private String ridOfrgrp;

	// 기본 필드
	private String minAmt;
	private String maxAmt;
	private String clickAmt;
	private String reqYn;
	
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
	public String getRidOfrgrp() {
		return ridOfrgrp;
	}
	public void setRidOfrgrp(String ridOfrgrp) {
		this.ridOfrgrp = ridOfrgrp;
	}
	public String getMinAmt() {
		return minAmt;
	}
	public void setMinAmt(String minAmt) {
		this.minAmt = minAmt;
	}
	public String getMaxAmt() {
		return maxAmt;
	}
	public void setMaxAmt(String maxAmt) {
		this.maxAmt = maxAmt;
	}
	public String getClickAmt() {
		return clickAmt;
	}
	public void setClickAmt(String clickAmt) {
		this.clickAmt = clickAmt;
	}
	public String getReqYn() {
		return reqYn;
	}
	public void setReqYn(String reqYn) {
		this.reqYn = reqYn;
	}

}
