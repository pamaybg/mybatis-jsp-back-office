package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 건수 ResponseDTO
 */
public class KprSegmentCountResDto extends GridPagingItemResDto {
	
    private String filterSqlCount;      //필터Sql 건수
    private String filterSql;           //필터Sql
    
    public String getFilterSqlCount() {
        return filterSqlCount;
    }
    
    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }
    


}
