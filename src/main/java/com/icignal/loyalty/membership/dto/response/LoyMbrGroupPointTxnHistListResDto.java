package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrGroupPointTxnHistListResDto extends GridPagingItemResDto {


	private String ridGroupMem  ;
	private String txnNum       ;
	private String txnDate      ;
	private String pntTxnType1Cd;
	private String pntTxnType1  ;
	private String pntTxnType2Cd;
	private String pntTxnType2  ;
	private String mbrNo        ;
	private String custNm       ;
	private String pntAmt       ;
	private String prodUnitCost ;
	private String prodQty     ;
	private String txnAmt       ;
	private String groupPnt    ;
	private String ridMbr       ;
	private String ridCust      ;
	public String getRidGroupMem() {
		return ridGroupMem;
	}
	public void setRidGroupMem(String ridGroupMem) {
		this.ridGroupMem = ridGroupMem;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType1() {
		return pntTxnType1;
	}
	public void setPntTxnType1(String pntTxnType1) {
		this.pntTxnType1 = pntTxnType1;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getPntTxnType2() {
		return pntTxnType2;
	}
	public void setPntTxnType2(String pntTxnType2) {
		this.pntTxnType2 = pntTxnType2;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getProdUnitCost() {
		return prodUnitCost;
	}
	public void setProdUnitCost(String prodUnitCost) {
		this.prodUnitCost = prodUnitCost;
	}

	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}

	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getProdQty() {
		return prodQty;
	}
	public void setProdQty(String prodQty) {
		this.prodQty = prodQty;
	}
	public String getGroupPnt() {
		return groupPnt;
	}
	public void setGroupPnt(String groupPnt) {
		this.groupPnt = groupPnt;
	}



}
