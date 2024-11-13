package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRCommonLogicalComponentListRequestDTO
 * 2. 파일명	: KPRCommonLogicalComponentListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2016. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *		세그먼트 로지컬 컴포넌트 목록 RequestDTO
 * </PRE>
 */ 
public class KprCommonLogicalComponentListReqDto extends CommonDataAuthReqDto {
    
    private boolean segmentFlag;

    public boolean isSegmentFlag() {
        return segmentFlag;
    }

    public void setSegmentFlag(boolean segmentFlag) {
        this.segmentFlag = segmentFlag;
    }

	
}
