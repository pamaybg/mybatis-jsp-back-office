package com.icignal.systemmanagement.job.dto.response;

import java.util.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

public class SystemJobItemResDto extends GridPagingItemResDto {

    private String useYn;
    private String useYnNm;
	private String rid;
	private String jobNm;
	private String jobGrp;
	private String pgmNm;
	private Date lstExecDttm;
	private String lstExecStat;
	private String lstRsltMsg;
	private String modifyBy;
	private String jobCd;
	private String logTblNm;
	private String lastExecStartDt;
	private String jobDesc;
	private String createTime;
	private String startTime;
	private String endTime;
	private String status;
	private String exitCode;
	private String exitMessage;
	private String lastUpdated;
	private String resultCd;
	private String lastExecEndDt;
	private String execCycle;
	private String execCycleDesc;
	private String lastExecTime;
	private String jobInstanceId;
	

    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getUseYnNm() {
        return useYnNm;
    }
    public void setUseYnNm(String useYnNm) {
        this.useYnNm = useYnNm;
    }	
	public String getJobInstanceId() {
		return jobInstanceId;
	}
	public void setJobInstanceId(String jobInstanceId) {
		this.jobInstanceId = jobInstanceId;
	}
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
	public Date getLstExecDttm() {
		return lstExecDttm;
	}
	public void setLstExecDttm(Date lstExecDttm) {
		this.lstExecDttm = lstExecDttm;
	}
	public String getLstExecStat() {
		return lstExecStat;
	}
	public void setLstExecStat(String lstExecStat) {
		this.lstExecStat = lstExecStat;
	}
	public String getLstRsltMsg() {
		return lstRsltMsg;
	}
	public void setLstRsltMsg(String lstRsltMsg) {
		this.lstRsltMsg = lstRsltMsg;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getJobCd() {
		return jobCd;
	}
	public void setJobCd(String jobCd) {
		this.jobCd = jobCd;
	}
	public String getLogTblNm() {
		return logTblNm;
	}
	public void setLogTblNm(String logTblNm) {
		this.logTblNm = logTblNm;
	}
	public String getLastExecStartDt() {
		return lastExecStartDt;
	}
	public void setLastExecStartDt(String lastExecStartDt) {
		this.lastExecStartDt = lastExecStartDt;
	}
	public String getJobDesc() {
		return jobDesc;
	}
	public void setJobDesc(String jobDesc) {
		this.jobDesc = jobDesc;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getExitCode() {
		return exitCode;
	}
	public void setExitCode(String exitCode) {
		this.exitCode = exitCode;
	}
	public String getExitMessage() {
		return exitMessage;
	}
	public void setExitMessage(String exitMessage) {
		this.exitMessage = exitMessage;
	}
	public String getLastUpdated() {
		return lastUpdated;
	}
	public void setLastUpdated(String lastUpdated) {
		this.lastUpdated = lastUpdated;
	}
	public String getResultCd() {
		return resultCd;
	}
	public void setResultCd(String resultCd) {
		this.resultCd = resultCd;
	}
	public String getLastExecEndDt() {
		return lastExecEndDt;
	}
	public void setLastExecEndDt(String lastExecEndDt) {
		this.lastExecEndDt = lastExecEndDt;
	}
	public String getExecCycle() {
		return execCycle;
	}
	public void setExecCycle(String execCycle) {
		this.execCycle = execCycle;
	}
	public String getLastExecTime() {
		return lastExecTime;
	}
	public void setLastExecTime(String lastExecTime) {
		this.lastExecTime = lastExecTime;
	}
	public String getExecCycleDesc() {
		return execCycleDesc;
	}
	public void setExecCycleDesc(String execCycleDesc) {
		this.execCycleDesc = execCycleDesc;
	}



}

