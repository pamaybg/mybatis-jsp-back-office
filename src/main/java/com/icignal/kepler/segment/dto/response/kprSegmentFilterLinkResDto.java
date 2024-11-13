package com.icignal.kepler.segment.dto.response;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class kprSegmentFilterLinkResDto extends CommonDataAuthReqDto {

    private String oriSegFilterRelId;
    private String segFilterRelId;
    private String oriSegFilterId;
    private String segFilterId;
    private String oriChildFilterId;
    private String childFilterId;
    private String oriCombFilterAId;
    private String combFilterAId;
    private String oriCombFilterBId;
    private String combFilterBId;
    private String oriSegmentId;
    private String segmentId;


    public String getOriSegFilterRelId() {
        return oriSegFilterRelId;
    }

    public void setOriSegFilterRelId(String oriSegFilterRelId) {
        this.oriSegFilterRelId = oriSegFilterRelId;
    }

    public String getSegFilterRelId() {
        return segFilterRelId;
    }

    public void setSegFilterRelId(String segFilterRelId) {
        this.segFilterRelId = segFilterRelId;
    }

    public String getOriSegFilterId() {
        return oriSegFilterId;
    }

    public void setOriSegFilterId(String oriSegFilterId) {
        this.oriSegFilterId = oriSegFilterId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getOriChildFilterId() {
        return oriChildFilterId;
    }

    public void setOriChildFilterId(String oriChildFilterId) {
        this.oriChildFilterId = oriChildFilterId;
    }

    public String getChildFilterId() {
        return childFilterId;
    }

    public void setChildFilterId(String childFilterId) {
        this.childFilterId = childFilterId;
    }

    public String getOriCombFilterAId() {
        return oriCombFilterAId;
    }

    public void setOriCombFilterAId(String oriCombFilterAId) {
        this.oriCombFilterAId = oriCombFilterAId;
    }

    public String getCombFilterAId() {
        return combFilterAId;
    }

    public void setCombFilterAId(String combFilterAId) {
        this.combFilterAId = combFilterAId;
    }

    public String getOriCombFilterBId() {
        return oriCombFilterBId;
    }

    public void setOriCombFilterBId(String oriCombFilterBId) {
        this.oriCombFilterBId = oriCombFilterBId;
    }

    public String getCombFilterBId() {
        return combFilterBId;
    }

    public void setCombFilterBId(String combFilterBId) {
        this.combFilterBId = combFilterBId;
    }

    public String getOriSegmentId() {
        return oriSegmentId;
    }

    public void setOriSegmentId(String oriSegmentId) {
        this.oriSegmentId = oriSegmentId;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }
}
