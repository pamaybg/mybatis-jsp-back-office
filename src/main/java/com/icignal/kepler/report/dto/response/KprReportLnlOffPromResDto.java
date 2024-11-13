package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


public class KprReportLnlOffPromResDto extends GridPagingItemResDto {
	
	private String chnlNm          ;
	private String promNm          ;
	private String promDate        ;
	private String prodId		   ; 
	private String prodNm	       ; 
	private String ctgLNm          ;
	private String ctgMNm          ;
	private String ctgSNm          ;
	private long allOrdCnt         ;
	private long intgOrdCnt        ;
	private long m2OrdCnt          ;
	private long totSaleAmt        ;
	private long saleAmt           ;
	private long ordCnt            ;
	private String chnlSubType    ;
	
	private String chnlType;
	private String ridProm;
	private String promCd;
	
	
	
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getRidProm() {
		return ridProm;
	}
	public void setRidProm(String ridProm) {
		this.ridProm = ridProm;
	}
	public String getPromCd() {
		return promCd;
	}
	public void setPromCd(String promCd) {
		this.promCd = promCd;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getPromNm() {
		return promNm;
	}
	public void setPromNm(String promNm) {
		this.promNm = promNm;
	}
	public String getPromDate() {
		return promDate;
	}
	public void setPromDate(String promDate) {
		this.promDate = promDate;
	}
	public String getCtgLNm() {
		return ctgLNm;
	}
	public void setCtgLNm(String ctgLNm) {
		this.ctgLNm = ctgLNm;
	}
	public String getCtgMNm() {
		return ctgMNm;
	}
	public void setCtgMNm(String ctgMNm) {
		this.ctgMNm = ctgMNm;
	}
	public String getCtgSNm() {
		return ctgSNm;
	}
	public void setCtgSNm(String ctgSNm) {
		this.ctgSNm = ctgSNm;
	}
	public long getAllOrdCnt() {
		return allOrdCnt;
	}
	public void setAllOrdCnt(long allOrdCnt) {
		this.allOrdCnt = allOrdCnt;
	}
	public long getIntgOrdCnt() {
		return intgOrdCnt;
	}
	public void setIntgOrdCnt(long intgOrdCnt) {
		this.intgOrdCnt = intgOrdCnt;
	}
	public long getM2OrdCnt() {
		return m2OrdCnt;
	}
	public void setM2OrdCnt(long m2OrdCnt) {
		this.m2OrdCnt = m2OrdCnt;
	}
	public long getTotSaleAmt() {
		return totSaleAmt;
	}
	public void setTotSaleAmt(long totSaleAmt) {
		this.totSaleAmt = totSaleAmt;
	}
	public long getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(long saleAmt) {
		this.saleAmt = saleAmt;
	}
	public long getOrdCnt() {
		return ordCnt;
	}
	public void setOrdCnt(long ordCnt) {
		this.ordCnt = ordCnt;
	}
	public String getChnlSubType() {
		return chnlSubType;
	}
	public void setChnlSubType(String chnlSubType) {
		this.chnlSubType = chnlSubType;
	}
	
	
}
