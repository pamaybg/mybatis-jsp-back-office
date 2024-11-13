package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 필터 목록 ResponseDTO
 */
public class KprSegmentFilterRelListResDto extends GridPagingItemResDto {
	
    private String segFilterRelId;      //세그먼트 필터 아이디
    private String childFilterId;       //하위필터 아이디
    private String segFilterId;         //세그먼트 필터 아이디
    
    public String getSegFilterRelId() {
        return segFilterRelId;
    }
    
    public void setSegFilterRelId(String segFilterRelId) {
        this.segFilterRelId = segFilterRelId;
    }

    public String getChildFilterId() {
        return childFilterId;
    }

    public void setChildFilterId(String childFilterId) {
        this.childFilterId = childFilterId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

}
