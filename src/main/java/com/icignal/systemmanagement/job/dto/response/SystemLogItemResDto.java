package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemLogItemResDto extends GridPagingItemResDto {

	private String rid;
	private Date frDttm;
	private Date endDttm;
	private String spentTime;
	private String statCd;
	private String execParam;
	private String reqRsltMsg;
	private String resRsltMsg;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
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
	public String getReqRsltMsg() {
		return reqRsltMsg;
	}
	public void setReqRsltMsg(String reqRsltMsg) {
		this.reqRsltMsg = reqRsltMsg;
	}
	public String getResRsltMsg() {
		return resRsltMsg;
	}
	public void setResRsltMsg(String resRsltMsg) {
		this.resRsltMsg = resRsltMsg;
	}

}
