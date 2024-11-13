package com.icignal.loyalty.membership.dto.response;

import java.util.HashMap;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrProcResDto extends StatusResDto{

	private String pResultFlg;
	private String pRslt;
	private String pRsltMsg;
	private String pMbrRid;
	private String pMbrNo;

	private String sSuccess;
	private String sMessage;
	private HashMap<String, Object> rtnVal;

	public String getpResultFlg() {
		return pResultFlg;
	}
	public void setpResultFlg(String pResultFlg) {
		this.pResultFlg = pResultFlg;
	}
	public String getpRslt() {
		return pRslt;
	}
	public void setpRslt(String pRslt) {
		this.pRslt = pRslt;
	}
	public String getpRsltMsg() {
		return pRsltMsg;
	}
	public void setpRsltMsg(String pRsltMsg) {
		this.pRsltMsg = pRsltMsg;
	}
	public String getpMbrRid() {
		return pMbrRid;
	}
	public void setpMbrRid(String pMbrRid) {
		this.pMbrRid = pMbrRid;
	}
	public String getpMbrNo() {
		return pMbrNo;
	}
	public void setpMbrNo(String pMbrNo) {
		this.pMbrNo = pMbrNo;
	}
	/**
	* @return the sSuccess
	*/
	public String getsSuccess() {
		return sSuccess;
	}
	/**
	* @param sSuccess the sSuccess to set
	*/
	public void setsSuccess(String sSuccess) {
		this.sSuccess = sSuccess;
	}
	/**
	* @return the sMessage
	*/
	public String getsMessage() {
		return sMessage;
	}
	/**
	* @param sMessage the sMessage to set
	*/
	public void setsMessage(String sMessage) {
		this.sMessage = sMessage;
	}
	/**
	* @return the rtnVal
	*/
	public HashMap<String, Object> getRtnVal() {
		return rtnVal;
	}
	/**
	* @param rtnVal the rtnVal to set
	*/
	public void setRtnVal(HashMap<String, Object> rtnVal) {
		this.rtnVal = rtnVal;
	}





}
