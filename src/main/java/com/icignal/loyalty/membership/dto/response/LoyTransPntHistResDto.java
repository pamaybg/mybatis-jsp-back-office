package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

@SuppressWarnings("serial")
public class LoyTransPntHistResDto extends GridPagingItemResDto {
	private String regDt     ;
	private String tgtMbr    ;
	private String srcMbr    ;
	private String pnt       ;
	private String regUser   ;
	private String reason    ;
	private String rid       ;
	private String srcMbrCd  ;
	
	
	
	public String getSrcMbrCd() {
		return srcMbrCd;
	}
	public void setSrcMbrCd(String srcMbrCd) {
		this.srcMbrCd = srcMbrCd;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getTgtMbr() {
		return tgtMbr;
	}
	public void setTgtMbr(String tgtMbr) {
		this.tgtMbr = tgtMbr;
	}
	public String getSrcMbr() {
		return srcMbr;
	}
	public void setSrcMbr(String srcMbr) {
		this.srcMbr = srcMbr;
	}
	public String getPnt() {
		return pnt;
	}
	public void setPnt(String pnt) {
		this.pnt = pnt;
	}
	public String getRegUser() {
		return regUser;
	}
	public void setRegUser(String regUser) {
		this.regUser = regUser;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}    
	
}
