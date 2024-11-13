package com.icignal.loyalty.game.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGameJoinReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String mbrNo;
	private String joinDate;
	private String ridOfrWin;
	private String ofrWinQty;
	private String ofrWinAvailDay;
	private String ofrWinEarnDate;
	private String ridGame;

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

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getRidOfrWin() {
		return ridOfrWin;
	}

	public void setRidOfrWin(String ridOfrWin) {
		this.ridOfrWin = ridOfrWin;
	}

	public String getOfrWinQty() {
		return ofrWinQty;
	}

	public void setOfrWinQty(String ofrWinQty) {
		this.ofrWinQty = ofrWinQty;
	}

	public String getOfrWinAvailDay() {
		return ofrWinAvailDay;
	}

	public void setOfrWinAvailDay(String ofrWinAvailDay) {
		this.ofrWinAvailDay = ofrWinAvailDay;
	}

	public String getOfrWinEarnDate() {
		return ofrWinEarnDate;
	}

	public void setOfrWinEarnDate(String ofrWinEarnDate) {
		this.ofrWinEarnDate = ofrWinEarnDate;
	}
}
