package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlOrdProdResDto extends GridPagingItemResDto{
	
	 private String prodId        ;       
	 private String itemCd        ;       
	 private String prodNm        ;       
	 private long purMbrCnt       ;     
	 private long ordCnt          ;     
	 private long sellAmt         ;     
	 private long discntAmt       ;     
	 private long settleAmt       ;
	 
	 private String ordCntSum;
	 private String sellAmtSum;
	 

     private String chnlType;
     private String custTypeCd;
	 
	 
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
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
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getOrdCntSum() {
		return ordCntSum;
	}
	public void setOrdCntSum(String ordCntSum) {
		this.ordCntSum = ordCntSum;
	}
	public String getSellAmtSum() {
		return sellAmtSum;
	}
	public void setSellAmtSum(String sellAmtSum) {
		this.sellAmtSum = sellAmtSum;
	}

	
}
