package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 상세 RequestDTO
 */
public class KprSegmentDetailReqDto extends CommonDataAuthReqDto {
	
    private String segmentId;   //세그먼트 아이디

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }
	
}
