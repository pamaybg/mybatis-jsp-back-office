package com.icignal.systemmanagement.job.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemAlrtDetailResDto {

	private String rid;
	private String alrtNm;
	private String activeYn;
	private String alrtCondCd;
	
	@MarkName(groupCode = "BAT_JOB_COND_VAL", codeField = "condValCdNm")
	private String condVal;
	
	private String condValCdNm;
	private Integer execTime;
	private String trsChnlCd;
	private String rcvr;
	private String sbjt;
	private String msgContent;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAlrtNm() {
		return alrtNm;
	}
	public void setAlrtNm(String alrtNm) {
		this.alrtNm = alrtNm;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
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
	public Integer getExecTime() {
		return execTime;
	}
	public void setExecTime(Integer execTime) {
		this.execTime = execTime;
	}
	public String getTrsChnlCd() {
		return trsChnlCd;
	}
	public void setTrsChnlCd(String trsChnlCd) {
		this.trsChnlCd = trsChnlCd;
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
	public String getCondValCdNm() {
		return condValCdNm;
	}
	public void setCondValCdNm(String condValCdNm) {
		this.condValCdNm = condValCdNm;
	}
	
}
