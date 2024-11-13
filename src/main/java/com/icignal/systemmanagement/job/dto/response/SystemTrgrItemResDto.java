package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemTrgrItemResDto extends GridPagingItemResDto {

	private String rid;
	private String trgrNm;
	private String trgrStatCd;
	private Date startDttm;
	private Date endDttm;
	private Date preExecDttm;
	private Date nextExecDttm;
	private String cronExpr;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTrgrNm() {
		return trgrNm;
	}
	public void setTrgrNm(String trgrNm) {
		this.trgrNm = trgrNm;
	}
	public String getTrgrStatCd() {
		return trgrStatCd;
	}
	public void setTrgrStatCd(String trgrStatCd) {
		this.trgrStatCd = trgrStatCd;
	}
	public Date getStartDttm() {
		return startDttm;
	}
	public void setStartDttm(Date startDttm) {
		this.startDttm = startDttm;
	}
	public Date getEndDttm() {
		return endDttm;
	}
	public void setEndDttm(Date endDttm) {
		this.endDttm = endDttm;
	}
	public Date getPreExecDttm() {
		return preExecDttm;
	}
	public void setPreExecDttm(Date preExecDttm) {
		this.preExecDttm = preExecDttm;
	}
	public Date getNextExecDttm() {
		return nextExecDttm;
	}
	public void setNextExecDttm(Date nextExecDttm) {
		this.nextExecDttm = nextExecDttm;
	}
	public String getCronExpr() {
		return cronExpr;
	}
	public void setCronExpr(String cronExpr) {
		this.cronExpr = cronExpr;
	}

}
