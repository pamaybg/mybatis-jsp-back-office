package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

public class SystemLogItemForExcelResDto {

	private Date frDttm;
	private Date endDttm;
	private String spentTime;
	private String statCd;
	private String execParam;
	private String rsltMsg;

	public Date getFrDttm() {
		return frDttm;
	}
	public void setFrDttm(Date frDttm) {
		this.frDttm = frDttm;
	}
	public Date getEndDttm() {
		return endDttm;
	}
	public void setEndDttm(Date endDttm) {
		this.endDttm = endDttm;
	}
	public String getSpentTime() {
		return spentTime;
	}
	public void setSpentTime(String spentTime) {
		this.spentTime = spentTime;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getExecParam() {
		return execParam;
	}
	public void setExecParam(String execParam) {
		this.execParam = execParam;
	}
	public String getRsltMsg() {
		return rsltMsg;
	}
	public void setRsltMsg(String rsltMsg) {
		this.rsltMsg = rsltMsg;
	}

}
