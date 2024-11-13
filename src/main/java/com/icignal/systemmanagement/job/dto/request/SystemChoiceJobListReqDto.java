package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemChoiceJobListReqDto extends MKTGridPagingReqDto {

	private String ridJobMst;

	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}

}
