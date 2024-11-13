package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemTargetJobItemResDto extends GridPagingItemResDto {

	private String rid;
	private String jobNm;
	private String activeYn;
	private Integer execDelayTime;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getJobNm() {
		return jobNm;
	}
	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
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

}
