package com.icignal.loyalty.game.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyGameTicketReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String mbrNo;
	private String earnDt;
	private String ofrQty;
	private String useDt;
	private String cancelEarnDt;
	private String cancelEarnRsn;
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

	public String getEarnDt() {
		return earnDt;
	}

	public void setEarnDt(String earnDt) {
		this.earnDt = earnDt;
	}

	public String getOfrQty() {
		return ofrQty;
	}

	public void setOfrQty(String ofrQty) {
		this.ofrQty = ofrQty;
	}

	public String getUseDt() {
		return useDt;
	}

	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}

	public String getCancelEarnDt() {
		return cancelEarnDt;
	}

	public void setCancelEarnDt(String cancelEarnDt) {
		this.cancelEarnDt = cancelEarnDt;
	}

	public String getCancelEarnRsn() {
		return cancelEarnRsn;
	}

	public void setCancelEarnRsn(String cancelEarnRsn) {
		this.cancelEarnRsn = cancelEarnRsn;
	}
}
