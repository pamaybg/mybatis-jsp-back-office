package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : DB등록 목록 RequestDTO
 */
public class KprDbRegistReqDto extends CommonDataAuthReqDto {
	
	private String dbInformId;					//DB정보 아이디
	private String accntId; 						//어카운트 아이디
	private String serviceNm; 					//서비스명
	private String conIp; 					//접속IP
	private String conPort; 					//접속PORT
	private List<String> dbInformId1;		//DB정보 아이디
	private String secretNm;			//비밀명

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
	public List<String> getDbInformId1() {
		return dbInformId1;
	}
	public void setDbInformId1(List<String> dbInformId1) {
		this.dbInformId1 = dbInformId1;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
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
