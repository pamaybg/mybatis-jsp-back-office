package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 컬럼 ResponseDTO
 */
public class KprSetTargetGroupColumnReqDto extends CommonDataAuthReqDto {

    private String targetGroupColId;    //타겟그룹 컬럼 아이디
    private String createBy;        //생성자
    private String modifyBy;        //수정자
    private String targetGroupId;       //타겟그룹 아이디
    private String segFilterId;     //세그먼트 필터 아이디
    private String atribGroupColId; //어트리뷰트 그룹 컬럼 아이디
    
    private String targetGroupColUseFlag;       //타겟그룹 컬럼 사용여부
    
    private List<KprSetTargetGroupColumnReqDto> targetGroupColList;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getTargetGroupColId() {
        return targetGroupColId;
    }

    public void setTargetGroupColId(String targetGroupColId) {
        this.targetGroupColId = targetGroupColId;
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

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
    }

    public String getTargetGroupColUseFlag() {
        return targetGroupColUseFlag;
    }

    public void setTargetGroupColUseFlag(String targetGroupColUseFlag) {
        this.targetGroupColUseFlag = targetGroupColUseFlag;
    }

    public List<KprSetTargetGroupColumnReqDto> getTargetGroupColList() {
        return targetGroupColList;
    }

    public void setTargetGroupColList(List<KprSetTargetGroupColumnReqDto> targetGroupColList) {
        this.targetGroupColList = targetGroupColList;
    }



}
