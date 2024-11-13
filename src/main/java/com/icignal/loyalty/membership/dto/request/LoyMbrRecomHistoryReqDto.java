package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrRecomHistoryReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String mbrNo;
	private String reqType;
	private String sendDt;
	private String sendTime;
	private String trNo;
	private String trDt;
	private String trTime;
	private String chnlCd;
	private String pgmNo;
	private String queryCd;
	private String queryVal;
	private String serialNo;
	private String referCd;
	private String deviceType;
	private String enrollChnl;
	private String cipherKey;
	private String chnlType;
	private String recomRid;
	
	
	public String getRecomRid() {
		return recomRid;
	}
	public void setRecomRid(String recomRid) {
		this.recomRid = recomRid;
	}
	public LoyMbrRecomHistoryReqDto() {
	 }
	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	public String getReqType() {
		return reqType;
	}

	public void setReqType(String reqType) {
		this.reqType = reqType;
	}

	public String getSendDt() {
		return sendDt;
	}

	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getTrNo() {
		return trNo;
	}

	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}

	public String getTrDt() {
		return trDt;
	}

	public void setTrDt(String trDt) {
		this.trDt = trDt;
	}

	public String getTrTime() {
		return trTime;
	}

	public void setTrTime(String trTime) {
		this.trTime = trTime;
	}

	public String getChnlCd() {
		return chnlCd;
	}

	public void setChnlCd(String chnlCd) {
		this.chnlCd = chnlCd;
	}

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	public String getQueryCd() {
		return queryCd;
	}

	public void setQueryCd(String queryCd) {
		this.queryCd = queryCd;
	}

	public String getQueryVal() {
		return queryVal;
	}

	public void setQueryVal(String queryVal) {
		this.queryVal = queryVal;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getReferCd() {
		return referCd;
	}

	public void setReferCd(String referCd) {
		this.referCd = referCd;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getEnrollChnl() {
		return enrollChnl;
	}

	public void setEnrollChnl(String enrollChnl) {
		this.enrollChnl = enrollChnl;
	}

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
}
