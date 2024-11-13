package com.icignal.systemmanagement.job.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemJobInsertReqDto extends MKTGridPagingReqDto {

	private String rid;
	private String jobNm;
	private String jobCd;
	private String jobGrpCd;
	private String jobDiviVal;
	private String connSrvrCd;
	private String pgmTypeCd;
	private String pgmNm;
	private String desctxt;
	private String logTblNm;
	private String jobDesc;
	private String useYn;
	private String execCycle;
	private String execCycleDesc;


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
	public String getJobCd() {
		return jobCd;
	}
	public void setJobCd(String jobCd) {
		this.jobCd = jobCd;
	}
	public String getJobGrpCd() {
		return jobGrpCd;
	}
	public void setJobGrpCd(String jobGrpCd) {
		this.jobGrpCd = jobGrpCd;
	}
	public String getJobDiviVal() {
		return jobDiviVal;
	}
	public void setJobDiviVal(String jobDiviVal) {
		this.jobDiviVal = jobDiviVal;
	}
	public String getConnSrvrCd() {
		return connSrvrCd;
	}
	public void setConnSrvrCd(String connSrvrCd) {
		this.connSrvrCd = connSrvrCd;
	}
	public String getPgmTypeCd() {
		return pgmTypeCd;
	}
	public void setPgmTypeCd(String pgmTypeCd) {
		this.pgmTypeCd = pgmTypeCd;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getDesctxt() {
		return desctxt;
	}
	public void setDesctxt(String desctxt) {
		this.desctxt = desctxt;
	}
	public String getLogTblNm() {
		return logTblNm;
	}
	public void setLogTblNm(String logTblNm) {
		this.logTblNm = logTblNm;
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
	public String getExecCycleDesc() {
		return execCycleDesc;
	}
	public void setExecCycleDesc(String execCycleDesc) {
		this.execCycleDesc = execCycleDesc;
	}


}
