package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinColumnMasterPopupListResponseDTO
 * 2. 파일명	: KPRLogicalComponentJoinColumnMasterPopupListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		칼럼 마스터 조회 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinColumnMasterPopupListResDto extends GridPagingItemResDto {

	/** 컬럼 마스터 ID */ private String colId;
	/** 컬럼 물리명 */ private String colNm;
	/** 컬럼 디스플레이명 */ private String dpNm;
	/** 컬럼 타입 */ private String colType;

	public String getColId() {
		return colId;
	}
	public void setColId(String colId) {
		this.colId = colId;
	}
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getDpNm() {
		return dpNm;
	}
	public void setDpNm(String dpNm) {
		this.dpNm = dpNm;
	}
	public String getColType() {
		return colType;
	}
	public void setColType(String colType) {
		this.colType = colType;
	}

}