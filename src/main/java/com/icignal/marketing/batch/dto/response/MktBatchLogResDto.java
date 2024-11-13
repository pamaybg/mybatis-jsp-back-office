package com.icignal.marketing.batch.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;





public class MktBatchLogResDto extends GridPagingItemResDto {
	
	private String batchExeLogHadId;
	private String jobNm;
	private String batchWrkjobNm;
	private String batchNm;
	private String batchModuleNm;
	private String startDt;
	private String endDt;
	private String batchStatus;
	private String batchStatusDtl;
	private String errCd;
	private String errSbst;

	public String getJobNm() {
		return jobNm;
	}

	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}

	public String getBatchWrkjobNm() {
		return batchWrkjobNm;
	}

	public void setBatchWrkjobNm(String batchWrkjobNm) {
		this.batchWrkjobNm = batchWrkjobNm;
	}

	public String getBatchNm() {
		return batchNm;
	}

	public void setBatchNm(String batchNm) {
		this.batchNm = batchNm;
	}

	public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getBatchStatus() {
		return batchStatus;
	}

	public void setBatchStatus(String batchStatus) {
		this.batchStatus = batchStatus;
	}

	public String getBatchStatusDtl() {
		return batchStatusDtl;
	}

	public void setBatchStatusDtl(String batchStatusDtl) {
		this.batchStatusDtl = batchStatusDtl;
	}

	public String getErrCd() {
		return errCd;
	}

	public void setErrCd(String errCd) {
		this.errCd = errCd;
	}

	public String getErrSbst() {
		return errSbst;
	}

	public void setErrSbst(String errSbst) {
		this.errSbst = errSbst;
	}

	public String getBatchModuleNm() {
		return batchModuleNm;
	}

	public void setBatchModuleNm(String batchModuleNm) {
		this.batchModuleNm = batchModuleNm;
	}

	public String getBatchExeLogHadId() {
		return batchExeLogHadId;
	}

	public void setBatchExeLogHadId(String batchExeLogHadId) {
		this.batchExeLogHadId = batchExeLogHadId;
	}
	

	
}
