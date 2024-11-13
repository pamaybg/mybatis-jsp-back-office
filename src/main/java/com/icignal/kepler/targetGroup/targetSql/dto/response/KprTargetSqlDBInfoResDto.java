package com.icignal.kepler.targetGroup.targetSql.dto.response;

/**
 * 대상자 쿼리 DB 정보 조회 Response DTO
 *
 * @name : infavor.kepler.targetGroup.dto.response.KPRTargetSqlDBInfoResponseDTO
 * @date : 2018. 4. 11.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlDBInfoResDto {

    private String dbId;
    private String conIp;
    private String conPort;
    private String conId;
    private String conPassword;
    private String conUrl;
    private String conDbType;
    private String conDbClass;
    private String filterSql;
    private String serviceNm;
    private String secretNm;

    public String getServiceNm() {
        return serviceNm;
    }
    public void setServiceNm(String serviceNm) {
        this.serviceNm = serviceNm;
    }
    public String getFilterSql() {
        return filterSql;
    }
    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
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
    public String getConUrl() {
        return conUrl;
    }
    public void setConUrl(String conUrl) {
        this.conUrl = conUrl;
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
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

}
