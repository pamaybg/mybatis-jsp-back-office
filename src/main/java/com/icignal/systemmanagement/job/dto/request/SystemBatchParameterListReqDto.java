package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class SystemBatchParameterListReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String modifyBy;
	private String modifyDate;
	private String ridJob;
	private String paramNm;

	private String paramType;
	@MarkName(groupCode="BATCH_JOB_PARAM_TYPE", codeField="paramType")
	private String paramTypeNm;

	private String paramVal;

	private String paramSubType;
	@MarkName(groupCode="BATCH_JOB_PARAM_SUB_TYPE", codeField="paramSubType")
	private String paramSubTypeNm;

	private List<String> rids;


	public String getParamTypeNm() {
		return paramTypeNm;
	}

	public void setParamTypeNm(String paramTypeNm) {
		this.paramTypeNm = paramTypeNm;
	}

	public String getRidJob() {
		return ridJob;
	}

	public void setRidJob(String ridJob) {
		this.ridJob = ridJob;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getParamNm() {
		return paramNm;
	}

	public void setParamNm(String paramNm) {
		this.paramNm = paramNm;
	}

	public String getParamType() {
		return paramType;
	}

	public void setParamType(String paramType) {
		this.paramType = paramType;
	}

	public String getParamVal() {
		return paramVal;
	}

	public void setParamVal(String paramVal) {
		this.paramVal = paramVal;
	}

	public String getParamSubType() {
		return paramSubType;
	}

	public void setParamSubType(String paramSubType) {
		this.paramSubType = paramSubType;
	}

	public String getParamSubTypeNm() {
		return paramSubTypeNm;
	}

	public void setParamSubTypeNm(String paramSubTypeNm) {
		this.paramSubTypeNm = paramSubTypeNm;
	}

	public List<String> getRids() {
		return rids;
	}

	public void setRids(List<String> rids) {
		this.rids = rids;
	}

}