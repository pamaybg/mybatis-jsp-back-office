package com.icignal.systemmanagement.channel.dto.request;

import java.sql.Date;

import com.icignal.common.base.dto.request.CommonCondReqDto;


/**
 * @name : MKTChannelRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemChannelInsertReqDto extends CommonCondReqDto{
	private String id;             //아이디
	private String type;           //유형
	private String chnlName;       //채널명
	private String commStatus;     //상태
	private String accountId;      //Account ID
	private Date applyStrDate;     //적용시작일자
	private Date applyEndDate;     //적용종료일자
	private String conId;          //접속ID
	private String conPw;          //접속암호
	private String conIp;          //접속IP
	private String conPort;        //접속PORT
	private String conUrl;         //접속 웹페이지/API
	private String description;    //설명
	private String memId;          //접속 ID
	private String ucost;          //가격;
	private String chnlTypeCd;     //마케팅 실행 채널 유형
	private String ptraccntId;	   //파트너 업체 아이디
	private String dbtype;         //DB타입
	private boolean passwordChk;
	private String chnlGuide;	   //채널 가이드
	private String secretNm;	   //aws 시큐리티명
	private String serviceNm;	   //서비스명
	
	private String sendableStartTime;  //발송가능 시작시간
	private String sendableEndTime;    //발송가능 종료시간 
	
	public String getSendableStartTime() {
        return sendableStartTime;
    }
    public void setSendableStartTime(String sendableStartTime) {
        this.sendableStartTime = sendableStartTime;
    }
    public String getSendableEndTime() {
        return sendableEndTime;
    }
    public void setSendableEndTime(String sendableEndTime) {
        this.sendableEndTime = sendableEndTime;
    }
    public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getChnlName() {
		return chnlName;
	}
	public void setChnlName(String chnlName) {
		this.chnlName = chnlName;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getCommStatus() {
		return commStatus;
	}
	public void setCommStatus(String commStatus) {
		this.commStatus = commStatus;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public Date getApplyStrDate() {
		return applyStrDate;
	}
	public void setApplyStrDate(Date applyStrDate) {
		this.applyStrDate = applyStrDate;
	}
	public Date getApplyEndDate() {
		return applyEndDate;
	}
	public void setApplyEndDate(Date applyEndDate) {
		this.applyEndDate = applyEndDate;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getConPw() {
		return conPw;
	}
	public void setConPw(String conPw) {
		this.conPw = conPw;
	}
	public String getConIp() {
		return conIp;
	}
	public void setConIp(String conIp) {
		this.conIp = conIp;
	}
	public String getConPort() {
		return conPort;
	}
	public void setConPort(String conPort) {
		this.conPort = conPort;
	}
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUcost() {
		return ucost;
	}
	public void setUcost(String ucost) {
		this.ucost = ucost;
	}
	public String getPtraccntId() {
		return ptraccntId;
	}
	public void setPtraccntId(String ptraccntId) {
		this.ptraccntId = ptraccntId;
	}
	public String getDbtype() {
		return dbtype;
	}
	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}
	public boolean isPasswordChk() {
		return passwordChk;
	}
	public void setPasswordChk(boolean passwordChk) {
		this.passwordChk = passwordChk;
	}
	public String getChnlGuide() {
		return chnlGuide;
	}
	public void setChnlGuide(String chnlGuide) {
		this.chnlGuide = chnlGuide;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
}
