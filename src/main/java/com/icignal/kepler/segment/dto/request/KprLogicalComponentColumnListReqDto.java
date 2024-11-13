package com.icignal.kepler.segment.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 로지컬 컴포넌트 컬럼 목록 ResponseDTO
 */
public class KprLogicalComponentColumnListReqDto extends CommonDataAuthReqDto {
	
    private String logicalCompId;       //로지컬컴포넌트 아이디
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }


}
