package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 속성그룹 컬럼 정보 RequestDTO
 */
public class KprAttributeGroupColumnValueListResDto extends GridPagingItemResDto {
	
	private String colValue;  //값

    public String getColValue() {
        return colValue;
    }

    public void setColValue(String colValue) {
        this.colValue = colValue;
    }

}
