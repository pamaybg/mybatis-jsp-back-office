package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : VOCGetActyHistoryListResponseDTO.java
 * @date : 2017. 10. 17.
 * @author : jun.lee
 * @description : 활동내역 목록 조회
 */
public class VocGetActyHistoryListResDto extends GridPagingItemResDto {

	private String rid;
	private String atvyType;
	private String sbst;
	private String actCreatedDt;
	private String cuserId;
	private String cuserName;
	private String emailTrmDt;
	private String sendDt;
	private String smsRpyDt;
	private String smsRpyYn;
	private String smsRpyMsg;

	private String chnlSendDt;
	private String chnlRpyRsn;
	private String chnlRpyDt;
	private String atvyTypeCd;
	private String msgSubject;


	public String getChnlSendDt() {
		return chnlSendDt;
	}
	public void setChnlSendDt(String chnlSendDt) {
		this.chnlSendDt = chnlSendDt;
	}
	public String getChnlRpyRsn() {
		return chnlRpyRsn;
	}
	public void setChnlRpyRsn(String chnlRpyRsn) {
		this.chnlRpyRsn = chnlRpyRsn;
	}
	public String getChnlRpyDt() {
		return chnlRpyDt;
	}
	public void setChnlRpyDt(String chnlRpyDt) {
		this.chnlRpyDt = chnlRpyDt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAtvyType() {
		return atvyType;
	}
	public void setAtvyType(String atvyType) {
		this.atvyType = atvyType;
	}
	public String getSbst() {
		return sbst;
	}
	public void setSbst(String sbst) {
		this.sbst = sbst;
	}
	public String getActCreatedDt() {
		return actCreatedDt;
	}
	public void setActCreatedDt(String actCreatedDt) {
		this.actCreatedDt = actCreatedDt;
	}
	public String getCuserId() {
		return cuserId;
	}
	public void setCuserId(String cuserId) {
		this.cuserId = cuserId;
	}
	public String getEmailTrmDt() {
		return emailTrmDt;
	}
	public void setEmailTrmDt(String emailTrmDt) {
		this.emailTrmDt = emailTrmDt;
	}
	public String getSendDt() {
		return sendDt;
	}
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
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
	public String getSmsRpyMsg() {
		return smsRpyMsg;
	}
	public void setSmsRpyMsg(String smsRpyMsg) {
		this.smsRpyMsg = smsRpyMsg;
	}
	public String getCuserName() {
		return cuserName;
	}
	public void setCuserName(String cuserName) {
		this.cuserName = cuserName;
	}
	/**
	* @return the atvyTypeCd
	*/
	public String getAtvyTypeCd() {
		return atvyTypeCd;
	}
	/**
	* @param atvyTypeCd the atvyTypeCd to set
	*/
	public void setAtvyTypeCd(String atvyTypeCd) {
		this.atvyTypeCd = atvyTypeCd;
	}
	public String getMsgSubject() {
		return msgSubject;
	}
	public void setMsgSubject(String msgSubject) {
		this.msgSubject = msgSubject;
	}

}