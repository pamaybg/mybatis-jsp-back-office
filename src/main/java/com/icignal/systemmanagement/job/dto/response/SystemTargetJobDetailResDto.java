package com.icignal.systemmanagement.job.dto.response;

public class SystemTargetJobDetailResDto {

	private String rid;
	private String targetJobNm;
	private String ridExecJob;
	private String activeYn;
	private Integer execDelayTime;
	private String execCycleDesc;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTargetJobNm() {
		return targetJobNm;
	}
	public void setTargetJobNm(String targetJobNm) {
		this.targetJobNm = targetJobNm;
	}
	public String getRidExecJob() {
		return ridExecJob;
	}
	public void setRidExecJob(String ridExecJob) {
		this.ridExecJob = ridExecJob;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public Integer getExecDelayTime() {
		return execDelayTime;
	}
	public void setExecDelayTime(Integer execDelayTime) {
		this.execDelayTime = execDelayTime;
	}
	public String getExecCycleDesc() {
		return execCycleDesc;
	}
	public void setExecCycleDesc(String execCycleDesc) {
		this.execCycleDesc = execCycleDesc;
	}

}
