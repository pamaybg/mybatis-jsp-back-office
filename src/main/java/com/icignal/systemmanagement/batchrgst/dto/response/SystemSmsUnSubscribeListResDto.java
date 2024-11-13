package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemSmsUnSubscribeListResDto extends GridPagingItemResDto{
	private String fileUpldDt;
	private String fileNm;
	private String fileTotCnt;
	private String fileUpldSucesCnt;
	private String fileUpldFailCnt;
	private String pointTrtStatus;
	private String ridUpldEmp;
	private String rid;
	
	private String approvalNum;
	private String txnNum;
	private String requestDt;
	private String uploadRslt;
	private String errMsg;
	
	public String getApprovalNum() {
		return approvalNum;
	}
	public void setApprovalNum(String approvalNum) {
		this.approvalNum = approvalNum;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getRequestDt() {
		return requestDt;
	}
	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}
	public String getUploadRslt() {
		return uploadRslt;
	}
	public void setUploadRslt(String uploadRslt) {
		this.uploadRslt = uploadRslt;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFileUpldDt() {
		return fileUpldDt;
	}
	public void setFileUpldDt(String fileUpldDt) {
		this.fileUpldDt = fileUpldDt;
	}
	public String getFileTotCnt() {
		return fileTotCnt;
	}
	public void setFileTotCnt(String fileTotCnt) {
		this.fileTotCnt = fileTotCnt;
	}
	public String getFileUpldSucesCnt() {
		return fileUpldSucesCnt;
	}
	public void setFileUpldSucesCnt(String fileUpldSucesCnt) {
		this.fileUpldSucesCnt = fileUpldSucesCnt;
	}
	public String getFileUpldFailCnt() {
		return fileUpldFailCnt;
	}
	public void setFileUpldFailCnt(String fileUpldFailCnt) {
		this.fileUpldFailCnt = fileUpldFailCnt;
	}
	public String getPointTrtStatus() {
		return pointTrtStatus;
	}
	public void setPointTrtStatus(String pointTrtStatus) {
		this.pointTrtStatus = pointTrtStatus;
	}
	public String getRidUpldEmp() {
		return ridUpldEmp;
	}
	public void setRidUpldEmp(String ridUpldEmp) {
		this.ridUpldEmp = ridUpldEmp;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	
	
}
