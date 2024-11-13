package com.icignal.kepler.segment.dto.request;


import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 복사 RequestDTO
 */
public class KprCopySegmentReqDto extends CommonDataAuthReqDto {
	
    private String createBy;        //등록자
    private String modifyBy;        //수정자
    private String logicalCompId;   //로지컬 컴포넌트 아이디
    private String segmentId;       //세그먼트 아이디
    private String segFilterId;     //세그먼트 필터 아이디
    private String segmentTypeCode;     //세그먼트 유형 코드
    
    private String segmentType;

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getSegmentTypeCode() {
        return segmentTypeCode;
    }

    public void setSegmentTypeCode(String segmentTypeCode) {
        this.segmentTypeCode = segmentTypeCode;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

	public String getSegmentType() {
		return segmentType;
	}

	public void setSegmentType(String segmentType) {
		this.segmentType = segmentType;
	}
	
}
