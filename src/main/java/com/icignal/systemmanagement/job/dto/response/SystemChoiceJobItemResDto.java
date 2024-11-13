package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemChoiceJobItemResDto extends GridPagingItemResDto {

	private String rid;
	private String jobNm;
	private String jobGrp;
	private String pgmNm;

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
	public String getJobGrp() {
		return jobGrp;
	}
	public void setJobGrp(String jobGrp) {
		this.jobGrp = jobGrp;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

}
