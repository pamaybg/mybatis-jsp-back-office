package com.icignal.kepler.segment.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 필터 관계 RequestDTO
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class KprSetCopySegmentlReqDto extends CommonDataAuthReqDto {
    
    private String dataStatus;      //데이터 상태
    private String createBy;        //생성자
    private String modifyBy;        //수정자
    
	/**
	 * 세그먼트 필터 관계
	 */
    private String segFilterRelId;  //필터 관계 아이디
    private String childFilterId;   //자식필터 아이디
    private String segFilterId;     //필터 아이디
    private String segmentId;       //세그먼트아이디
    private String flag;        //삭제여부
    private String oriSegFilterRelId;  //필터 관계 아이디
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getSegFilterRelId() {
        return segFilterRelId;
    }

    public void setSegFilterRelId(String segFilterRelId) {
        this.segFilterRelId = segFilterRelId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getChildFilterId() {
        return childFilterId;
    }

    public void setChildFilterId(String childFilterId) {
        this.childFilterId = childFilterId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

    public String getOriSegFilterRelId() {
        return oriSegFilterRelId;
    }

    public void setOriSegFilterRelId(String oriSegFilterRelId) {
        this.oriSegFilterRelId = oriSegFilterRelId;
    }

}
