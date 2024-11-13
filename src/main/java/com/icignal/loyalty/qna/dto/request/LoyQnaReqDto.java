package com.icignal.loyalty.qna.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyQnaReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String srStatus;
	private String srAnsTxt;
	private String cipherKey;
	private String srReqTxt;
	private String srEmail;
	private String smtpAnsTxt;
	private String smtpReqTxt;
	
	
	public String getSmtpAnsTxt() {
		return smtpAnsTxt;
	}
	public void setSmtpAnsTxt(String smtpAnsTxt) {
		this.smtpAnsTxt = smtpAnsTxt;
	}
	public String getSmtpReqTxt() {
		return smtpReqTxt;
	}
	public void setSmtpReqTxt(String smtpReqTxt) {
		this.smtpReqTxt = smtpReqTxt;
	}
	public String getSrReqTxt() {
		return srReqTxt;
	}
	public void setSrReqTxt(String srReqTxt) {
		this.srReqTxt = srReqTxt;
	}
	public String getSrEmail() {
		return srEmail;
	}
	public void setSrEmail(String srEmail) {
		this.srEmail = srEmail;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSrStatus() {
		return srStatus;
	}
	public void setSrStatus(String srStatus) {
		this.srStatus = srStatus;
	}
	public String getSrAnsTxt() {
		return srAnsTxt;
	}
	public void setSrAnsTxt(String srAnsTxt) {
		this.srAnsTxt = srAnsTxt;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	/*
	 * public LoyQnaReqDto() { try {
	 * this.setCipherKey(CryptoManager.getCipherKey()); }catch(Exception e) {
	 * LogUtil.error(e); } }
	 */
}
