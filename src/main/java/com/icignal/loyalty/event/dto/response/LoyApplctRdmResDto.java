package com.icignal.loyalty.event.dto.response;

public class LoyApplctRdmResDto {
	private String voteCnt;
	private String voteMbrCnt;
	private String applctRid;
	private String ridMbr;
	
	public String getApplctRid() {
		return applctRid;
	}
	public void setApplctRid(String applctRid) {
		this.applctRid = applctRid;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getVoteCnt() {
		return voteCnt;
	}
	public void setVoteCnt(String voteCnt) {
		this.voteCnt = voteCnt;
	}
	public String getVoteMbrCnt() {
		return voteMbrCnt;
	}
	public void setVoteMbrCnt(String voteMbrCnt) {
		this.voteMbrCnt = voteMbrCnt;
	}
}
