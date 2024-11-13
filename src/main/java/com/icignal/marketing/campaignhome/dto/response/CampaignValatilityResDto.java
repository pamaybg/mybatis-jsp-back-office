package com.icignal.marketing.campaignhome.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class CampaignValatilityResDto extends GridPagingItemResDto{
	
	private String yearMonth;
	private String chnl;
	private String lastUpdateDate;
	
	//신규가입 캠페인 참여현황
	private String sbscDate;
	private String camNm;
	private int total;
	private String mmDate;
	
	
	
	public String getMmDate() {
		return mmDate;
	}
	public void setMmDate(String mmDate) {
		this.mmDate = mmDate;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getChnl() {
		return chnl;
	}
	public void setChnl(String chnl) {
		this.chnl = chnl;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(String lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

}
