package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemLogListReqDto extends MKTGridPagingReqDto {

	private String jobCd;
	private String startDate;
	private String endDate;

	private String ridJobMst;
	private String schema;
	private String logTblNm;

	
	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getJobCd() {
		return jobCd;
	}
	public void setJobCd(String jobCd) {
		this.jobCd = jobCd;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getSchema() {
		return schema;
	}
	public void setSchema(String schema) {
		this.schema = schema;
	}
	public String getLogTblNm() {
		return logTblNm;
	}
	public void setLogTblNm(String logTblNm) {
		this.logTblNm = logTblNm;
	}
}
