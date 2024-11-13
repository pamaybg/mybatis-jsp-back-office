package com.icignal.external.aws.dto.request;

import java.util.List;

public class AwsSesManagerReqDto{
    private String textHtml;
    private String text;
    private String subject;
    private String sender;
    private String receiver;
    private List<String> receivers; //개인화에서 사용하지않음
    private String senderName;      //SMTP 발신자명

    private String tempNm;          //템플릿명 유일한값
    private String replaceData;     //JSON
    private String defaultData;     //JSON
    
    private String senderAddrName;
    private String senderAddr;
    
    private List<AwsSesManagerReqDto> personalData; //개인화정보 receiver,replaceData를 리스트로

    
    
    public String getSenderAddrName() {
		return senderAddrName;
	}

	public void setSenderAddrName(String senderAddrName) {
		this.senderAddrName = senderAddrName;
	}

	public String getSenderAddr() {
		return senderAddr;
	}

	public void setSenderAddr(String senderAddr) {
		this.senderAddr = senderAddr;
	}

	public List<AwsSesManagerReqDto> getPersonalData() {
        return personalData;
    }

    public void setPersonalData(List<AwsSesManagerReqDto> personalData) {
        this.personalData = personalData;
    }

    public String getDefaultData() {
        return defaultData;
    }

    public void setDefaultData(String defaultData) {
        this.defaultData = defaultData;
    }

    public String getReplaceData() {
        return replaceData;
    }

    public void setReplaceData(String replaceData) {
        this.replaceData = replaceData;
    }

    public String getTempNm() {
        return tempNm;
    }

    public void setTempNm(String tempNm) {
        this.tempNm = tempNm;
    }

    private List<AwsSesManagerReqDto> perInfo;   //개인화 정보

    public List<AwsSesManagerReqDto> getPerInfo() {
        return perInfo;
    }

    public void setPerInfo(List<AwsSesManagerReqDto> perInfo) {
        this.perInfo = perInfo;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public List<String> getReceivers() {
        return receivers;
    }

    public void setReceivers(List<String> receivers) {
        this.receivers = receivers;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getTextHtml() {
        return textHtml;
    }

    public void setTextHtml(String textHtml) {
        this.textHtml = textHtml;
    }
}
