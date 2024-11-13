package com.icignal.loyalty.channel.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyChnlSubTxnHistListResDto
 * 2. 파일명	: LoyChnlSubTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 11. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@PersonalData
@CommCode
public class LoyChnlSubTxnHistListResDto {


	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String apprDate;
	private String mbrNo;
	private String custNm;
	
	@Decrypted(masked = "cardNum")
	private String cardNum;
	
	@MarkName(groupCode="TXN_SUB_TYPE_CD" , codeField="pnt_txn_type_2_cd")
	private String pntTxnType2Cd;
	private String prodNm;
	private String txnAmt;
	private String pntAmt;
	private String usePnt;
	private String giftPnt;
	private String mbrType;
    private String cprtCardCd;
    private String ridMbr;
    private String cipherKey;


	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
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
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
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
	public String getPntAmt() {
		return pntAmt;
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
	/**
	* @return the ridMbr
	*/
	public String getRidMbr() {
		return ridMbr;
	}
	/**
	* @param ridMbr the ridMbr to set
	*/
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

}
