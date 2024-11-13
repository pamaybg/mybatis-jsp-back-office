package com.icignal.loyalty.game.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGameSubReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String rlMissionText;
	private String ofr1Qty;
	private String ofr1AvailDay;
	private String ofr2Qty;
	private String ofr2AvailDay;
	private String runItemCnt;
	private String combiMaxAmt;
	private String lostRate;
	private String winRate1slot;
	private String winRateFirst;
	private String winRateSpecial;
	private String ridOfr1;
	private String ridOfr2;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRlMissionText() {
		return rlMissionText;
	}

	public void setRlMissionText(String rlMissionText) {
		this.rlMissionText = rlMissionText;
	}

	public String getOfr1Qty() {
		return ofr1Qty;
	}

	public void setOfr1Qty(String ofr1Qty) {
		this.ofr1Qty = ofr1Qty;
	}

	public String getOfr1AvailDay() {
		return ofr1AvailDay;
	}

	public void setOfr1AvailDay(String ofr1AvailDay) {
		this.ofr1AvailDay = ofr1AvailDay;
	}

	public String getOfr2Qty() {
		return ofr2Qty;
	}

	public void setOfr2Qty(String ofr2Qty) {
		this.ofr2Qty = ofr2Qty;
	}

	public String getOfr2AvailDay() {
		return ofr2AvailDay;
	}

	public void setOfr2AvailDay(String ofr2AvailDay) {
		this.ofr2AvailDay = ofr2AvailDay;
	}

	public String getRunItemCnt() {
		return runItemCnt;
	}

	public void setRunItemCnt(String runItemCnt) {
		this.runItemCnt = runItemCnt;
	}

	public String getCombiMaxAmt() {
		return combiMaxAmt;
	}

	public void setCombiMaxAmt(String combiMaxAmt) {
		this.combiMaxAmt = combiMaxAmt;
	}

	public String getLostRate() {
		return lostRate;
	}

	public void setLostRate(String lostRate) {
		this.lostRate = lostRate;
	}

	public String getWinRate1slot() {
		return winRate1slot;
	}

	public void setWinRate1slot(String winRate1slot) {
		this.winRate1slot = winRate1slot;
	}

	public String getWinRateFirst() {
		return winRateFirst;
	}

	public void setWinRateFirst(String winRateFirst) {
		this.winRateFirst = winRateFirst;
	}

	public String getWinRateSpecial() {
		return winRateSpecial;
	}

	public void setWinRateSpecial(String winRateSpecial) {
		this.winRateSpecial = winRateSpecial;
	}

	public String getRidOfr1() {
		return ridOfr1;
	}

	public void setRidOfr1(String ridOfr1) {
		this.ridOfr1 = ridOfr1;
	}

	public String getRidOfr2() {
		return ridOfr2;
	}

	public void setRidOfr2(String ridOfr2) {
		this.ridOfr2 = ridOfr2;
	}

}
