package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemBatchLogListReqDto extends CommonDataAuthReqDto {
	private String trNo;
	private String apprStartDate;
	private String apprEndDate;
	
	public String getApprStartDate() {
		return apprStartDate;
	}

	public void setApprStartDate(String apprStartDate) {
		this.apprStartDate = apprStartDate;
	}

	public String getApprEndDate() {
		return apprEndDate;
	}

	public void setApprEndDate(String apprEndDate) {
		this.apprEndDate = apprEndDate;
	}

	public String getTrNo() {
		return trNo;
	}

	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}

}
