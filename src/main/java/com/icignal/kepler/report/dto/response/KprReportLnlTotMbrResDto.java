package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/*
 * 락앤락 전체 회원 현황
 * */


public class KprReportLnlTotMbrResDto extends GridPagingItemResDto{
	
	private String yyyymmdd;
	private String chnlNm;
	private int totCnt; //총회원수
	private int activeCnt; 
	private int newCnt; //신규 회원수
	private int transCnt; //전환 회원수
	private int offlineCnt; //전환전 오프라인 수
	private int onlineCnt; //전환전 자사몰 수
	private int drmncyCnt; //휴면화원수
	private int sescnCnt; //탈회회원수
	private String chnlNo;
	private String rid;
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}
	public int getActiveCnt() {
		return activeCnt;
	}
	public void setActiveCnt(int activeCnt) {
		this.activeCnt = activeCnt;
	}
	public int getNewCnt() {
		return newCnt;
	}
	public void setNewCnt(int newCnt) {
		this.newCnt = newCnt;
	}
	public int getTransCnt() {
		return transCnt;
	}
	public void setTransCnt(int transCnt) {
		this.transCnt = transCnt;
	}
	public int getOfflineCnt() {
		return offlineCnt;
	}
	public void setOfflineCnt(int offlineCnt) {
		this.offlineCnt = offlineCnt;
	}
	public int getOnlineCnt() {
		return onlineCnt;
	}
	public void setOnlineCnt(int onlineCnt) {
		this.onlineCnt = onlineCnt;
	}
	public int getDrmncyCnt() {
		return drmncyCnt;
	}
	public void setDrmncyCnt(int drmncyCnt) {
		this.drmncyCnt = drmncyCnt;
	}
	public int getSescnCnt() {
		return sescnCnt;
	}
	public void setSescnCnt(int sescnCnt) {
		this.sescnCnt = sescnCnt;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

	

}
