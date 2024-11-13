package com.icignal.kepler.segment.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 목록 ResponseDTO
 */
public class KprSegmentListResDto extends GridPagingItemResDto {
	
    private String segmentId;     //아이디
    private String createByName;     //생성자명
    private String createDate;     //생성일시
    
    private String segmentName;     //세그먼트명
    private String segmentDesc;     //세그먼트
    private String logicalCompId;  //로지컬 컴포넌트 아이디
    private String logicalCompName; //로지컬 컴포넌트명
    private String segTypeCd;
    private String lgcDesc;
    
    
    public String getLgcDesc() {
		return lgcDesc;
	}

	public void setLgcDesc(String lgcDesc) {
		this.lgcDesc = lgcDesc;
	}

	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getCreateDate() {
        return createDate;
    }


    public void setCreateDate(String createDate) {
        this.createDate = createDate;
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

    public String getLogicalCompName() {
        return logicalCompName;
    }

    public void setLogicalCompName(String logicalCompName) {
        this.logicalCompName = logicalCompName;
    }

    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

	public String getSegTypeCd() {
		return segTypeCd;
	}

	public void setSegTypeCd(String segTypeCd) {
		this.segTypeCd = segTypeCd;
	}




}
