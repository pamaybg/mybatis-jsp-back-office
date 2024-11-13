package com.icignal.kepler.operation.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : DB정보관리 목록 ResponseDTO
 */
public class KprOperationListResDto extends GridPagingItemResDto {

	private String dbInformId; // 아이디
	private String createByName; // 생성자명
	private String createDate; // 생성일시
	private String serviceNm; // 서비스명
	private String conDbType; // DB유형
	private String conDbTypeName; // DB유형 Mart Name
	private String conIp; // 접속IP
	private String conPort; // 접속PORT
	private String conId; // 접속ID
	private String conUrl; // 접속URL
	private String conPw; // 접속pw
	private String dbDesc; // 설명
	private String conDbClass; // 설명
	private String secretNm;	//비밀명
	
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

	public String getServiceNm() {
		return serviceNm;
	}

	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}

	public String getConDbType() {
		return conDbType;
	}

	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
	}

	public String getConDbTypeName() {
		return conDbTypeName;
	}

	public void setConDbTypeName(String conDbTypeName) {
		this.conDbTypeName = conDbTypeName;
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

	public String getConUrl() {
		return conUrl;
	}

	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}

	public String getConPw() {
		return conPw;
	}

	public void setConPw(String conPw) {
		this.conPw = conPw;
	}

	public String getDbDesc() {
		return dbDesc;
	}

	public void setDbDesc(String dbDesc) {
		this.dbDesc = dbDesc;
	}

	public String getConDbClass() {
		return conDbClass;
	}

	public void setConDbClass(String conDbClass) {
		this.conDbClass = conDbClass;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
}