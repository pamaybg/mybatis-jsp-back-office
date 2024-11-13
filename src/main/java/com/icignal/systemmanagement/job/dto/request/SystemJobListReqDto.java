package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemJobListReqDto extends CommonDataAuthReqDto {

	private String jobNm;
	private String jobGrp;
	private String lstExecStat;
	private String jobDesc;
	private String jobKey;

	public String getJobNm() {
		return jobNm;
	}
	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}
	public String getJobGrp() {
		return jobGrp;
	}
	public void setJobGrp(String jobGrp) {
		this.jobGrp = jobGrp;
	}
	public String getLstExecStat() {
		return lstExecStat;
	}
	public void setLstExecStat(String lstExecStat) {
		this.lstExecStat = lstExecStat;
	}
	public String getJobDesc() {
		return jobDesc;
	}
	public void setJobDesc(String jobDesc) {
		this.jobDesc = jobDesc;
	}
	public String getJobKey() {
		return jobKey;
	}
	public void setJobKey(String jobKey) {
		this.jobKey = jobKey;
	}



}
