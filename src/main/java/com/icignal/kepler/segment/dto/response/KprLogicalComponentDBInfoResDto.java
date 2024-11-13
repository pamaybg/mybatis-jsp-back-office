package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 로지컬 컴포넌트 DB 정보
 */
public class KprLogicalComponentDBInfoResDto extends GridPagingItemResDto {
	
	private String dbId;          //db아이디
	private String conIp;         //접속 ip
	private String conPort;       //접속포트
	private String conId;         //접속아이디
	private String conPassword;   //접속비밀번호
	private String conDbType;     //접속Db유형
	private String conDbClass;    //접속Db class
	private String conUrl;        //접속url
	private String secretNm;	  //비밀명
	
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

    public String getDbId() {
        return dbId;
    }

    public void setDbId(String dbId) {
        this.dbId = dbId;
    }

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	


}
