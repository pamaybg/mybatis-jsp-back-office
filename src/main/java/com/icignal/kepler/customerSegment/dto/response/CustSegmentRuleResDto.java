package com.icignal.kepler.customerSegment.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.custSegment.dto.response
 * @date : 2020. 07. 16.
 * @author : sh.park
 * @description : 고객 세그먼트 룰 ResponseDTO
 */
public class CustSegmentRuleResDto extends GridPagingItemResDto {

    private String custSegRuleId;       //targetGroupId 타겟그룹 아이디
    private String createByName;        //등록자명
    private String createDate;          //등록일시
    private String segFilterId;         //필터 아이디
    private String filterSql;           //필터 SQL
    private String custSegRuleName;     //targetGroupName 타겟그룹명
    private String custSegRuleDesc;     //targetGroupDesc 타겟그룹 설명
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
    private String dpCond;
    private String tgtGroupId; 
    private String tgtGroupNm;
    
    public String getCustSegRuleId() {
		return custSegRuleId;
	}
	public void setCustSegRuleId(String custSegRuleId) {
		this.custSegRuleId = custSegRuleId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	public String getCustSegRuleName() {
		return custSegRuleName;
	}
	public void setCustSegRuleName(String custSegRuleName) {
		this.custSegRuleName = custSegRuleName;
	}
	public String getCustSegRuleDesc() {
		return custSegRuleDesc;
	}
	public void setCustSegRuleDesc(String custSegRuleDesc) {
		this.custSegRuleDesc = custSegRuleDesc;
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
	public String getSegmentId() {
		return segmentId;
	}
	public void setSegmentId(String segmentId) {
		this.segmentId = segmentId;
	}
	public String getTgtGroupNo() {
		return tgtGroupNo;
	}
	public void setTgtGroupNo(String tgtGroupNo) {
		this.tgtGroupNo = tgtGroupNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTypeNm() {
		return typeNm;
	}
	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}
	public String getFileTypeCd() {
		return fileTypeCd;
	}
	public void setFileTypeCd(String fileTypeCd) {
		this.fileTypeCd = fileTypeCd;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
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
	public String getTgtGroupId() {
		return tgtGroupId;
	}
	public void setTgtGroupId(String tgtGroupId) {
		this.tgtGroupId = tgtGroupId;
	}
	public String getTgtGroupNm() {
		return tgtGroupNm;
	}
	public void setTgtGroupNm(String tgtGroupNm) {
		this.tgtGroupNm = tgtGroupNm;
	}
	public String getDpCond() {
		return dpCond;
	}
	public void setDpCond(String dpCond) {
		this.dpCond = dpCond;
	}

    
    


}
