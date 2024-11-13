package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 로지컬 컴포넌트 세그먼트 키, SQL ResponseDTO
 */
public class KprLogicalComponentSegKeyAndSqlResDto extends GridPagingItemResDto {
	
    private String keyColumn;   //키 컬럼
    private String lgcSql;  //로지컬 컴포넌트 sql

    public String getKeyColumn() {
        return keyColumn;
    }

    public void setKeyColumn(String keyColumn) {
        this.keyColumn = keyColumn;
    }

	public String getLgcSql() {
		return lgcSql;
	}

	public void setLgcSql(String lgcSql) {
		this.lgcSql = lgcSql;
	}
	
}
