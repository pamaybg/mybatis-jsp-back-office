package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

public class SystemTrgrDetailResDto {

	private String rid;
	private String trgrNm;
	private Date startDttm;
	private Date endDttm;
	private String cronExpr;

	//20170510 추가
	private String statCd;

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
	public String getCronExpr() {
		return cronExpr;
	}
	public void setCronExpr(String cronExpr) {
		this.cronExpr = cronExpr;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

}
