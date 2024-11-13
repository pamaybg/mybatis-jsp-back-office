package com.icignal.loyalty.game.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyGameResDto extends GridPagingItemResDto {

	private String rid;
	private String createDate;
	private String createBy;
	private String gameNo;
	private String gameNm;
	private String gameStartDate;
	private String gameEndDate;
	private String descText;
	private String budgtAmt;
	private String tcktRunCnt;

	private String statCd;
	@MarkName(groupCode = "LOY_GAME_STAT_TYPE", codeField = "statCd")
	private String statCdNm;
	private String gameTypeCd;
	@MarkName(groupCode = "LOY_GAME_TYPE", codeField = "gameTypeCd")
	private String gameTypeCdNm;
	private String joinTypeCd;
	@MarkName(groupCode = "LOY_GAME_JOIN_TYPE", codeField = "joinTypeCd")
	private String joinTypeCdNm;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
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

	public String getStatCdNm() {
		return statCdNm;
	}

	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}

	public String getGameTypeCd() {
		return gameTypeCd;
	}

	public void setGameTypeCd(String gameTypeCd) {
		this.gameTypeCd = gameTypeCd;
	}

	public String getGameTypeCdNm() {
		return gameTypeCdNm;
	}

	public void setGameTypeCdNm(String gameTypeCdNm) {
		this.gameTypeCdNm = gameTypeCdNm;
	}

	public String getJoinTypeCd() {
		return joinTypeCd;
	}

	public void setJoinTypeCd(String joinTypeCd) {
		this.joinTypeCd = joinTypeCd;
	}

	public String getJoinTypeCdNm() {
		return joinTypeCdNm;
	}

	public void setJoinTypeCdNm(String joinTypeCdNm) {
		this.joinTypeCdNm = joinTypeCdNm;
	}
}
