package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class KprTableResDto extends StatusResDto {
	
	
	private int totalTableCnt;
	private int successTableCnt;
	private int failureTableCnt;

	public int getTotalTableCnt() {
		return totalTableCnt;
	}

	public void setTotalTableCnt(int totalTableCnt) {
		this.totalTableCnt = totalTableCnt;
	}

	public int getSuccessTableCnt() {
		return successTableCnt;
	}

	public void setSuccessTableCnt(int successTableCnt) {
		this.successTableCnt = successTableCnt;
	}

	public int getFailureTableCnt() {
		return failureTableCnt;
	}

	public void setFailureTableCnt(int failureTableCnt) {
		this.failureTableCnt = failureTableCnt;
	}
}