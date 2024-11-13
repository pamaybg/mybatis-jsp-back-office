package com.icignal.marketing.batch.dto.request;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class MktBatchJobReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String jobNm;
	private String jobDesc;
	private String useYn;
	private String execCycle;
	private String lastExecStartDt;
	private String lastExecEndDt;
	
	private String batchExeLogHadId;
	

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

	public String getBatchExeLogHadId() {
		return batchExeLogHadId;
	}

	public void setBatchExeLogHadId(String batchExeLogHadId) {
		this.batchExeLogHadId = batchExeLogHadId;
	}

}
