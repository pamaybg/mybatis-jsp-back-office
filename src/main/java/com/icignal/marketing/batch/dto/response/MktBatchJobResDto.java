package com.icignal.marketing.batch.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;





public class MktBatchJobResDto extends GridPagingItemResDto {
	
	private String rid;
	private String jobNm;
	private String jobDesc;
	private String useYn;
	private String execCycle;
	private String lastExecStartDt;
	private String lastExecEndDt;
	private String status;
	private String resultCd;

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

	public String getJobDesc() {
		return jobDesc;
	}

	public void setJobDesc(String jobDesc) {
		this.jobDesc = jobDesc;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getExecCycle() {
		return execCycle;
	}

	public void setExecCycle(String execCycle) {
		this.execCycle = execCycle;
	}

	public String getLastExecStartDt() {
		return lastExecStartDt;
	}

	public void setLastExecStartDt(String lastExecStartDt) {
		this.lastExecStartDt = lastExecStartDt;
	}

	public String getLastExecEndDt() {
		return lastExecEndDt;
	}

	public void setLastExecEndDt(String lastExecEndDt) {
		this.lastExecEndDt = lastExecEndDt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getResultCd() {
		return resultCd;
	}

	public void setResultCd(String resultCd) {
		this.resultCd = resultCd;
	}
	
	
}
