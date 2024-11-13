package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 속성그룹 목록 RequestDTO
 */
public class KprAttributeGroupListReqDto extends CommonDataAuthReqDto {
	
	private String logicalCompId;  //로지컬컴포넌트 아이디

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }
}
