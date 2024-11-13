package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemExecParamListReqDto extends MKTGridPagingReqDto {

	private String rid;
	private String ridJobMst;
	private String paramNm;
	private String paramVal;
	private String paramTypeCd;
	private Integer paramSeq;
	private List<String> rids;

	public String getRidJobMst() {
		return ridJobMst;
	}
	public void setRidJobMst(String ridJobMst) {
		this.ridJobMst = ridJobMst;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getParamNm() {
		return paramNm;
	}
	public void setParamNm(String paramNm) {
		this.paramNm = paramNm;
	}
	public String getParamVal() {
		return paramVal;
	}
	public void setParamVal(String paramVal) {
		this.paramVal = paramVal;
	}
	public String getParamTypeCd() {
		return paramTypeCd;
	}
	public void setParamTypeCd(String paramTypeCd) {
		this.paramTypeCd = paramTypeCd;
	}
	public Integer getParamSeq() {
		return paramSeq;
	}
	public void setParamSeq(Integer paramSeq) {
		this.paramSeq = paramSeq;
	}
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	
}
