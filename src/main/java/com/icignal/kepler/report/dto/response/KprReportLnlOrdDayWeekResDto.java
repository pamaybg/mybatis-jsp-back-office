package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlOrdDayWeekResDto extends GridPagingItemResDto{

	
	private String dayCd      ;   
	private String ageCd	  ; 
	private String chnlNm     ;   
	private long purMbrCnt    ; 
	private long sellAmt      ; 
	private long discntAmt    ; 
	private long settleAmt    ; 
	private long ordCnt       ; 
	private long avgSettleAmt ;
	private long unitPrice    ; 
	
	public String getDayCd() {
		return dayCd;
	}
	public void setDayCd(String dayCd) {
		this.dayCd = dayCd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public long getPurMbrCnt() {
		return purMbrCnt;
	}
	public void setPurMbrCnt(long purMbrCnt) {
		this.purMbrCnt = purMbrCnt;
	}
	public long getSellAmt() {
		return sellAmt;
	}
	public void setSellAmt(long sellAmt) {
		this.sellAmt = sellAmt;
	}
	public long getDiscntAmt() {
		return discntAmt;
	}
	public void setDiscntAmt(long discntAmt) {
		this.discntAmt = discntAmt;
	}
	public long getSettleAmt() {
		return settleAmt;
	}
	public void setSettleAmt(long settleAmt) {
		this.settleAmt = settleAmt;
	}
	public long getOrdCnt() {
		return ordCnt;
	}
	public void setOrdCnt(long ordCnt) {
		this.ordCnt = ordCnt;
	}
	public long getAvgSettleAmt() {
		return avgSettleAmt;
	}
	public void setAvgSettleAmt(long avgSettleAmt) {
		this.avgSettleAmt = avgSettleAmt;
	}
	public long getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(long unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getAgeCd() {
		return ageCd;
	}
	public void setAgeCd(String ageCd) {
		this.ageCd = ageCd;
	} 
	
	
}
