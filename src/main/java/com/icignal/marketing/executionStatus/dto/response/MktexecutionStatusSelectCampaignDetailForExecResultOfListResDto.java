package com.icignal.marketing.executionStatus.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto extends GridPagingItemResDto {
	private String id;
	private String memId;
	private String mbrNo;
	private String ctrlGroupYn;
	private String batSendStatus;
	private String sendSucesYn;
	private String sendFailYn;
	private String readSucesYn;
	private String revSucesYn;
	private String deviceUuId;
	private String deviceAgreYn;
	private String failCode;
	private String failReason;
	private String usrId;


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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getCtrlGroupYn() {
		return ctrlGroupYn;
	}
	public void setCtrlGroupYn(String ctrlGroupYn) {
		this.ctrlGroupYn = ctrlGroupYn;
	}
	public String getBatSendStatus() {
		return batSendStatus;
	}
	public void setBatSendStatus(String batSendStatus) {
		this.batSendStatus = batSendStatus;
	}
	public String getSendSucesYn() {
		return sendSucesYn;
	}
	public void setSendSucesYn(String sendSucesYn) {
		this.sendSucesYn = sendSucesYn;
	}
	public String getSendFailYn() {
		return sendFailYn;
	}
	public void setSendFailYn(String sendFailYn) {
		this.sendFailYn = sendFailYn;
	}
	public String getReadSucesYn() {
		return readSucesYn;
	}
	public void setReadSucesYn(String readSucesYn) {
		this.readSucesYn = readSucesYn;
	}
	public String getRevSucesYn() {
		return revSucesYn;
	}
	public void setRevSucesYn(String revSucesYn) {
		this.revSucesYn = revSucesYn;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getFailCode() {
		return failCode;
	}

	public void setFailCode(String failCode) {
		this.failCode = failCode;
	}

	public String getFailReason() {
		return failReason;
	}

	public void setFailReason(String failReason) {
		this.failReason = failReason;
	}

	public String getUsrId() {
		return usrId;
	}

	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
}
