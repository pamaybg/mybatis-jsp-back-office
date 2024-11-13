package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlPathDeviceResDto extends GridPagingItemResDto{
	
	
	private String sbscPathCd      ;   
	private String sbscDeviceCd    ;   
	private long newCnt            ; 
	private long new2Cnt           ; 
	private long transCnt          ; 
	private long totMbrCnt         ;
	
	
	
	public String getSbscPathCd() {
		return sbscPathCd;
	}
	public void setSbscPathCd(String sbscPathCd) {
		this.sbscPathCd = sbscPathCd;
	}
	public String getSbscDeviceCd() {
		return sbscDeviceCd;
	}
	public void setSbscDeviceCd(String sbscDeviceCd) {
		this.sbscDeviceCd = sbscDeviceCd;
	}
	public long getNewCnt() {
		return newCnt;
	}
	public void setNewCnt(long newCnt) {
		this.newCnt = newCnt;
	}
	public long getNew2Cnt() {
		return new2Cnt;
	}
	public void setNew2Cnt(long new2Cnt) {
		this.new2Cnt = new2Cnt;
	}
	public long getTransCnt() {
		return transCnt;
	}
	public void setTransCnt(long transCnt) {
		this.transCnt = transCnt;
	}
	public long getTotMbrCnt() {
		return totMbrCnt;
	}
	public void setTotMbrCnt(long totMbrCnt) {
		this.totMbrCnt = totMbrCnt;
	} 
	
	
	
}
