package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: KPRCommonColumnRequestDTO
 * 2. 파일명	: KPRCommonColumnRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprCommonColumnReqDto extends MKTGridPagingReqDto {
	
	private String columnId;
	private String upperColumnId;
	private String conditionValue;
	//BI Prompt 세팅 관련
	private String branchCode;
	private String stationCode;
	private String tableName;
	private String columnName;
	private Boolean pagingFlag;

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getUpperColumnId() {
		return upperColumnId;
	}

	public void setUpperColumnId(String upperColumnId) {
		this.upperColumnId = upperColumnId;
	}

	public String getConditionValue() {
		return conditionValue;
	}

	public void setConditionValue(String conditionValue) {
		this.conditionValue = conditionValue;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}

	public String getStationCode() {
		return stationCode;
	}

	public void setStationCode(String stationCode) {
		this.stationCode = stationCode;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public Boolean getPagingFlag() {
		return pagingFlag;
	}

	public void setPagingFlag(Boolean pagingFlag) {
		this.pagingFlag = pagingFlag;
	}
}