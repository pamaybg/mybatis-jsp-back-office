package com.icignal.marketing.common.eventTrigger.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNLogicalComponentInfoResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 로지컬 컴포넌트 정보
 */
public class MktLogicalComponentInfoResDto extends StatusResDto {

	private String dbId;          //db아이디
	private String conIp;         //접속 ip
	private String conPort;       //접속포트
	private String conId;         //접속아이디
	private String conPassword;   //접속비밀번호
	private String conDbType;     //접속Db유형
	private String conDbClass;    //접속Db class
	private String conUrl;        //접속url
	private String lgcSql;		   //로지컬 sql
	private String tblAliasColNm;		 //테이블 alias.컬럼명
	private String colAlias;			 //컬럼 alias
	private String awsSecretNm;
	private String id;
   
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getDbId() {
		return dbId;
	}

	public void setDbId(String dbId) {
		this.dbId = dbId;
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

	public String getConPassword() {
		return conPassword;
	}

	public void setConPassword(String conPassword) {
		this.conPassword = conPassword;
	}

	public String getConDbType() {
		return conDbType;
	}

	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
	}

	public String getConDbClass() {
		return conDbClass;
	}

	public void setConDbClass(String conDbClass) {
		this.conDbClass = conDbClass;
	}

	public String getConUrl() {
		return conUrl;
	}

	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}

	public String getLgcSql() {
		return lgcSql;
	}

	public void setLgcSql(String lgcSql) {
		this.lgcSql = lgcSql;
	}

	public String getTblAliasColNm() {
		return tblAliasColNm;
	}

	public void setTblAliasColNm(String tblAliasColNm) {
		this.tblAliasColNm = tblAliasColNm;
	}

	public String getColAlias() {
		return colAlias;
	}

	public void setColAlias(String colAlias) {
		this.colAlias = colAlias;
	}

	public String getAwsSecretNm() {
		return awsSecretNm;
	}

	public void setAwsSecretNm(String awsSecretNm) {
		this.awsSecretNm = awsSecretNm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
