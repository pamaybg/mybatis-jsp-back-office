package com.icignal.kepler.segment.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 필터 목록 ResponseDTO
 */
public class KprSegmentFilterListResDto extends GridPagingItemResDto {
	
    private String segFilterId;     //세그먼트 필터 아이디
    private String segmentId;       //세그먼트 아이디
    private String atribGroupColId;     //어트리뷰트 그룹 컬럼 아이디
    private String displayName;         //표시명
    private String filterTypeCode;      //필터유형코드
    private String filterTypeName;      //필터유형명
    private String groupFuncTypeCode;   //그룹함수유형코드
    private String groupFuncTypeName;   //그룹함수유형명
    private String operatCode;          //연산자코드
    private String operatCodeName;      //연산자명
    private String filterValue;         //필터값
    private String andValue;         //필터 and 값
    private String groupFuncDtl;        //그룹함수상세
    private String combFilterAId;       //조합필터A 아이디
    private String combFilterBId;       //조합필터B 아이디
    private String filterCount;         //필터 건수
    private String filterSqlCount;      //필터SQL
    private String offSetX;             //x좌표
    private String offSetY;             //y좌표
    private String atribGroupColType;    //어트리뷰트 그룹 컬럼 유형;  D: dimension, M: Measure
    private String logicalCompId;       //로지컬컴포넌트 아이디
    private String targetGroupId;       //타겟그룹 아이디
    
    private List<String> filterValueList;	//필터값 목록

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegmentFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getFilterTypeCode() {
        return filterTypeCode;
    }

    public void setFilterTypeCode(String filterTypeCode) {
        this.filterTypeCode = filterTypeCode;
    }

    public String getFilterTypeName() {
        return filterTypeName;
    }

    public void setFilterTypeName(String filterTypeName) {
        this.filterTypeName = filterTypeName;
    }

    public String getGroupFuncTypeCode() {
        return groupFuncTypeCode;
    }

    public void setGroupFuncTypeCode(String groupFuncTypeCode) {
        this.groupFuncTypeCode = groupFuncTypeCode;
    }

    public String getOperatCode() {
        return operatCode;
    }

    public void setOperatCode(String operatCode) {
        this.operatCode = operatCode;
    }

    public String getOperatCodeName() {
        return operatCodeName;
    }

    public void setOperatCodeName(String operatCodeName) {
        this.operatCodeName = operatCodeName;
    }

    public String getFilterValue() {
        return filterValue;
    }

    public void setFilterValue(String filterValue) {
        this.filterValue = filterValue;
    }

    public String getGroupFuncDtl() {
        return groupFuncDtl;
    }

    public void setGroupFuncDtl(String groupFuncDtl) {
        this.groupFuncDtl = groupFuncDtl;
    }

    public String getCombFilterAId() {
        return combFilterAId;
    }

    public void setCombFilterAId(String combFilterAId) {
        this.combFilterAId = combFilterAId;
    }

    public String getCombFilterBId() {
        return combFilterBId;
    }

    public void setCombFilterBId(String combFilterBId) {
        this.combFilterBId = combFilterBId;
    }

    public String getFilterCount() {
        return filterCount;
    }

    public void setFilterCount(String filterCount) {
        this.filterCount = filterCount;
    }

    public String getFilterSqlCount() {
        return filterSqlCount;
    }

    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public String getOffSetX() {
        return offSetX;
    }

    public void setOffSetX(String offSetX) {
        this.offSetX = offSetX;
    }

    public String getOffSetY() {
        return offSetY;
    }

    public void setOffSetY(String offSetY) {
        this.offSetY = offSetY;
    }

    public String getAtribGroupColType() {
        return atribGroupColType;
    }

    public void setAtribGroupColType(String atribGroupColType) {
        this.atribGroupColType = atribGroupColType;
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getGroupFuncTypeName() {
        return groupFuncTypeName;
    }

    public void setGroupFuncTypeName(String groupFuncTypeName) {
        this.groupFuncTypeName = groupFuncTypeName;
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

	public List<String> getFilterValueList() {
		return filterValueList;
	}

	public void setFilterValueList(List<String> filterValueList) {
		this.filterValueList = filterValueList;
	}

	public String getAndValue() {
		return andValue;
	}

	public void setAndValue(String andValue) {
		this.andValue = andValue;
	}
    

}
