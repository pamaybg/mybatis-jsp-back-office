package com.icignal.kepler.logicalComponent.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDetailResponseDTO
 * 2. 파일명	: KPRLogicalComponentDetailResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인설정 > 상세 조회 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentDetailResDto extends StatusResDto {

	/**    분석 또는 세그먼트 사용여부 확인    */    private boolean  analysisSegmentUsed;
	
	/**    아이디    */    private String  lgcCompId= "";
	/**    로지컬컴포넌트명    */    private String  lgcCompNm= "";
	/**    설명    */    private String  lgcDesc= "";
	/**    로지컬컴포넌트 사용가능여부    */    private String  cmpltYn= "";
	/**    DB 서비스 ID    */    private String  dbInformId= "";
	/**    로지컬 컴포넌트 SQL    */    private String  lgcSql= "";
	
	/**    조인설정 테이블 관계 리스트    */ private List<KprLogicalComponentDetailJoinTableRelResDto> joinTableRelList;
	/**    조인설정 컬럼 리스트    */ private List<KprLogicalComponentDetailJoinColumnBaseResDto> joinColumnList;
	
	// kj.kang 추가
	private boolean segmentUsed;
	private boolean analysisUsed;
	
	
	public boolean isSegmentUsed() {
		return segmentUsed;
	}
	public void setSegmentUsed(boolean segmentUsed) {
		this.segmentUsed = segmentUsed;
	}
	public boolean isAnalysisUsed() {
		return analysisUsed;
	}
	public void setAnalysisUsed(boolean analysisUsed) {
		this.analysisUsed = analysisUsed;
	}
	public String getLgcSql() {
		return lgcSql;
	}
	public void setLgcSql(String lgcSql) {
		this.lgcSql = lgcSql;
	}
	public boolean isAnalysisSegmentUsed() {
		return analysisSegmentUsed;
	}
	public void setAnalysisSegmentUsed(boolean analysisSegmentUsed) {
		this.analysisSegmentUsed = analysisSegmentUsed;
	}
	public String getLgcCompId() {
		return lgcCompId;
	}
	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}
	public String getLgcCompNm() {
		return lgcCompNm;
	}
	public void setLgcCompNm(String lgcCompNm) {
		this.lgcCompNm = lgcCompNm;
	}
	public String getLgcDesc() {
		return lgcDesc;
	}
	public void setLgcDesc(String lgcDesc) {
		this.lgcDesc = lgcDesc;
	}
	public String getCmpltYn() {
		return cmpltYn;
	}
	public void setCmpltYn(String cmpltYn) {
		this.cmpltYn = cmpltYn;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public List<KprLogicalComponentDetailJoinTableRelResDto> getJoinTableRelList() {
		return joinTableRelList;
	}
	public void setJoinTableRelList(List<KprLogicalComponentDetailJoinTableRelResDto> joinTableRelList) {
		this.joinTableRelList = joinTableRelList;
	}
	public List<KprLogicalComponentDetailJoinColumnBaseResDto> getJoinColumnList() {
		return joinColumnList;
	}
	public void setJoinColumnList(List<KprLogicalComponentDetailJoinColumnBaseResDto> joinColumnList) {
		this.joinColumnList = joinColumnList;
	}

}