package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlTierMbrResDto extends GridPagingItemResDto {
	
	private String yyyymmdd;
	private String chnlNm;
	private int totMbrCnt;
	private int llmCnt;
	private int vipCnt;
	private int vvipCnt;
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
	public int getTotMbrCnt() {
		return totMbrCnt;
	}
	public void setTotMbrCnt(int totMbrCnt) {
		this.totMbrCnt = totMbrCnt;
	}
	public int getLlmCnt() {
		return llmCnt;
	}
	public void setLlmCnt(int llmCnt) {
		this.llmCnt = llmCnt;
	}
	public int getVipCnt() {
		return vipCnt;
	}
	public void setVipCnt(int vipCnt) {
		this.vipCnt = vipCnt;
	}
	public int getVvipCnt() {
		return vvipCnt;
	}
	public void setVvipCnt(int vvipCnt) {
		this.vvipCnt = vvipCnt;
	}

}
