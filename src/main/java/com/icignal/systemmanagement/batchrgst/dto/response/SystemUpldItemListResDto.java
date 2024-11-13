package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYUpldItemListResponseDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
@CommCode
public class SystemUpldItemListResDto {

	private String uploadRslt;
	@MarkName(groupCode = "TXN_TYPE_CD_TM", codeField = "typeCdNm")
	private String typeCd;
	private String typeCdNm;
	private String webLogin;
	private String mbrNo;
	private String reqPoint;
	private String e1MbrNo;
	private String mbrHidNm;
	@MarkName(groupCode = "LOY_MBR_STAT_CD", codeField = "memStatusCdNm")
	private String memStatus;
	private String memStatusCdNm;
	private String chnlNo;
	private String acntId;
	@MarkName(groupCode = "TXN_STATUS_UPLOAD", codeField = "statusCdNm")
	private String statusCd;
	private String statusCdNm;
	private String requestDt;
	private String requestId;
	@MarkName(groupCode = "TXN_TERMINAL", codeField = "terminalCdNm")
	private String terminalCd;
	private String terminalCdNm;
	private String txnDt;
	private String txnNum;
	private String approvalDt;
	private String approvalNum;
	@MarkName(groupCode = "VAN_RETURN_CODE", codeField = "returnCdNm")
	private String returnCd;
	private String returnCdNm;
	private String returnText;
	private String rid;
	private String ridPar;
	private String ridMbr;
	private String memDivCd;


	public String getUploadRslt() {
		return uploadRslt;
	}
	public void setUploadRslt(String uploadRslt) {
		this.uploadRslt = uploadRslt;
	}
	public String getTypeCd() {
		return typeCd;
	}
	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}
	public String getWebLogin() {
		return webLogin;
	}
	public void setWebLogin(String webLogin) {
		this.webLogin = webLogin;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getReqPoint() {
		return reqPoint;
	}
	public void setReqPoint(String reqPoint) {
		this.reqPoint = reqPoint;
	}
	public String getE1MbrNo() {
		return e1MbrNo;
	}
	public void setE1MbrNo(String e1MbrNo) {
		this.e1MbrNo = e1MbrNo;
	}
	public String getMbrHidNm() {
		return mbrHidNm;
	}
	public void setMbrHidNm(String mbrHidNm) {
		this.mbrHidNm = mbrHidNm;
	}
	public String getMemStatus() {
		return memStatus;
	}
	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getAcntId() {
		return acntId;
	}
	public void setAcntId(String acntId) {
		this.acntId = acntId;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getRequestDt() {
		return requestDt;
	}
	public void setRequestDt(String requestDt) {
		this.requestDt = requestDt;
	}
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public String getTerminalCd() {
		return terminalCd;
	}
	public void setTerminalCd(String terminalCd) {
		this.terminalCd = terminalCd;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getApprovalDt() {
		return approvalDt;
	}
	public void setApprovalDt(String approvalDt) {
		this.approvalDt = approvalDt;
	}
	public String getApprovalNum() {
		return approvalNum;
	}
	public void setApprovalNum(String approvalNum) {
		this.approvalNum = approvalNum;
	}
	public String getReturnCd() {
		return returnCd;
	}
	public void setReturnCd(String returnCd) {
		this.returnCd = returnCd;
	}
	public String getReturnText() {
		return returnText;
	}
	public void setReturnText(String returnText) {
		this.returnText = returnText;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPar() {
		return ridPar;
	}
	public void setRidPar(String ridPar) {
		this.ridPar = ridPar;
	}
	/**
	* @return the ridMbr
	*/
	public String getRidMbr() {
		return ridMbr;
	}
	/**
	* @param ridMbr the ridMbr to set
	*/
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMemDivCd() {
		return memDivCd;
	}
	public void setMemDivCd(String memDivCd) {
		this.memDivCd = memDivCd;
	}
	public String getTypeCdNm() {
		return typeCdNm;
	}
	public void setTypeCdNm(String typeCdNm) {
		this.typeCdNm = typeCdNm;
	}
	public String getMemStatusCdNm() {
		return memStatusCdNm;
	}
	public void setMemStatusCdNm(String memStatusCdNm) {
		this.memStatusCdNm = memStatusCdNm;
	}
	public String getStatusCdNm() {
		return statusCdNm;
	}
	public void setStatusCdNm(String statusCdNm) {
		this.statusCdNm = statusCdNm;
	}
	public String getTerminalCdNm() {
		return terminalCdNm;
	}
	public void setTerminalCdNm(String terminalCdNm) {
		this.terminalCdNm = terminalCdNm;
	}
	public String getReturnCdNm() {
		return returnCdNm;
	}
	public void setReturnCdNm(String returnCdNm) {
		this.returnCdNm = returnCdNm;
	}





}
