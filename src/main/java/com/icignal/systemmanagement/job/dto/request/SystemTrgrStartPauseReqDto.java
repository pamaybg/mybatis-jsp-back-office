package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemTrgrStartPauseReqDto extends MKTGridPagingReqDto {

	private String rid;
	private String statCd;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}

}
