package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportMonthSalseResponseDTO
 * 2. 파일명	: KPRReportMonthSalseResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportMonthSalseResDto extends GridPagingItemResDto{
	private String month		;
	private String buyMbr  	    ;
	private String buyCnt		;
	private String rciptCnt	    ;
	private String rciptAmt	    ;
	private String salAmt		;
	private String membership	;
	private String sotreMbr	    ;
	private String mbrWp		;
	private String usePnt		;
	private String savePnt		;
	private String dropPnt		;
	private String basicPnt	    ;
	private String evtPnt		;
	private String wdMemCnt;
	
	
	
	public String getWdMemCnt() {
		return wdMemCnt;
	}
	public void setWdMemCnt(String wdMemCnt) {
		this.wdMemCnt = wdMemCnt;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getBuyMbr() {
		return buyMbr;
	}
	public void setBuyMbr(String buyMbr) {
		this.buyMbr = buyMbr;
	}
	public String getBuyCnt() {
		return buyCnt;
	}
	public void setBuyCnt(String buyCnt) {
		this.buyCnt = buyCnt;
	}
	public String getRciptCnt() {
		return rciptCnt;
	}
	public void setRciptCnt(String rciptCnt) {
		this.rciptCnt = rciptCnt;
	}
	public String getRciptAmt() {
		return rciptAmt;
	}
	public void setRciptAmt(String rciptAmt) {
		this.rciptAmt = rciptAmt;
	}
	public String getSalAmt() {
		return salAmt;
	}
	public void setSalAmt(String salAmt) {
		this.salAmt = salAmt;
	}
	public String getMembership() {
		return membership;
	}
	public void setMembership(String membership) {
		this.membership = membership;
	}
	public String getSotreMbr() {
		return sotreMbr;
	}
	public void setSotreMbr(String sotreMbr) {
		this.sotreMbr = sotreMbr;
	}
	public String getMbrWp() {
		return mbrWp;
	}
	public void setMbrWp(String mbrWp) {
		this.mbrWp = mbrWp;
	}
	public String getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(String usePnt) {
		this.usePnt = usePnt;
	}
	public String getSavePnt() {
		return savePnt;
	}
	public void setSavePnt(String savePnt) {
		this.savePnt = savePnt;
	}
	public String getDropPnt() {
		return dropPnt;
	}
	public void setDropPnt(String dropPnt) {
		this.dropPnt = dropPnt;
	}
	public String getBasicPnt() {
		return basicPnt;
	}
	public void setBasicPnt(String basicPnt) {
		this.basicPnt = basicPnt;
	}
	public String getEvtPnt() {
		return evtPnt;
	}
	public void setEvtPnt(String evtPnt) {
		this.evtPnt = evtPnt;
	}
}
