package com.icignal.kepler.segment.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 상세 ResponseDTO
 */
public class KprSegmentDetailResDto extends GridPagingItemResDto {
	
    private String segmentId;       //세그먼트 아이디
    private String logicalCompId;   //로지컬컴포넌트 아이디
    private String logicalCompName; //로지컬컴포넌트명
    private String segmentName;     //세그먼트명
    private String segmentDesc;     //세그먼트 설명
    
    private List<KprSegmentFilterListResDto>   filterList;
    private List<KprSegmentFilterRelListResDto>   filterRelList;

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getSegmentDesc() {
        return segmentDesc;
    }

    public void setSegmentDesc(String segmentDesc) {
        this.segmentDesc = segmentDesc;
    }

    public List<KprSegmentFilterListResDto> getFilterList() {
        return filterList;
    }

    public void setFilterList(List<KprSegmentFilterListResDto> filterList) {
        this.filterList = filterList;
    }

    public List<KprSegmentFilterRelListResDto> getFilterRelList() {
        return filterRelList;
    }

    public void setFilterRelList(List<KprSegmentFilterRelListResDto> filterRelList) {
        this.filterRelList = filterRelList;
    }

    public String getSegmentName() {
        return segmentName;
    }

    public void setSegmentName(String segmentName) {
        this.segmentName = segmentName;
    }

    public String getLogicalCompName() {
        return logicalCompName;
    }

    public void setLogicalCompName(String logicalCompName) {
        this.logicalCompName = logicalCompName;
    }


}
