package com.icignal.kepler.targetGroup.targetSql.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * SQL쿼리 검증 Request DTO
 *
 * @name : infavor.kepler.targetGroup.dto.request.KPRTargetSqlValidationRequestDTO
 * @date : 2018. 4. 13.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlValidationReqDto extends CommonDataAuthReqDto {

    private String dbId;
    private String filterSql;
    private String cafe24Yn;
    

    public String getDbId() {
        return dbId;
    }
    public void setDbId(String dbId) {
        this.dbId = dbId;
    }
    public String getFilterSql() {
        return filterSql;
    }
    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }
	public String getCafe24Yn() {
		return cafe24Yn;
	}
	public void setCafe24Yn(String cafe24Yn) {
		this.cafe24Yn = cafe24Yn;
	}

}
