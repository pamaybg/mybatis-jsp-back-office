package com.icignal.kepler.segment.dto.request;


public class KprSegmentLcTblRelListReqDto {
	
    private String segmentId;    //세그먼트 아이디
    private String leftLgcCompTblRelId;

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getLeftLgcCompTblRelId() {
        return leftLgcCompTblRelId;
    }

    public void setLeftLgcCompTblRelId(String leftLgcCompTblRelId) {
        this.leftLgcCompTblRelId = leftLgcCompTblRelId;
    }
}
