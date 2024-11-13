package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
* @name : infavor.loyalty.trans.dto.response.LOYTransDetailResponseDTO
* @date : 2018. 1. 30.
* @author : kimjunki
* @description :
*/

@PersonalData
public class LoyTransDetailResDto extends GridPagingItemResDto{

	private String dtlApprDate;
	private String dtlApprNo;
	private String dtlPntTxnType2Cd;
	private String dtlMbrNo;
	private String dtlCustNm;
	private String dtlMemDiv;
	private String dtlRidTierCur;
	private String dtlPntAmt;
	private String dtlUsePnt;
	private String dtlChnlNo;
	private String dtlChnlNm;
	private String dtlBizno;
	private String dtlTotalPntAvl;
	private String dtlGiftPnt;
	private String dtlMemGrade;
	
	@Decrypted(masked="cardNum")
	private String dtlCardNum;
	private String dtlPntTxnType1Cd;
	private String dtlCprtCardCd;
	private String dtlCardTypeCd;
	
	
	public String getDtlApprDate() {
		return dtlApprDate;
	}
	public void setDtlApprDate(String dtlApprDate) {
		this.dtlApprDate = dtlApprDate;
	}
	public String getDtlApprNo() {
		return dtlApprNo;
	}
	public void setDtlApprNo(String dtlApprNo) {
		this.dtlApprNo = dtlApprNo;
	}
	public String getDtlPntTxnType2Cd() {
		return dtlPntTxnType2Cd;
	}
	public void setDtlPntTxnType2Cd(String dtlPntTxnType2Cd) {
		this.dtlPntTxnType2Cd = dtlPntTxnType2Cd;
	}
	public String getDtlMbrNo() {
		return dtlMbrNo;
	}
	public void setDtlMbrNo(String dtlMbrNo) {
		this.dtlMbrNo = dtlMbrNo;
	}

	public String getDtlCustNm() {
		return dtlCustNm;
	}
	public void setDtlCustNm(String dtlCustNm) {
		this.dtlCustNm = dtlCustNm;
	}
	public String getDtlMemDiv() {
		return dtlMemDiv;
	}
	public void setDtlMemDiv(String dtlMemDiv) {
		this.dtlMemDiv = dtlMemDiv;
	}
	public String getDtlRidTierCur() {
		return dtlRidTierCur;
	}
	public void setDtlRidTierCur(String dtlRidTierCur) {
		this.dtlRidTierCur = dtlRidTierCur;
	}
	public String getDtlPntAmt() {
		return dtlPntAmt;
	}
	public void setDtlPntAmt(String dtlPntAmt) {
		this.dtlPntAmt = dtlPntAmt;
	}
	public String getDtlUsePnt() {
		return dtlUsePnt;
	}
	public void setDtlUsePnt(String dtlUsePnt) {
		this.dtlUsePnt = dtlUsePnt;
	}
	public String getDtlChnlNo() {
		return dtlChnlNo;
	}
	public void setDtlChnlNo(String dtlChnlNo) {
		this.dtlChnlNo = dtlChnlNo;
	}
	public String getDtlChnlNm() {
		return dtlChnlNm;
	}
	public void setDtlChnlNm(String dtlChnlNm) {
		this.dtlChnlNm = dtlChnlNm;
	}
	public String getDtlBizno() {
		return dtlBizno;
	}
	public void setDtlBizno(String dtlBizno) {
		this.dtlBizno = dtlBizno;
	}
	public String getDtlTotalPntAvl() {
		return dtlTotalPntAvl;
	}
	public void setDtlTotalPntAvl(String dtlTotalPntAvl) {
		this.dtlTotalPntAvl = dtlTotalPntAvl;
	}
	public String getDtlGiftPnt() {
		return dtlGiftPnt;
	}
	public void setDtlGiftPnt(String dtlGiftPnt) {
		this.dtlGiftPnt = dtlGiftPnt;
	}
	public String getDtlMemGrade() {
		return dtlMemGrade;
	}
	public void setDtlMemGrade(String dtlMemGrade) {
		this.dtlMemGrade = dtlMemGrade;
	}
	public String getDtlCardNum() {
		return dtlCardNum;
	}
	public void setDtlCardNum(String dtlCardNum) {
		this.dtlCardNum = dtlCardNum;
	}
	public String getDtlPntTxnType1Cd() {
		return dtlPntTxnType1Cd;
	}
	public void setDtlPntTxnType1Cd(String dtlPntTxnType1Cd) {
		this.dtlPntTxnType1Cd = dtlPntTxnType1Cd;
	}
	public String getDtlCprtCardCd() {
		return dtlCprtCardCd;
	}
	public void setDtlCprtCardCd(String dtlCprtCardCd) {
		this.dtlCprtCardCd = dtlCprtCardCd;
	}
	public String getDtlCardTypeCd() {
		return dtlCardTypeCd;
	}
	public void setDtlCardTypeCd(String dtlCardTypeCd) {
		this.dtlCardTypeCd = dtlCardTypeCd;
	}
	

}
