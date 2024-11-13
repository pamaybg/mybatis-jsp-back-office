package com.icignal.kepler.targetGroup.targetGroup.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 목록 ResponseDTO
 */
public class KprTargetGroupListResDto extends GridPagingItemResDto {

    private String targetGroupId;       //타겟그룹 아이디
    private String createByName;        //등록자명
    private String createDate;          //등록일시
    private String segFilterId;         //필터 아이디
    private String filterSql;           //필터 SQL
    private String targetGroupName;     //타겟그룹명
    private String targetGroupDesc;     //타겟그룹 설명
    private String comprGroupTypeCode;  //비교군유형코드
    private String comprGroupTypeName;  //비교군유형명
    private String comprGroupDtl;       //비교군상세
    private String segmentName;         //세그먼트명
    private String segmentId;           //세그먼트 아이디
    private String tgtGroupNo;           //아이디


    private String type;                //유형 구분 (IMPORT: 파일업로드 & SEGMENT:세그먼트)
    private String typeNm;              //유형명
    private String fileTypeCd;          //업로드유형
    private String fileNm;              //파일명
    private String camId;               //캠페인ID
    private String camStatusCd;         //캠페인상태

    private String extrYn;				//외부회원여부

    private String targetCount;


    public String getTgtGroupNo() {
		return tgtGroupNo;
	}

	public void setTgtGroupNo(String tgtGroupNo) {
		this.tgtGroupNo = tgtGroupNo;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public String getCamStatusCd() {
        return camStatusCd;
    }

    public void setCamStatusCd(String camStatusCd) {
        this.camStatusCd = camStatusCd;
    }

    public String getTypeNm() {
        return typeNm;
    }

    public void setTypeNm(String typeNm) {
        this.typeNm = typeNm;
    }

    public String getFileNm() {
        return fileNm;
    }

    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFileTypeCd() {
        return fileTypeCd;
    }

    public void setFileTypeCd(String fileTypeCd) {
        this.fileTypeCd = fileTypeCd;
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

    public String getSegmentName() {
        return segmentName;
    }

    public void setSegmentName(String segmentName) {
        this.segmentName = segmentName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getSegmentId() {
        return segmentId;
    }

    public void setSegmentId(String segmentId) {
        this.segmentId = segmentId;
    }

	public String getExtrYn() {
		return extrYn;
	}

	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}

    public String getTargetCount() {return targetCount;}

    public void setTargetCount(String targetCount) {this.targetCount = targetCount;}



}
