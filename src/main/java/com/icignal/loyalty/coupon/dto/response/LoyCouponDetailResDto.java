package com.icignal.loyalty.coupon.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 
* <pre>
* infavor.loyalty.simulation.dto.response
*  |_ LOYChnlComboResponseDTO.java
* </pre>
* @작성일		: 2017. 1. 11. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
public class LoyCouponDetailResDto extends GridPagingItemResDto{
	private String dtlApprDt;
	private String dtlApprNo;
	private String dtlTxnType2Cd;
	private String dtlTxnType1Cd;
	private String dtlChnlNo;
	private String dtlChnlNm;

	private String dtlMbrNo;
	private String dtlCustNm;
	private String dtlMemDiv;
	private String dtlMemGrade;
	private String dtlGiftMbrNo;
	private String dtlGiftCustNm;
	private String dtlAcrlStamp;
	private String dtlUseStamp;
	private String dtlGiftStamp;
	private String dtlAvlStamp;
	private String dtlProdId;
	private String dtlProdNm;
	private String dtlCnclYn;
	private String dtlTxnType2CdDt;
	private String dtlCnclDt;
	private String dtlCnclRsnCd;
	private String dtlOrgnApprDate;
	private String dtlTicketNum;
	private String dtlCompnApprNo;
	private String stampTotal;



	

	
	
	public String getDtlTxnType1Cd() {
		return dtlTxnType1Cd;
	}
	public void setDtlTxnType1Cd(String dtlTxnType1Cd) {
		this.dtlTxnType1Cd = dtlTxnType1Cd;
	}
	public String getDtlApprDt() {
		return dtlApprDt;
	}
	public void setDtlApprDt(String dtlApprDt) {
		this.dtlApprDt = dtlApprDt;
	}
	public String getDtlMbrNo() {
		return dtlMbrNo;
	}
	public void setDtlMbrNo(String dtlMbrNo) {
		this.dtlMbrNo = dtlMbrNo;
	}
	public String getDtlAcrlStamp() {
		return dtlAcrlStamp;
	}
	public void setDtlAcrlStamp(String dtlAcrlStamp) {
		this.dtlAcrlStamp = dtlAcrlStamp;
	}
	public String getDtlUseStamp() {
		return dtlUseStamp;
	}
	public void setDtlUseStamp(String dtlUseStamp) {
		this.dtlUseStamp = dtlUseStamp;
	}
	public String getDtlCnclDt() {
		return dtlCnclDt;
	}
	public void setDtlCnclDt(String dtlCnclDt) {
		if(dtlCnclDt !=null){
			this.dtlCnclDt = dtlCnclDt;
		}
	}
	public String getDtlTxnType2Cd() {
		return dtlTxnType2Cd;
	}
	public void setDtlTxnType2Cd(String dtlTxnType2Cd) {
		this.dtlTxnType2Cd = dtlTxnType2Cd;
	}
	public String getDtlMemDiv() {
		return dtlMemDiv;
	}
	public void setDtlMemDiv(String dtlMemDiv) {
		this.dtlMemDiv = dtlMemDiv;
	}
	public String getDtlGiftStamp() {
		return dtlGiftStamp;
	}
	public void setDtlGiftStamp(String dtlGiftStamp) {
		this.dtlGiftStamp = dtlGiftStamp;
	}
	public String getDtlTxnType2CdDt() {
		return dtlTxnType2CdDt;
	}
	public void setDtlTxnType2CdDt(String dtlTxnType2CdDt) {
		this.dtlTxnType2CdDt = dtlTxnType2CdDt;
	}

	public String getDtlMemGrade() {
		return dtlMemGrade;
	}
	public void setDtlMemGrade(String dtlMemGrade) {
		this.dtlMemGrade = dtlMemGrade;
	}
	public String getDtlAvlStamp() {
		return dtlAvlStamp;
	}
	public void setDtlAvlStamp(String dtlAvlStamp) {
		this.dtlAvlStamp = dtlAvlStamp;
	}
	public String getDtlOrgnApprDate() {
		return dtlOrgnApprDate;
	}
	public void setDtlOrgnApprDate(String dtlOrgnApprDate) {
		this.dtlOrgnApprDate = dtlOrgnApprDate;
	}
	public String getDtlChnlNo() {
		return dtlChnlNo;
	}
	public void setDtlChnlNo(String dtlChnlNo) {
		this.dtlChnlNo = dtlChnlNo;
	}
	public String getDtlGiftMbrNo() {
		return dtlGiftMbrNo;
	}
	public void setDtlGiftMbrNo(String dtlGiftMbrNo) {
		this.dtlGiftMbrNo = dtlGiftMbrNo;
	}
	public String getDtlProdId() {
		return dtlProdId;
	}
	public void setDtlProdId(String dtlProdId) {
		this.dtlProdId = dtlProdId;
	}
	public String getDtlChnlNm() {
		return dtlChnlNm;
	}
	public void setDtlChnlNm(String dtlChnlNm) {
		this.dtlChnlNm = dtlChnlNm;
	}
	public String getDtlGiftCustNm() {
		return dtlGiftCustNm;
	}
	public void setDtlGiftCustNm(String dtlGiftCustNm) {
		this.dtlGiftCustNm = dtlGiftCustNm;
	}
	public String getDtlProdNm() {
		return dtlProdNm;
	}
	public void setDtlProdNm(String dtlProdNm) {
		this.dtlProdNm = dtlProdNm;
	}
	public String getDtlTicketNum() {
		return dtlTicketNum;
	}
	public void setDtlTicketNum(String dtlTicketNum) {
		this.dtlTicketNum = dtlTicketNum;
	}
	public String getDtlCompnApprNo() {
		return dtlCompnApprNo;
	}
	public void setDtlCompnApprNo(String dtlCompnApprNo) {
		this.dtlCompnApprNo = dtlCompnApprNo;
	}
	public String getStampTotal() {
		return stampTotal;
	}
	public void setStampTotal(String stampTotal) {
		this.stampTotal = stampTotal;
	}
	public String getDtlApprNo() {
		return dtlApprNo;
	}
	public void setDtlApprNo(String dtlApprNo) {
		this.dtlApprNo = dtlApprNo;
	}
	public String getDtlCustNm() {
		return dtlCustNm;
	}
	public void setDtlCustNm(String dtlCustNm) {
		this.dtlCustNm = dtlCustNm;
	}
	public String getDtlCnclYn() {
		return dtlCnclYn;
	}
	public void setDtlCnclYn(String dtlCnclYn) {
		this.dtlCnclYn = dtlCnclYn;
	}
	public String getDtlCnclRsnCd() {
		return dtlCnclRsnCd;
	}
	public void setDtlCnclRsnCd(String dtlCnclRsnCd) {
		this.dtlCnclRsnCd = dtlCnclRsnCd;
	}
	
	
	

}
