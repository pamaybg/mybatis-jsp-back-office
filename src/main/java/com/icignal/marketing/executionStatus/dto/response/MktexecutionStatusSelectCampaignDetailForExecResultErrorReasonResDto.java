package com.icignal.marketing.executionStatus.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto extends GridPagingItemResDto {
	private String mbrNo;
	private String fatiChkRmvYn;
	private String infoUtilYn;
	private String mktUtilYn;
	private String smsConsentyn;
	private String pushConsentyn;
	private String emailConsentyn;
	private String kakaoConsentYn;
	private String hpYn;
	private String emailYn;
	private String deviceUuId;
	private String deviceAgreYn;
	
	
	public String getDeviceUuId() {
		return deviceUuId;
	}
	public void setDeviceUuId(String deviceUuId) {
		this.deviceUuId = deviceUuId;
	}
	public String getDeviceAgreYn() {
		return deviceAgreYn;
	}
	public void setDeviceAgreYn(String deviceAgreYn) {
		this.deviceAgreYn = deviceAgreYn;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getFatiChkRmvYn() {
		return fatiChkRmvYn;
	}
	public void setFatiChkRmvYn(String fatiChkRmvYn) {
		this.fatiChkRmvYn = fatiChkRmvYn;
	}
	public String getInfoUtilYn() {
		return infoUtilYn;
	}
	public void setInfoUtilYn(String infoUtilYn) {
		this.infoUtilYn = infoUtilYn;
	}
	public String getMktUtilYn() {
		return mktUtilYn;
	}
	public void setMktUtilYn(String mktUtilYn) {
		this.mktUtilYn = mktUtilYn;
	}
	public String getSmsConsentyn() {
		return smsConsentyn;
	}
	public void setSmsConsentyn(String smsConsentyn) {
		this.smsConsentyn = smsConsentyn;
	}
	public String getPushConsentyn() {
		return pushConsentyn;
	}
	public void setPushConsentyn(String pushConsentyn) {
		this.pushConsentyn = pushConsentyn;
	}
	public String getEmailConsentyn() {
		return emailConsentyn;
	}
	public void setEmailConsentyn(String emailConsentyn) {
		this.emailConsentyn = emailConsentyn;
	}
	public String getKakaoConsentYn() {
		return kakaoConsentYn;
	}
	public void setKakaoConsentYn(String kakaoConsentYn) {
		this.kakaoConsentYn = kakaoConsentYn;
	}
	public String getHpYn() {
		return hpYn;
	}
	public void setHpYn(String hpYn) {
		this.hpYn = hpYn;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	
	
}
