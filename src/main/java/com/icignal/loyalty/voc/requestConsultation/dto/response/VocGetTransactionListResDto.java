package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


/**
 * @name : VOCGetTransactionListResponseDTO.java
 * @date : 2017. 10. 17.
 * @author : jun.lee
 * @description : 포인트거래 목록 조회
 */

@PersonalData
public class VocGetTransactionListResDto extends GridPagingItemResDto {
	
	private String txnUniqNo;
	private String apprDate;
	private String pntTxnType1Cd;
	private String pntTxnType2Cd;
	private String mbrNo;
	private String custNm;
	private String memDiv;
	private String memGrade;
	private String pntAmt;
	private String usePnt;
	private String giftPnt;
	private String prodNm;
	private String txnAmt;
	private String chnlNo;
	private String chnlNm;
	private String groupPnt;
	private String rid;
	@Decrypted(masked="cardNum")
	private String cardNoDecoding;
	private String cardNo;
	private String ridMbr;
	private String promoCnt;
	private String ridMbrCard;
	private String mbrType;
	private String cprtCardCd;
	private String cardKndNm;
	private String cprtCard;
	
	public String getCardNoDecoding() {
		return cardNoDecoding;
	}
	public void setCardNoDecoding(String cardNoDecoding) {
		this.cardNoDecoding = cardNoDecoding;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
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
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	
	
	public String getMemGrade() {
		return memGrade;
	}
	public void setMemGrade(String memGrade) {
		this.memGrade = memGrade;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(String usePnt) {
		this.usePnt = usePnt;
	}
	public String getGiftPnt() {
		return giftPnt;
	}
	public void setGiftPnt(String giftPnt) {
		this.giftPnt = giftPnt;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getGroupPnt() {
		return groupPnt;
	}
	public void setGroupPnt(String groupPnt) {
		this.groupPnt = groupPnt;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getPromoCnt() {
		return promoCnt;
	}
	public void setPromoCnt(String promoCnt) {
		this.promoCnt = promoCnt;
	}
	public String getRidMbrCard() {
		return ridMbrCard;
	}
	public void setRidMbrCard(String ridMbrCard) {
		this.ridMbrCard = ridMbrCard;
	}
	public String getMbrType() {
		return mbrType;
	}
	public void setMbrType(String mbrType) {
		this.mbrType = mbrType;
	}
	public String getCprtCardCd() {
		return cprtCardCd;
	}
	public void setCprtCardCd(String cprtCardCd) {
		this.cprtCardCd = cprtCardCd;
	}
	public String getCprtCard() {
		return cprtCard;
	}
	public void setCprtCard(String cprtCard) {
		this.cprtCard = cprtCard;
	}
	public String getCardKndNm() {
		return cardKndNm;
	}
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}
}