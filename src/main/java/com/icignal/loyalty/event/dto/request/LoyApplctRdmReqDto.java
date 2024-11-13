package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyApplctRdmReqDto extends CommonDataAuthReqDto{
	private String eventRid;
	private String winCnt;
	private String ridMbr;
	private String applctRid;
	private String RST;
	private String RST_CD;
	private String RST_MSG;
	
	public String getRST() {
		return RST;
	}
	public void setRST(String rST) {
		RST = rST;
	}
	public String getRST_MSG() {
		return RST_MSG;
	}
	public void setRST_MSG(String rST_MSG) {
		RST_MSG = rST_MSG;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getApplctRid() {
		return applctRid;
	}
	public void setApplctRid(String applctRid) {
		this.applctRid = applctRid;
	}
	public String getWinCnt() {
		return winCnt;
	}

	public void setWinCnt(String winCnt) {
		this.winCnt = winCnt;
	}

	public String getEventRid() {
		return eventRid;
	}

	public void setEventRid(String eventRid) {
		this.eventRid = eventRid;
	}
	public String getRST_CD() {
		return RST_CD;
	}
	public void setRST_CD(String rST_CD) {
		RST_CD = rST_CD;
	}
}
