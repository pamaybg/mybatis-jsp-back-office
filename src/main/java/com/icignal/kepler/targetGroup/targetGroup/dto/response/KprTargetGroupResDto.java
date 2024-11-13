package com.icignal.kepler.targetGroup.targetGroup.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 ResponseDTO
 */
public class KprTargetGroupResDto extends GridPagingItemResDto {

    private String targetGroupId;       //타겟그룹 아이디
    private String createByName;        //등록자명
    private String segFilterId;         //필터 아이디
    private String filterSql;           //필터 SQL
    private String filterSqlCount;      //핕터 SQL Count
    private String targetGroupName;     //타겟그룹명
    private String targetGroupDesc;     //타겟그룹 설명
    private String comprGroupTypeCode;  //비교군유형코드
    private String comprGroupTypeName;  //비교군유형명
    private String comprGroupDtl;       //비교군상세
    private String dpCond;              //조건
    private String targetCount;         //대상수
    private String segmentId;           // 세그먼트 아이디
    private String conDbType;           // 데이터베이스 유형
    private String impFileNm;
    private String extrYn;				//비회원여부
    private String ridMbr;
    private String custTypeCd;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getConDbType() {
        return conDbType;
    }

    public void setConDbType(String conDbType) {
        this.conDbType = conDbType;
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getTargetGroupName() {
        return targetGroupName;
    }

    public void setTargetGroupName(String targetGroupName) {
        this.targetGroupName = targetGroupName;
    }

    public String getTargetGroupDesc() {
        return targetGroupDesc;
    }

    public void setTargetGroupDesc(String targetGroupDesc) {
        this.targetGroupDesc = targetGroupDesc;
    }

    public String getComprGroupTypeCode() {
        return comprGroupTypeCode;
    }

    public void setComprGroupTypeCode(String comprGroupTypeCode) {
        this.comprGroupTypeCode = comprGroupTypeCode;
    }

    public String getComprGroupTypeName() {
        return comprGroupTypeName;
    }

    public void setComprGroupTypeName(String comprGroupTypeName) {
        this.comprGroupTypeName = comprGroupTypeName;
    }

    public String getComprGroupDtl() {
        return comprGroupDtl;
    }

    public void setComprGroupDtl(String comprGroupDtl) {
        this.comprGroupDtl = comprGroupDtl;
    }

    public String getDpCond() {
        return dpCond;
    }

    public void setDpCond(String dpCond) {
        this.dpCond = dpCond;
    }

    public String getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(String targetCount) {
        this.targetCount = targetCount;
    }

    public String getFilterSqlCount() {
        return filterSqlCount;
    }

    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

	public String getImpFileNm() {
		return impFileNm;
	}

	public void setImpFileNm(String impFileNm) {
		this.impFileNm = impFileNm;
	}

	public String getExtrYn() {
		return extrYn;
	}

	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}

    public String getRidMbr() {return ridMbr;}

    public void setRidMbr(String ridMbr) {this.ridMbr = ridMbr;}

    public String getCustTypeCd() {return custTypeCd;}

    public void setCustTypeCd(String custTypeCd) {this.custTypeCd = custTypeCd;}
}
