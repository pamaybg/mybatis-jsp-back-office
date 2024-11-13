package com.icignal.systemmanagement.job.dto.request;

import java.util.Date;

public class SystemTrgrMakingReqDto {

	private String trgrName;
	private String cronExpr;
	private String description;
	private Date triggerStartTime;
	private Date triggerEndTime;

	public String getTrgrName() {
		return trgrName;
	}
	public void setTrgrName(String trgrName) {
		this.trgrName = trgrName;
	}
	public String getCronExpr() {
		return cronExpr;
	}
	public void setCronExpr(String cronExpr) {
		this.cronExpr = cronExpr;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getTriggerStartTime() {
		return triggerStartTime;
	}
	public void setTriggerStartTime(Date triggerStartTime) {
		this.triggerStartTime = triggerStartTime;
	}
	public Date getTriggerEndTime() {
		return triggerEndTime;
	}
	public void setTriggerEndTime(Date triggerEndTime) {
		this.triggerEndTime = triggerEndTime;
	}

}
