package com.icignal.loyalty.game.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGameRuleReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String ridGame;
	private String lineNo;
	private String lineNm;
	private String pieSizeRate;
	private String missionChar;
	private String ridLineOfr;
	private String lineOfrQty;
	private String lineOfrAvailDay;
	private String lineWinRate;
	private String budgtCloseYn;
	private String lineImgUrl;
	private String lineOfrYn;
	private String firstSlotYn;
	private String specialYn;
	private String diceSumQty;

	public String getRidGame() {
		return ridGame;
	}

	public void setRidGame(String ridGame) {
		this.ridGame = ridGame;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getLineNo() {
		return lineNo;
	}

	public void setLineNo(String lineNo) {
		this.lineNo = lineNo;
	}

	public String getLineNm() {
		return lineNm;
	}

	public void setLineNm(String lineNm) {
		this.lineNm = lineNm;
	}

	public String getPieSizeRate() {
		return pieSizeRate;
	}

	public void setPieSizeRate(String pieSizeRate) {
		this.pieSizeRate = pieSizeRate;
	}

	public String getMissionChar() {
		return missionChar;
	}

	public void setMissionChar(String missionChar) {
		this.missionChar = missionChar;
	}

	public String getRidLineOfr() {
		return ridLineOfr;
	}

	public void setRidLineOfr(String ridLineOfr) {
		this.ridLineOfr = ridLineOfr;
	}

	public String getLineOfrQty() {
		return lineOfrQty;
	}

	public void setLineOfrQty(String lineOfrQty) {
		this.lineOfrQty = lineOfrQty;
	}

	public String getLineOfrAvailDay() {
		return lineOfrAvailDay;
	}

	public void setLineOfrAvailDay(String lineOfrAvailDay) {
		this.lineOfrAvailDay = lineOfrAvailDay;
	}

	public String getLineWinRate() {
		return lineWinRate;
	}

	public void setLineWinRate(String lineWinRate) {
		this.lineWinRate = lineWinRate;
	}

	public String getBudgtCloseYn() {
		return budgtCloseYn;
	}

	public void setBudgtCloseYn(String budgtCloseYn) {
		this.budgtCloseYn = budgtCloseYn;
	}

	public String getLineImgUrl() {
		return lineImgUrl;
	}

	public void setLineImgUrl(String lineImgUrl) {
		this.lineImgUrl = lineImgUrl;
	}

	public String getLineOfrYn() {
		return lineOfrYn;
	}

	public void setLineOfrYn(String lineOfrYn) {
		this.lineOfrYn = lineOfrYn;
	}

	public String getFirstSlotYn() {
		return firstSlotYn;
	}

	public void setFirstSlotYn(String firstSlotYn) {
		this.firstSlotYn = firstSlotYn;
	}

	public String getSpecialYn() {
		return specialYn;
	}

	public void setSpecialYn(String specialYn) {
		this.specialYn = specialYn;
	}

	public String getDiceSumQty() {
		return diceSumQty;
	}

	public void setDiceSumQty(String diceSumQty) {
		this.diceSumQty = diceSumQty;
	}
}
