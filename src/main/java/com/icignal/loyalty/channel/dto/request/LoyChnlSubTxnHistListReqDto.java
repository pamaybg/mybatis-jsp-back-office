package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlSubTxnHistListReqDto
 * 2. 파일명	: LoyChnlSubTxnHistListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *		하위가맹점 거래이력
 * </PRE>
 */ 
public class LoyChnlSubTxnHistListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String apprDate;
	private String mbrNo;
	private String custNm;
	private String cardNum;
	private String pntTxnType2Cd;
	private String prodNm;
	private String txnAmt;
	private String pntAmt;
	private String usePnt;
	private String giftPnt;
	private String chnlSearch;
//	private String cipherKey;
	
//	   public LoyChannelSubTxnHistListReqDto() {
//	        try {
//	            this.setCipherKey(CryptoManager.getCipherKey());
//	        }
//	        catch ( Exception e ) {
//	            LogUtil.error(e);
//	        }
//	    }
	
	
	public String getRid() {
		return rid;
	}
	public String getChnlSearch() {
		return chnlSearch;
	}
	public void setChnlSearch(String chnlSearch) {
		this.chnlSearch = chnlSearch;
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
//	public String getCipherKey() {
//		return cipherKey;
//	}
//	public void setCipherKey(String cipherKey) {
//		this.cipherKey = cipherKey;
//	}

	
}
