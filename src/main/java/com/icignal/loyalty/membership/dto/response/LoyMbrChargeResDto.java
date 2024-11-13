/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
  * @fileName : LOYMbrChargeResponseDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017.10.19
  * @author : swlim
  * @변경이력 :
  * @descripton : 멤버십 충천량
  */
public class LoyMbrChargeResDto  extends GridPagingItemResDto {
	/** 회원 번호 */
    private String mbrNo;
    private String txUniqNo;
    private String pntTxnType1Cd;
    private String apprDate;
    private String txnDate;
    private String txnDt;
    private String txnAmt;
    private String txnChannelCd;
    private String saveTypeVal;
    private String chnlNm;
    private String mbrbsCdadd;
    private String unitPrice;
    private String ProdId;
    private String chnlNo;
    private String prodUnitCost;
    private String searchYM;
    private String chargePrice;
    private String chargeAmt;


	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getTxUniqNo() {
		return txUniqNo;
	}
	public void setTxUniqNo(String txUniqNo) {
		this.txUniqNo = txUniqNo;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getTxnChannelCd() {
		return txnChannelCd;
	}
	public void setTxnChannelCd(String txnChannelCd) {
		this.txnChannelCd = txnChannelCd;
	}
	public String getSaveTypeVal() {
		return saveTypeVal;
	}
	public void setSaveTypeVal(String saveTypeVal) {
		this.saveTypeVal = saveTypeVal;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getMbrbsCdadd() {
		return mbrbsCdadd;
	}
	public void setMbrbsCdadd(String mbrbsCdadd) {
		this.mbrbsCdadd = mbrbsCdadd;
	}

	public String getProdId() {
		return ProdId;
	}
	public void setProdId(String prodId) {
		ProdId = prodId;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getProdUnitCost() {
		return prodUnitCost;
	}
	public void setProdUnitCost(String prodUnitCost) {
		this.prodUnitCost = prodUnitCost;
	}
	public String getSearchYM() {
		return searchYM;
	}
	public void setSearchYM(String searchYM) {
		this.searchYM = searchYM;
	}
	public String getChargePrice() {
		return chargePrice;
	}
	public void setChargePrice(String chargePrice) {
		this.chargePrice = chargePrice;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getChargeAmt() {
		return chargeAmt;
	}
	public void setChargeAmt(String chargeAmt) {
		this.chargeAmt = chargeAmt;
	}







}

