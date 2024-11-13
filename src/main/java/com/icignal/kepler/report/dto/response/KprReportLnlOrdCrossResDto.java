package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlOrdCrossResDto extends GridPagingItemResDto{
	
	private String salTypeCd     ; 
	private String grdTypeCd     ; 
	private long purMbrCnt       ;
	private String purMbrRate      ;
	private long ordCnt          ;
	private String ordCntRate      ;
	private long sellAmt         ;
	private long discntAmt       ;
	private long settleAmt       ;
	
	
	
	public String getSalTypeCd() {
		return salTypeCd;
	}
	public void setSalTypeCd(String salTypeCd) {
		this.salTypeCd = salTypeCd;
	}
	public String getGrdTypeCd() {
		return grdTypeCd;
	}
	public void setGrdTypeCd(String grdTypeCd) {
		this.grdTypeCd = grdTypeCd;
	}
	public long getPurMbrCnt() {
		return purMbrCnt;
	}
	public void setPurMbrCnt(long purMbrCnt) {
		this.purMbrCnt = purMbrCnt;
	}
	public long getOrdCnt() {
		return ordCnt;
	}
	public void setOrdCnt(long ordCnt) {
		this.ordCnt = ordCnt;
	}
	public String getPurMbrRate() {
		return purMbrRate;
	}
	public void setPurMbrRate(String purMbrRate) {
		this.purMbrRate = purMbrRate;
	}
	public String getOrdCntRate() {
		return ordCntRate;
	}
	public void setOrdCntRate(String ordCntRate) {
		this.ordCntRate = ordCntRate;
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
	
	
	

}
