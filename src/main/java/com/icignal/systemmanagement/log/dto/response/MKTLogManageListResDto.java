package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MKTLogManageListResDto extends GridPagingItemResDto {
	private String ifMethod;
	private String ifId;
	private String source;
	private String target;
	private String masterId;
	private String startDate;
	private String endDate;
	private String logSeq;
	private String inputMsg;
	private String outputMsg;
	private String errorCode;
	private String errorMsg;
	private String guid;
	private String ifName;
	
	public String getIfMethod() {
		return ifMethod;
	}
	public void setIfMethod(String ifMethod) {
		this.ifMethod = ifMethod;
	}
	public String getIfId() {
		return ifId;
	}
	public void setIfId(String ifId) {
		this.ifId = ifId;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getLogSeq() {
		return logSeq;
	}
	public void setLogSeq(String logSeq) {
		this.logSeq = logSeq;
	}
	public String getInputMsg() {
		return inputMsg;
	}
	public void setInputMsg(String inputMsg) {
		this.inputMsg = inputMsg;
	}
	public String getOutputMsg() {
		return outputMsg;
	}
	public void setOutputMsg(String outputMsg) {
		this.outputMsg = outputMsg;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	public String getIfName() {
		return ifName;
	}
	public void setIfName(String ifName) {
		this.ifName = ifName;
	}
}
