package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemTargetJobListReqDto extends MKTGridPagingReqDto {

	private String ridSbsqnt;
	private String rid;
	private String ridExecJob;
	private int execDelayTime;
	private String activeYn;
	private List<String> rids;


	public String getRidSbsqnt() {
		return ridSbsqnt;
	}
	public void setRidSbsqnt(String ridSbsqnt) {
		this.ridSbsqnt = ridSbsqnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidExecJob() {
		return ridExecJob;
	}
	public void setRidExecJob(String ridExecJob) {
		this.ridExecJob = ridExecJob;
	}
	public int getExecDelayTime() {
		return execDelayTime;
	}
	public void setExecDelayTime(int execDelayTime) {
		this.execDelayTime = execDelayTime;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	
}
