package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportTimesSalResponseDTO
 * 2. 파일명	: KPRReportTimesSalResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportTimesSalResDto extends GridPagingItemResDto{

	private String times		;
	private String buyMbr		;
	private String rciptCnt		;
	private String rciptAmt		;	
	private String salAmt		;
	private String usePnt		;
	private String savePnt		;
	private String basicPnt		;
	private String evtPnt		;
	
	
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getBuyMbr() {
		return buyMbr;
	}
	public void setBuyMbr(String buyMbr) {
		this.buyMbr = buyMbr;
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
