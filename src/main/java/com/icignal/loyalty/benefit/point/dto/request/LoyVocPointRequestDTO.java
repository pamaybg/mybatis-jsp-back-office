package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyVocPointRequestDTO extends CommonDataAuthReqDto {

	
	private String rid;
	private String ridChnl;
	private String ridCust;
	
	private String cipherKey;
	private String chnlLvlNo;
	private String parRidTop;
	private String identiTypeCd;
	private String identiVal;
	private String pntTxnType1Cd;
	private String pntTxnType2Cd;
	private Integer pntAmt;
	private String reqDate;
	private String reqByRid;
	private String txnTypeDtlDesc;
	private String offerNo;
	private String offerType;
	private String offerSubType;
	
	public String getParRidTop() {
		return parRidTop;
	}

	public void setParRidTop(String parRidTop) {
		this.parRidTop = parRidTop;
	}

	public String getChnlLvlNo() {
		return chnlLvlNo;
	}

	public void setChnlLvlNo(String chnlLvlNo) {
		this.chnlLvlNo = chnlLvlNo;
	}

	public LoyVocPointRequestDTO(){
		/*try {
		    this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e){
			LogUtil.error(e);
		}*/
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getRidCust() {
		return ridCust;
	}

	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public String getIdentiTypeCd() {
		return identiTypeCd;
	}

	public void setIdentiTypeCd(String identiTypeCd) {
		this.identiTypeCd = identiTypeCd;
	}

	public String getIdentiVal() {
		return identiVal;
	}

	public void setIdentiVal(String identiVal) {
		this.identiVal = identiVal;
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

	public Integer getPntAmt() {
		return pntAmt;
	}

	public void setPntAmt(Integer pntAmt) {
		this.pntAmt = pntAmt;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public String getReqByRid() {
		return reqByRid;
	}

	public void setReqByRid(String reqByRid) {
		this.reqByRid = reqByRid;
	}

	public String getTxnTypeDtlDesc() {
		return txnTypeDtlDesc;
	}

	public void setTxnTypeDtlDesc(String txnTypeDtlDesc) {
		this.txnTypeDtlDesc = txnTypeDtlDesc;
	}

	public String getOfferNo() {
		return offerNo;
	}

	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}

	public String getOfferType() {
		return offerType;
	}

	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}

	public String getOfferSubType() {
		return offerSubType;
	}

	public void setOfferSubType(String offerSubType) {
		this.offerSubType = offerSubType;
	}
	
	
}
