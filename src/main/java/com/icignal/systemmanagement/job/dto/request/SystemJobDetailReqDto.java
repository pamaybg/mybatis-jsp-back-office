package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

public class SystemJobDetailReqDto {

	private String rid;
	private String jobNm;
	private List<String> rids;

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
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}

}
