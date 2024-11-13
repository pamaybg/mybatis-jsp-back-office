package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinColumnMasterListResponseDTO
 * 2. 파일명	: KPRLogicalComponentJoinColumnMasterListResponseDTO.java
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
public class KprLogicalComponentJoinColumnMasterListResDto extends StatusResDto {

	/** 컬럼 마스터 ID */
	private String columnMstId;
	/** 컬럼 물리명(DB 조회용) */
	private String col;
	/** 컬럼 물리명(Return용) */
	private String column;
	/** 컬럼 디스플레이명 */
	private String columnName;
	/** 컬럼 타입 */
	private String columnType;

	private String columnUseType;

	public String getColumnMstId() {
		return columnMstId;
	}

	public void setColumnMstId(String columnMstId) {
		this.columnMstId = columnMstId;
	}

	public String getCol() {
		return col;
	}

	public void setCol(String col) {
		this.col = col;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnType() {
		return columnType;
	}

	public void setColumnType(String coloumnType) {
		this.columnType = coloumnType;
	}

	public String getColumnUseType() {
		return columnUseType;
	}

	public void setColumnUseType(String columnUseType) {
		this.columnUseType = columnUseType;
	}
}