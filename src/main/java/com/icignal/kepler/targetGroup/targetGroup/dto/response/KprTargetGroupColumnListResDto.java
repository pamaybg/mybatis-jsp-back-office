package com.icignal.kepler.targetGroup.targetGroup.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 컬럼 목록 목록 ResponseDTO
 */
public class KprTargetGroupColumnListResDto extends GridPagingItemResDto {
	
    private String targetGroupId;       //타겟그룹 아이디
    private String atribGroupColId;     //어트리뷰트그룹 컬럼 아이디
    private String segFilterId;         //세그먼트 필터 아이디
    private String aliasColumnName;     //alias 컬럼명
    private String columnName;          //컬럼명
    private String displayName;         //표시명
    private String targetGroupColUseFlag;   //타겟그룹컬럼 사용여부
    private String targetGroupColId;     //타겟그룹 컬럼 아이디
    private String tgtGroupCondId;      //타겟그룹 조회시 사용 컬럼 ID
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getTargetGroupColUseFlag() {
        return targetGroupColUseFlag;
    }

    public void setTargetGroupColUseFlag(String targetGroupColUseFlag) {
        this.targetGroupColUseFlag = targetGroupColUseFlag;
    }

    public String getTargetGroupColId() {
        return targetGroupColId;
    }

    public void setTargetGroupColId(String targetGroupColId) {
        this.targetGroupColId = targetGroupColId;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getAliasColumnName() {
        return aliasColumnName;
    }

    public void setAliasColumnName(String aliasColumnName) {
        this.aliasColumnName = aliasColumnName;
    }

    public String getTgtGroupCondId() {
        return tgtGroupCondId;
    }

    public void setTgtGroupCondId(String tgtGroupCondId) {
        this.tgtGroupCondId = tgtGroupCondId;
    }
}
