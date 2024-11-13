package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRCommonCondListResponseDTO
 * 2. 파일명	: KPRCommonCondListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2015. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		공통 조건 조회
 * </PRE>
 */ 
public class KprCommonCondListResDto extends GridPagingItemResDto {
	
	private String condName;		//조건 명
	private String condType;		//조건 유형
	private String grpCode;			//조건 그룹 코드
	private String defCon;			//초기 조건
	private String baseTable;		//기본 테이블
	private String baseSchema;		//기본 테이블 스키마
	private String tgtTable;		//타겟 테이블
	private String tgtSchema;		//타겟 스키마
	private String tgtCol;			//타겟 컬럼
	private String joinSrcClm;		//조인 소스 컬럼
	private String joinTgtClm;		//조인 타겟 컬럼
	private String baseTblAlias;	//기본 테이블 얼리어스
	private String comprTgtTblAlias;	//비교대상 테이블 얼리아스
	
	public String getCondName() {
		return condName;
	}
	public void setCondName(String condName) {
		this.condName = condName;
	}
	public String getCondType() {
		return condType;
	}
	public void setCondType(String condType) {
		this.condType = condType;
	}
	public String getGrpCode() {
		return grpCode;
	}
	public void setGrpCode(String grpCode) {
		this.grpCode = grpCode;
	}
	public String getDefCon() {
		return defCon;
	}
	public void setDefCon(String defCon) {
		this.defCon = defCon;
	}
	public String getBaseTable() {
		return baseTable;
	}
	public void setBaseTable(String baseTable) {
		this.baseTable = baseTable;
	}
	public String getBaseSchema() {
		return baseSchema;
	}
	public void setBaseSchema(String baseSchema) {
		this.baseSchema = baseSchema;
	}
	public String getTgtTable() {
		return tgtTable;
	}
	public void setTgtTable(String tgtTable) {
		this.tgtTable = tgtTable;
	}
	public String getTgtSchema() {
		return tgtSchema;
	}
	public void setTgtSchema(String tgtSchema) {
		this.tgtSchema = tgtSchema;
	}
	public String getTgtCol() {
		return tgtCol;
	}
	public void setTgtCol(String tgtCol) {
		this.tgtCol = tgtCol;
	}
	public String getJoinSrcClm() {
		return joinSrcClm;
	}
	public void setJoinSrcClm(String joinSrcClm) {
		this.joinSrcClm = joinSrcClm;
	}
	public String getJoinTgtClm() {
		return joinTgtClm;
	}
	public void setJoinTgtClm(String joinTgtClm) {
		this.joinTgtClm = joinTgtClm;
	}
	public String getBaseTblAlias() {
		return baseTblAlias;
	}
	public void setBaseTblAlias(String baseTblAlias) {
		this.baseTblAlias = baseTblAlias;
	}
	public String getComprTgtTblAlias() {
		return comprTgtTblAlias;
	}
	public void setComprTgtTblAlias(String comprTgtTblAlias) {
		this.comprTgtTblAlias = comprTgtTblAlias;
	}
 }
