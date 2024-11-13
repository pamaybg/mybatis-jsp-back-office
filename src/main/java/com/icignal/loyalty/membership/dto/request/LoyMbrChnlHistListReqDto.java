package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrChnlHistListReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String atvySubType;
	private String acdCallDuration;
	private String cuserId;
	private String callId;
	private String emailTrmDt;
	private String emailOpenDt;
	private String emailTrmFailRsn;
	private String smsRpyDt;
	private String smsRpyYn;
	private String smsRpyFailRsn;
	private String comments;
	private String pushType;
	private String pushAlarmType;
	private String msgTitle;
	private String msgContent;
	private String sendStatus;
	private String sendDt;
	private String ridCam;
	private String smsRpyMsg;
	private String smsStage;
	private String msgType;
	private String smsTrmDt;
	private String creatorLogin;

	private String atvyType         ;
	private String ridCust          ;
	private String ivrSvcType       ;
	private String ridSvcreq        ;
	private String actCreatedDt     ;
	private String smsRpyCd         ;
	private String msgSubject;

	private String chnlType;
	public String getAtvySubType() {
		return atvySubType;
	}
	public void setAtvySubType(String atvySubType) {
		this.atvySubType = atvySubType;
	}
	public String getAcdCallDuration() {
		return acdCallDuration;
	}
	public void setAcdCallDuration(String acdCallDuration) {
		this.acdCallDuration = acdCallDuration;
	}
	public String getCuserId() {
		return cuserId;
	}
	public void setCuserId(String cuserId) {
		this.cuserId = cuserId;
	}
	public String getCallId() {
		return callId;
	}
	public void setCallId(String callId) {
		this.callId = callId;
	}
	public String getEmailTrmDt() {
		return emailTrmDt;
	}
	public void setEmailTrmDt(String emailTrmDt) {
		this.emailTrmDt = emailTrmDt;
	}
	public String getEmailOpenDt() {
		return emailOpenDt;
	}
	public void setEmailOpenDt(String emailOpenDt) {
		this.emailOpenDt = emailOpenDt;
	}
	public String getEmailTrmFailRsn() {
		return emailTrmFailRsn;
	}
	public void setEmailTrmFailRsn(String emailTrmFailRsn) {
		this.emailTrmFailRsn = emailTrmFailRsn;
	}
	public String getSmsRpyDt() {
		return smsRpyDt;
	}
	public void setSmsRpyDt(String smsRpyDt) {
		this.smsRpyDt = smsRpyDt;
	}
	public String getSmsRpyYn() {
		return smsRpyYn;
	}
	public void setSmsRpyYn(String smsRpyYn) {
		this.smsRpyYn = smsRpyYn;
	}
	public String getSmsRpyFailRsn() {
		return smsRpyFailRsn;
	}
	public void setSmsRpyFailRsn(String smsRpyFailRsn) {
		this.smsRpyFailRsn = smsRpyFailRsn;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getPushType() {
		return pushType;
	}
	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
	public String getPushAlarmType() {
		return pushAlarmType;
	}
	public void setPushAlarmType(String pushAlarmType) {
		this.pushAlarmType = pushAlarmType;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}
	public String getSendDt() {
		return sendDt;
	}
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}
	public String getRidCam() {
		return ridCam;
	}
	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}
	public String getSmsRpyMsg() {
		return smsRpyMsg;
	}
	public void setSmsRpyMsg(String smsRpyMsg) {
		this.smsRpyMsg = smsRpyMsg;
	}
	public String getSmsStage() {
		return smsStage;
	}
	public void setSmsStage(String smsStage) {
		this.smsStage = smsStage;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getSmsTrmDt() {
		return smsTrmDt;
	}
	public void setSmsTrmDt(String smsTrmDt) {
		this.smsTrmDt = smsTrmDt;
	}
	public String getCreatorLogin() {
		return creatorLogin;
	}
	public void setCreatorLogin(String creatorLogin) {
		this.creatorLogin = creatorLogin;
	}
	public String getAtvyType() {
		return atvyType;
	}
	public void setAtvyType(String atvyType) {
		this.atvyType = atvyType;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getIvrSvcType() {
		return ivrSvcType;
	}
	public void setIvrSvcType(String ivrSvcType) {
		this.ivrSvcType = ivrSvcType;
	}
	public String getRidSvcreq() {
		return ridSvcreq;
	}
	public void setRidSvcreq(String ridSvcreq) {
		this.ridSvcreq = ridSvcreq;
	}
	public String getActCreatedDt() {
		return actCreatedDt;
	}
	public void setActCreatedDt(String actCreatedDt) {
		this.actCreatedDt = actCreatedDt;
	}
	public String getSmsRpyCd() {
		return smsRpyCd;
	}
	public void setSmsRpyCd(String smsRpyCd) {
		this.smsRpyCd = smsRpyCd;
	}
	/**
	* @return the chnlType
	*/
	public String getChnlType() {
		return chnlType;
	}
	/**
	* @param chnlType the chnlType to set
	*/
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	/**
	* @return the msgSubject
	*/
	public String getMsgSubject() {
		return msgSubject;
	}
	/**
	* @param msgSubject the msgSubject to set
	*/
	public void setMsgSubject(String msgSubject) {
		this.msgSubject = msgSubject;
	}













}
