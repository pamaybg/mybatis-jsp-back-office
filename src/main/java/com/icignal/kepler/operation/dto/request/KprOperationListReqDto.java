package com.icignal.kepler.operation.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : DB정보관리 목록 RequestDTO
 */
public class KprOperationListReqDto extends CommonDataAuthReqDto {
	
    private String dbInformId;   	//DB정보 아이디
	private String sqlQuery; 		//쿼리정보
	private String secretNm;		//비밀명
    public String getSqlQuery() {
		return sqlQuery;
	}

	public void setSqlQuery(String sqlQuery) {
		this.sqlQuery = sqlQuery;
	}

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
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
