package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
 * @name : VOCGetTransactionListRequestDTO.java
 * @date : 2017. 10. 17.
 * @author : jun.lee
 * @description : 포인트거래 목록 조회
 */
public class VocGetTransactionListReqDto extends CommonDataAuthReqDto {
	
	private String cipherKey;
	private String mbrRidFlag;
	private String defaultMbrRid;
	private String pntTxnDateType;
	
	
	public VocGetTransactionListReqDto(){
		/*try {
			this.setCipherKey(CryptoManager.getCipherKey());
		} catch (Exception e) {
			LogUtility.error(e);
		}*/
	}
	
	
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getMbrRidFlag() {
		return mbrRidFlag;
	}
	public void setMbrRidFlag(String mbrRidFlag) {
		this.mbrRidFlag = mbrRidFlag;
	}
	public String getDefaultMbrRid() {
		return defaultMbrRid;
	}
	public void setDefaultMbrRid(String defaultMbrRid) {
		this.defaultMbrRid = defaultMbrRid;
	}


	public String getPntTxnDateType() {
		return pntTxnDateType;
	}


	public void setPntTxnDateType(String pntTxnDateType) {
		this.pntTxnDateType = pntTxnDateType;
	}
	
}

	
