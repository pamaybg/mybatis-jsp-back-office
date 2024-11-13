package com.icignal.kepler.segment.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 목록 ResponseDTO
 */
public class KprSetSegmentReqDto extends CommonDataAuthReqDto {
	
    private String segmentId;    //세그먼트 아이디
    
    private String segmentName;     //세그먼트명
    private String segmentDesc;     //세그먼트
    private String logicalCompId;  //로지컬 컴포넌트 아이디
    
    private String oriSegmentId;    //세그먼트 아이
    private String segmentTypeCode;     //세그먼트 유형코드
    
    private List<KprSetSegmentFilterReqDto> filterList;         //필터 목록
    private List<KprSetSegmentFilterRelReqDto> filterRelList;   //필터 관계 목록
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getSegmentName() {
        return segmentName;
    }

    public void setSegmentName(String segmentName) {
        this.segmentName = segmentName;
    }

    public String getSegmentDesc() {
        return segmentDesc;
    }

    public void setSegmentDesc(String segmentDesc) {
        this.segmentDesc = segmentDesc;
    }

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

    public List<KprSetSegmentFilterReqDto> getFilterList() {
        return filterList;
    }

    public void setFilterList(List<KprSetSegmentFilterReqDto> filterList) {
        this.filterList = filterList;
    }

    public List<KprSetSegmentFilterRelReqDto> getFilterRelList() {
        return filterRelList;
    }

    public void setFilterRelList(List<KprSetSegmentFilterRelReqDto> filterRelList) {
        this.filterRelList = filterRelList;
    }

    public String getOriSegmentId() {
        return oriSegmentId;
    }

    public void setOriSegmentId(String oriSegmentId) {
        this.oriSegmentId = oriSegmentId;
    }

    public String getSegmentTypeCode() {
        return segmentTypeCode;
    }

    public void setSegmentTypeCode(String segmentTypeCode) {
        this.segmentTypeCode = segmentTypeCode;
    }


}
