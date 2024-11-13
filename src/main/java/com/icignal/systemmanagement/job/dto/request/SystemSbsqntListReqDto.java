package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemSbsqntListReqDto extends MKTGridPagingReqDto {

	private List<String> rids;
	private String rid;
	private String ridJobMst;
	private String sbsqntJobNm;
	private String execCondCd;
	private String condVal;
	private int execTime;
	private String activeYn;

	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getSbsqntJobNm() {
		return sbsqntJobNm;
	}
	public void setSbsqntJobNm(String sbsqntJobNm) {
		this.sbsqntJobNm = sbsqntJobNm;
	}
	public String getExecCondCd() {
		return execCondCd;
	}
	public void setExecCondCd(String execCondCd) {
		this.execCondCd = execCondCd;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public int getExecTime() {
		return execTime;
	}
	public void setExecTime(int execTime) {
		this.execTime = execTime;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	
}
