package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlMbrPerformResDto extends GridPagingItemResDto{
	
	
	private String yyyymmdd      ; 
	private String chnlNm        ; 
	private long newMbrCnt	     ; 
	private long newSellAmt	     ; 
	private long newDiscntAmt	 ; 
	private long newSettleAmt	 ; 
	private long newOrdCnt	     ; 
	private long newAvgOrdVal     ; 
	private long existMbrCnt		 ; 
	private long existSellAmt	 ;
	private long existDiscntAmt	 ; 
	private long existSettleAmt	 ; 
	private long existOrdCnt		 ; 
	private long existAvgOrdVal   ; 
	private long lapedMbrCnt		 ; 
	private long lapedSellAmt	 ;
	private long lapedDiscntAmt	 ; 
	private long lapedSettleAmt	 ; 
	private long lapedOrdCnt		 ; 
	private long lapedAvgOrdVal   ; 
	private long gawayMbrCnt		 ; 
	private long gawaySellAmt	 ;
	private long gawayDiscntAmt	 ; 
	private long gawaySettleAmt	 ; 
	private long gawayOrdCnt		 ; 
	private long gawayAvgOrdVal   ;
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
	public long getNewMbrCnt() {
		return newMbrCnt;
	}
	public void setNewMbrCnt(long newMbrCnt) {
		this.newMbrCnt = newMbrCnt;
	}
	public long getNewSellAmt() {
		return newSellAmt;
	}
	public void setNewSellAmt(long newSellAmt) {
		this.newSellAmt = newSellAmt;
	}
	public long getNewDiscntAmt() {
		return newDiscntAmt;
	}
	public void setNewDiscntAmt(long newDiscntAmt) {
		this.newDiscntAmt = newDiscntAmt;
	}
	public long getNewSettleAmt() {
		return newSettleAmt;
	}
	public void setNewSettleAmt(long newSettleAmt) {
		this.newSettleAmt = newSettleAmt;
	}
	public long getNewOrdCnt() {
		return newOrdCnt;
	}
	public void setNewOrdCnt(long newOrdCnt) {
		this.newOrdCnt = newOrdCnt;
	}
	public long getNewAvgOrdVal() {
		return newAvgOrdVal;
	}
	public void setNewAvgOrdVal(long newAvgOrdVal) {
		this.newAvgOrdVal = newAvgOrdVal;
	}
	public long getExistMbrCnt() {
		return existMbrCnt;
	}
	public void setExistMbrCnt(long existMbrCnt) {
		this.existMbrCnt = existMbrCnt;
	}
	public long getExistSellAmt() {
		return existSellAmt;
	}
	public void setExistSellAmt(long existSellAmt) {
		this.existSellAmt = existSellAmt;
	}
	public long getExistDiscntAmt() {
		return existDiscntAmt;
	}
	public void setExistDiscntAmt(long existDiscntAmt) {
		this.existDiscntAmt = existDiscntAmt;
	}
	public long getExistSettleAmt() {
		return existSettleAmt;
	}
	public void setExistSettleAmt(long existSettleAmt) {
		this.existSettleAmt = existSettleAmt;
	}
	public long getExistOrdCnt() {
		return existOrdCnt;
	}
	public void setExistOrdCnt(long existOrdCnt) {
		this.existOrdCnt = existOrdCnt;
	}
	public long getExistAvgOrdVal() {
		return existAvgOrdVal;
	}
	public void setExistAvgOrdVal(long existAvgOrdVal) {
		this.existAvgOrdVal = existAvgOrdVal;
	}
	public long getLapedMbrCnt() {
		return lapedMbrCnt;
	}
	public void setLapedMbrCnt(long lapedMbrCnt) {
		this.lapedMbrCnt = lapedMbrCnt;
	}
	public long getLapedSellAmt() {
		return lapedSellAmt;
	}
	public void setLapedSellAmt(long lapedSellAmt) {
		this.lapedSellAmt = lapedSellAmt;
	}
	public long getLapedDiscntAmt() {
		return lapedDiscntAmt;
	}
	public void setLapedDiscntAmt(long lapedDiscntAmt) {
		this.lapedDiscntAmt = lapedDiscntAmt;
	}
	public long getLapedSettleAmt() {
		return lapedSettleAmt;
	}
	public void setLapedSettleAmt(long lapedSettleAmt) {
		this.lapedSettleAmt = lapedSettleAmt;
	}
	public long getLapedOrdCnt() {
		return lapedOrdCnt;
	}
	public void setLapedOrdCnt(long lapedOrdCnt) {
		this.lapedOrdCnt = lapedOrdCnt;
	}
	public long getLapedAvgOrdVal() {
		return lapedAvgOrdVal;
	}
	public void setLapedAvgOrdVal(long lapedAvgOrdVal) {
		this.lapedAvgOrdVal = lapedAvgOrdVal;
	}
	public long getGawayMbrCnt() {
		return gawayMbrCnt;
	}
	public void setGawayMbrCnt(long gawayMbrCnt) {
		this.gawayMbrCnt = gawayMbrCnt;
	}
	public long getGawaySellAmt() {
		return gawaySellAmt;
	}
	public void setGawaySellAmt(long gawaySellAmt) {
		this.gawaySellAmt = gawaySellAmt;
	}
	public long getGawayDiscntAmt() {
		return gawayDiscntAmt;
	}
	public void setGawayDiscntAmt(long gawayDiscntAmt) {
		this.gawayDiscntAmt = gawayDiscntAmt;
	}
	public long getGawaySettleAmt() {
		return gawaySettleAmt;
	}
	public void setGawaySettleAmt(long gawaySettleAmt) {
		this.gawaySettleAmt = gawaySettleAmt;
	}
	public long getGawayOrdCnt() {
		return gawayOrdCnt;
	}
	public void setGawayOrdCnt(long gawayOrdCnt) {
		this.gawayOrdCnt = gawayOrdCnt;
	}
	public long getGawayAvgOrdVal() {
		return gawayAvgOrdVal;
	}
	public void setGawayAvgOrdVal(long gawayAvgOrdVal) {
		this.gawayAvgOrdVal = gawayAvgOrdVal;
	}
	

	
	
}
