package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


public class SystemAlrtListReqDto extends MKTGridPagingReqDto {

	private String rid;
	private String ridJobMst;
	private String alrtNm;
	private String alrtCondCd;
	private String condVal;
	private int execTime;
	private String trsChnlCd;
	private String activeYn;
	private String rcvr;
	private String sbjt;
	private String msgContent;
	private List<String> rids;

	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getAlrtNm() {
		return alrtNm;
	}
	public void setAlrtNm(String alrtNm) {
		this.alrtNm = alrtNm;
	}
	public String getAlrtCondCd() {
		return alrtCondCd;
	}
	public void setAlrtCondCd(String alrtCondCd) {
		this.alrtCondCd = alrtCondCd;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public int getExecTime() {
		return execTime;
	}
	public void setExecTime(int execTime) {
		this.execTime = execTime;
	}
	public String getTrsChnlCd() {
		return trsChnlCd;
	}
	public void setTrsChnlCd(String trsChnlCd) {
		this.trsChnlCd = trsChnlCd;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public String getRcvr() {
		return rcvr;
	}
	public void setRcvr(String rcvr) {
		this.rcvr = rcvr;
	}
	public String getSbjt() {
		return sbjt;
	}
	public void setSbjt(String sbjt) {
		this.sbjt = sbjt;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	
}
