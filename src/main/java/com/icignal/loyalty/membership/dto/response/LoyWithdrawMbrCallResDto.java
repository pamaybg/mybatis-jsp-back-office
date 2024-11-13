package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyWithdrawMbrCallResDto  extends StatusResDto{

	private String pRst;
	private String pRstCd;
	private String pRstMsg;
	
	public String getpRst() {
		return pRst;
	}
	public void setpRst(String pRst) {
		this.pRst = pRst;
	}
	public String getpRstCd() {
		return pRstCd;
	}
	public void setpRstCd(String pRstCd) {
		this.pRstCd = pRstCd;
	}
	public String getpRstMsg() {
		return pRstMsg;
	}
	public void setpRstMsg(String pRstMsg) {
		this.pRstMsg = pRstMsg;
	}
	

}
