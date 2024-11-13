package com.icignal.kepler.segment.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 로지컬컴포넌트 컬럼 목록 ResponseDTO
 */
public class KprLogicalComponentColumnListResDto extends GridPagingItemResDto {
	
    private String columnName;      //컬럼명
    private String displayName;     //표시명
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }



}
