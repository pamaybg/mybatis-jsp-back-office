package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : DB등록 목록 ResponseDTO
 */
public class KprDbRegistResDto extends StatusResDto {
	
    private String dbInformId;     //아이디
    private String createByName;     //생성자명
    private String createDate;     //생성일시
    private String serviceNm;     	//서비스명
    private String conDbType;    //DB유형
    private String conIp;  			//접속IP
    private String conPort; 		//접속PORT
    private String conId; 			//접속ID
    private String conPw; 			//접속PW
    private String conUrl; 			//접속URL
    private String dbDesc; 			//설명

    private String delFlag; 			//설명

    private int  cnt; 			//중복 카운터
    
    private String secretNm; //AWS 시크릿매니저 비밀명
    

	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getConDbType() {
		return conDbType;
	}
	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
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
