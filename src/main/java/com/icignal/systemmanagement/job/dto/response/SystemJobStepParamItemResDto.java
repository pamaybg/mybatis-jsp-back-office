package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class SystemJobStepParamItemResDto extends GridPagingItemResDto{
	private String rid;

	private String itemType;
	@MarkName(groupCode = "BATCH_ITEM_TYPE", codeField = "itemType")
	private String itemTypeNm;

	private String paramDesc;
	private String maprId;
	private String maprParam;
	private String execCmnd;

	private String cmndParamType;
	@MarkName(groupCode = "BATCH_COMMAND_PARAM_TYPE", codeField = "cmndParamType")
	private String cmndParamTypeNm;

	private String workingDir;
	private String modifyBy;
	private String modifyDate;
	private String cmndParam;

	private String ridStep;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItemTypeNm() {
		return itemTypeNm;
	}
	public void setItemTypeNm(String itemTypeNm) {
		this.itemTypeNm = itemTypeNm;
	}
	public String getParamDesc() {
		return paramDesc;
	}
	public void setParamDesc(String paramDesc) {
		this.paramDesc = paramDesc;
	}
	public String getMaprId() {
		return maprId;
	}
	public void setMaprId(String maprId) {
		this.maprId = maprId;
	}
	public String getExecCmnd() {
		return execCmnd;
	}
	public void setExecCmnd(String execCmnd) {
		this.execCmnd = execCmnd;
	}
	public String getCmndParamType() {
		return cmndParamType;
	}
	public void setCmndParamType(String cmndParamType) {
		this.cmndParamType = cmndParamType;
	}
	public String getCmndParamTypeNm() {
		return cmndParamTypeNm;
	}
	public void setCmndParamTypeNm(String cmndParamTypeNm) {
		this.cmndParamTypeNm = cmndParamTypeNm;
	}
	public String getWorkingDir() {
		return workingDir;
	}
	public void setWorkingDir(String workingDir) {
		this.workingDir = workingDir;
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
	public String getCmndParam() {
		return cmndParam;
	}
	public void setCmndParam(String cmndParam) {
		this.cmndParam = cmndParam;
	}
	public String getRidStep() {
		return ridStep;
	}
	public void setRidStep(String ridStep) {
		this.ridStep = ridStep;
	}
	public String getMaprParam() {
		return maprParam;
	}
	public void setMaprParam(String maprParam) {
		this.maprParam = maprParam;
	}



}
