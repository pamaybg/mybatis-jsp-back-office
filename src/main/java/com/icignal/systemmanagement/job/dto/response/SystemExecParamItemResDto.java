package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemExecParamItemResDto extends GridPagingItemResDto {

	private String rid;
	private String paramNm;
	private String paramVal;
	private String paramTypeCd;
	private Integer paramSeq;

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

}
