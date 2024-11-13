package com.icignal.loyalty.membership.dto.response;


import com.icignal.common.base.dto.response.StatusResDto;

public class LoyTransCallExecResDto extends StatusResDto  {
	
	private String pRslt	    ;
	private String pRsltCd	    ;
	private String pRsltMsg     ;
	
	public String getpRslt() {
		return pRslt;
	}
	public void setpRslt(String pRslt) {
		this.pRslt = pRslt;
	}
	public String getpRsltCd() {
		return pRsltCd;
	}
	public void setpRsltCd(String pRsltCd) {
		this.pRsltCd = pRsltCd;
	}
	public String getpRsltMsg() {
		return pRsltMsg;
	}
	public void setpRsltMsg(String pRsltMsg) {
		this.pRsltMsg = pRsltMsg;
	}
	
}
