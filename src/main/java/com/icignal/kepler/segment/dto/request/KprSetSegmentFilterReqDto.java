package com.icignal.kepler.segment.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 필터 RequestDTO
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class KprSetSegmentFilterReqDto extends CommonDataAuthReqDto {
    private String dataStatus;      //데이터 상태
    
    private String segFilterId;     //필터 아이디
    private String filterTypeCode;  //필터유형코드
    private String atribGroupColId;     //어트리뷰트그룹컬럼 아이디
    private String groupFuncTypeCode;   //그룹함수유형코드
    private String operatCode;          //연산자코드
    private String filterValue;         //필터 값
    private String andValue;         //필터 and 값
    private String groupFuncDtl;        //그룹함수 상세
    private String combFilterAId;       //조합필터A 아이디
    private String combFilterBId;       //조합필터B 아이디
    private String count;               //건수
    private String filterSqlCount;      //필터Sql 건수
    private String offSetX;             //x좌표
    private String offSetY;             //y좌표
    private String segmentId;           //세그먼트아이디
    private String flag;        //삭제여부
    private String logicalCompId;       //로지컬컴포넌트 아이디
    private String firstFlag;       //첫번째 여부
    private String filterSql;       //필터Sql
    private String segmentTypeCode;     //세그먼트 유형 코드
    
    private String oriSegFilterId;     //필터 아이디

    private List<KprSetSegmentFilterRelReqDto> filterRelList;   //필터 관계 목록
    private List<KprSetSegmentFilterReqDto> filterList;         //필터 목록
    
    private List<String> filterValueList;	//필터값 목록
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getFilterTypeCode() {
        return filterTypeCode;
    }

    public void setFilterTypeCode(String filterTypeCode) {
        this.filterTypeCode = filterTypeCode;
    }

    public String getAtribGroupColId() {
        return atribGroupColId;
    }

    public void setAtribGroupColId(String atribGroupColId) {
        this.atribGroupColId = atribGroupColId;
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

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
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

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public List<KprSetSegmentFilterRelReqDto> getFilterRelList() {
        return filterRelList;
    }

    public void setFilterRelList(List<KprSetSegmentFilterRelReqDto> filterRelList) {
        this.filterRelList = filterRelList;
    }

    public String getFirstFlag() {
        return firstFlag;
    }

    public void setFirstFlag(String firstFlag) {
        this.firstFlag = firstFlag;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getAndValue() {
        return andValue;
    }

    public void setAndValue(String andValue) {
        this.andValue = andValue;
    }

    public String getOriSegFilterId() {
        return oriSegFilterId;
    }

    public void setOriSegFilterId(String oriSegFilterId) {
        this.oriSegFilterId = oriSegFilterId;
    }

    public String getSegmentTypeCode() {
        return segmentTypeCode;
    }

    public void setSegmentTypeCode(String segmentTypeCode) {
        this.segmentTypeCode = segmentTypeCode;
    }

    public List<KprSetSegmentFilterReqDto> getFilterList() {
        return filterList;
    }

    public void setFilterList(List<KprSetSegmentFilterReqDto> filterList) {
        this.filterList = filterList;
    }

	public List<String> getFilterValueList() {
		return filterValueList;
	}

	public void setFilterValueList(List<String> filterValueList) {
		this.filterValueList = filterValueList;
	}

}
