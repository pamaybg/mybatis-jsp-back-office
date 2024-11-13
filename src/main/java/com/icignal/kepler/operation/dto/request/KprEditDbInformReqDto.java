package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : DB정보 수정 RequestDTO
 */
public class KprEditDbInformReqDto extends CommonDataAuthReqDto {
	
    private String dbInformId;    //DB정보 아이디
    private String accountId;   //어카운트 아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자
    
	private String serviceNm; //서비스명
	private String conIp; //접속 IP
	private String conPort; //접속 PORT
	private String conId; //접속 ID
	private String conPw; //접속 PW
	private String conUrl; //접속 URL
	private String dbDesc; //설명
	private String pwFlag; //
	private String secretNm; //비밀명
	private boolean pwChk;
	public String getPwFlag() {
		return pwFlag;
	}
	public void setPwFlag(String pwFlag) {
		this.pwFlag = pwFlag;
	}
	public boolean isPwChk() {
		return pwChk;
	}
	public void setPwChk(boolean pwChk) {
		this.pwChk = pwChk;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
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
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public String getDbDesc() {
		return dbDesc;
	}
	public void setDbDesc(String dbDesc) {
		this.dbDesc = dbDesc;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
    
}
