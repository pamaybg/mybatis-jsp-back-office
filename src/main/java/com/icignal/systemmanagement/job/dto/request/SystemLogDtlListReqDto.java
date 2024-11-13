package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemLogDtlListReqDto extends MKTGridPagingReqDto {

	private String ridJobLog;

	private String ridJobMst;
	private String schema;

	public String getRidJobLog() {
		return ridJobLog;
	}
	public void setRidJobLog(String ridJobLog) {
		this.ridJobLog = ridJobLog;
	}
	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getSchema() {
		return schema;
	}
	public void setSchema(String schema) {
		this.schema = schema;
	}

}
