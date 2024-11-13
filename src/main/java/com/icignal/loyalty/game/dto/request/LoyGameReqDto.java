package com.icignal.loyalty.game.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGameReqDto extends CommonDataAuthReqDto {

	private String rid;

	private String gameNo;
	private String gameNm;
	private String gameStartDate;
	private String gameEndDate;
	private String descText;
	private String budgtAmt;
	private String tcktRunCnt;

	private String statCd;
	private String gameTypeCd;
	private String joinTypeCd;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getGameNo() {
		return gameNo;
	}

	public void setGameNo(String gameNo) {
		this.gameNo = gameNo;
	}

	public String getGameNm() {
		return gameNm;
	}

	public void setGameNm(String gameNm) {
		this.gameNm = gameNm;
	}

	public String getGameStartDate() {
		return gameStartDate;
	}

	public void setGameStartDate(String gameStartDate) {
		this.gameStartDate = gameStartDate;
	}

	public String getGameEndDate() {
		return gameEndDate;
	}

	public void setGameEndDate(String gameEndDate) {
		this.gameEndDate = gameEndDate;
	}

	public String getDescText() {
		return descText;
	}

	public void setDescText(String descText) {
		this.descText = descText;
	}

	public String getBudgtAmt() {
		return budgtAmt;
	}

	public void setBudgtAmt(String budgtAmt) {
		this.budgtAmt = budgtAmt;
	}

	public String getTcktRunCnt() {
		return tcktRunCnt;
	}

	public void setTcktRunCnt(String tcktRunCnt) {
		this.tcktRunCnt = tcktRunCnt;
	}

	public String getStatCd() {
		return statCd;
	}

	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

	public String getGameTypeCd() {
		return gameTypeCd;
	}

	public void setGameTypeCd(String gameTypeCd) {
		this.gameTypeCd = gameTypeCd;
	}

	public String getJoinTypeCd() {
		return joinTypeCd;
	}

	public void setJoinTypeCd(String joinTypeCd) {
		this.joinTypeCd = joinTypeCd;
	}
}
