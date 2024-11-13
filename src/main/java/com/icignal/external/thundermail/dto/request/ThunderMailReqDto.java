package com.icignal.external.thundermail.dto.request;

import java.util.HashMap;

public class ThunderMailReqDto  {


	private String mbrNo;
	private String ridMbr;
	private String ridCust;
	private String hhpNo;
	private String callBackNo;
	private String msgType;
	private String comment;
	private String emailAddr;
	private String senderEmail;
	private String emailTitle;
	private String chnlType;
	private String creatorLogin;
	private String actionRID;
	private String ridVocReq;
	private String insertFlag;
	private String msgSubject;
	private String actyRid;
	private String mailSuppressDt;
	private String automailID;
	private String receiverName;
	private String inquiryTitle;
	private String inquiryContents;
	private String inquiryDate;
	private String answerDate;
	
	private HashMap<String, String> onetooneInfoMap;
	//썬더메일 자동메일api 치환값
	@SuppressWarnings("unused")
	private String onetooneInfo;


	
	
	public String getInquiryDate() {
		return inquiryDate;
	}
	public void setInquiryDate(String inquiryDate) {
		this.inquiryDate = inquiryDate;
	}
	public String getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}
	public String getAutomailID() {
		return automailID;
	}
	public void setAutomailID(String automailID) {
		this.automailID = automailID;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getInquiryTitle() {
		return inquiryTitle;
	}
	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}
	public String getInquiryContents() {
		return inquiryContents;
	}
	public void setInquiryContents(String inquiryContents) {
		this.inquiryContents = inquiryContents;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	/**
	* @return the creatorLogin
	*/
	public String getCreatorLogin() {
		return creatorLogin;
	}
	/**
	* @param creatorLogin the creatorLogin to set
	*/
	public void setCreatorLogin(String creatorLogin) {
		this.creatorLogin = creatorLogin;
	}

	public String getCallBackNo() {
		return callBackNo;
	}
	public void setCallBackNo(String callBackNo) {
		this.callBackNo = callBackNo;
	}
	public String getActionRID() {
		return actionRID;
	}
	public void setActionRID(String actionRID) {
		this.actionRID = actionRID;
	}

	/**
	* @return the ridVocReq
	*/
	public String getRidVocReq() {
		return ridVocReq;
	}
	/**
	* @param ridVocReq the ridVocReq to set
	*/
	public void setRidVocReq(String ridVocReq) {
		this.ridVocReq = ridVocReq;
	}
	public String getInsertFlag() {
		return insertFlag;
	}
	public void setInsertFlag(String insertFlag) {
		this.insertFlag = insertFlag;
	}
	public String getEmailTitle() {
		return emailTitle;
	}
	public void setEmailTitle(String emailTitle) {
		this.emailTitle = emailTitle;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
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
	/**
	* @return the actyRid
	*/
	public String getActyRid() {
		return actyRid;
	}
	/**
	* @param actyRid the actyRid to set
	*/
	public void setActyRid(String actyRid) {
		this.actyRid = actyRid;
	}
	/**
	* @return the mailSuppressDt
	*/
	public String getMailSuppressDt() {
		return mailSuppressDt;
	}
	/**
	* @param mailSuppressDt the mailSuppressDt to set
	*/
	public void setMailSuppressDt(String mailSuppressDt) {
		this.mailSuppressDt = mailSuppressDt;
	}
	/**
	* @programId :
	* @name : getOnetooneInfo
	* @date : 2018. 12. 5.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description : 썬더메일 자동메일api 일대일치환값 string 생성 (getOnetooneInfoMap 키밸류 기반)
	*/
	public String getOnetooneInfo() {
		
		String keySeparator = Character.toString((char)230); //변수 구분자
		String valueSeparator = Character.toString((char)208); //데이터 구분자
		
		String rtnValue = "";
		
		for(String key : onetooneInfoMap.keySet()) {
			String value = onetooneInfoMap.get(key);
			
			rtnValue += "[$" + key + "]";
			rtnValue += valueSeparator;
			rtnValue += value;
			rtnValue += keySeparator;
		}
		
		return rtnValue;
	}
	public void setOnetooneInfo(String onetooneInfo) {
		this.onetooneInfo = onetooneInfo;
	}
	public HashMap<String, String> getOnetooneInfoMap() {
		return onetooneInfoMap;
	}
	public void setOnetooneInfoMap(HashMap<String, String> onetooneInfoMap) {
		this.onetooneInfoMap = onetooneInfoMap;
	}


}
