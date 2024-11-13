package com.icignal.kepler.analysis.common.dto.request;

import java.util.HashMap;
import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;

/*
 * 1. 클래스명	: KPRAnalysisEngineRequestDTO
 * 2. 파일명	: KPRAnalysisEngineRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisEngineReqDto extends MKTBaseReqDto {
	
	private Boolean publishFlag;
	private String logicalComponentId;
	private String logicalComponentFromSql;
	private String analysisId;
	private String analysisMasterFlag;
	private String fieldGroupColumnId;
	private HashMap<String, Object> promptDataMap;
	private String databaseTypeCode;

	/*** DrillDown Group 정보 관련 ***/
	private String anlColumnId;
	private String columnId;
	private String drillDownGroupId;
	private String drillDownGroupName;
	private String levelColumnId;
	private String upperColumnId;
	private String lowerColumnId;
	private String columnAlias;
	private String tableColumnAlias;
	private String upperTableColumnAlias;
	private String columnDisplayName;
	private String columnName;
	private String tableAlias;
	private String filterValue;
	private List<KprAnalysisEngineReqDto> currentDrillDownGroupList;

	private List<KprDashboardPromptReqDto> dashboardPromptDataMap;

	private String colTotalTypeCode;
	private String colTotalTypeCodeName;
	private String rowTotalTypeCode;
	private String rowTotalTypeCodeName;

	public Boolean getPublishFlag() {
		return publishFlag;
	}

	public void setPublishFlag(Boolean publishFlag) {
		this.publishFlag = publishFlag;
	}

	public String getLogicalComponentId() {
		return logicalComponentId;
	}

	public void setLogicalComponentId(String logicalComponentId) {
		this.logicalComponentId = logicalComponentId;
	}

	public String getLogicalComponentFromSql() {
		return logicalComponentFromSql;
	}

	public void setLogicalComponentFromSql(String logicalComponentFromSql) {
		this.logicalComponentFromSql = logicalComponentFromSql;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisMasterFlag() {
		return analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}

	public String getFieldGroupColumnId() {
		return fieldGroupColumnId;
	}

	public void setFieldGroupColumnId(String fieldGroupColumnId) {
		this.fieldGroupColumnId = fieldGroupColumnId;
	}

	public HashMap<String, Object> getPromptDataMap() {
		return promptDataMap;
	}

	public void setPromptDataMap(HashMap<String, Object> promptDataMap) {
		this.promptDataMap = promptDataMap;
	}

	public String getDatabaseTypeCode() {
		return databaseTypeCode;
	}

	public void setDatabaseTypeCode(String databaseTypeCode) {
		this.databaseTypeCode = databaseTypeCode;
	}

	public String getAnlColumnId() {
		return anlColumnId;
	}

	public void setAnlColumnId(String anlColumnId) {
		this.anlColumnId = anlColumnId;
	}

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getDrillDownGroupId() {
		return drillDownGroupId;
	}

	public void setDrillDownGroupId(String drillDownGroupId) {
		this.drillDownGroupId = drillDownGroupId;
	}

	public String getDrillDownGroupName() {
		return drillDownGroupName;
	}

	public void setDrillDownGroupName(String drillDownGroupName) {
		this.drillDownGroupName = drillDownGroupName;
	}

	public String getLevelColumnId() {
		return levelColumnId;
	}

	public void setLevelColumnId(String levelColumnId) {
		this.levelColumnId = levelColumnId;
	}

	public String getUpperColumnId() {
		return upperColumnId;
	}

	public void setUpperColumnId(String upperColumnId) {
		this.upperColumnId = upperColumnId;
	}

	public String getLowerColumnId() {
		return lowerColumnId;
	}

	public void setLowerColumnId(String lowerColumnId) {
		this.lowerColumnId = lowerColumnId;
	}

	public String getColumnAlias() {
		return columnAlias;
	}

	public void setColumnAlias(String columnAlias) {
		this.columnAlias = columnAlias;
	}

	public String getTableColumnAlias() {
		return tableColumnAlias;
	}

	public void setTableColumnAlias(String tableColumnAlias) {
		this.tableColumnAlias = tableColumnAlias;
	}

	public String getUpperTableColumnAlias() {
		return upperTableColumnAlias;
	}

	public void setUpperTableColumnAlias(String upperTableColumnAlias) {
		this.upperTableColumnAlias = upperTableColumnAlias;
	}

	public String getColumnDisplayName() {
		return columnDisplayName;
	}

	public void setColumnDisplayName(String columnDisplayName) {
		this.columnDisplayName = columnDisplayName;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getTableAlias() {
		return tableAlias;
	}

	public void setTableAlias(String tableAlias) {
		this.tableAlias = tableAlias;
	}

	public String getFilterValue() {
		return filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public List<KprAnalysisEngineReqDto> getCurrentDrillDownGroupList() {
		return currentDrillDownGroupList;
	}

	public void setCurrentDrillDownGroupList(List<KprAnalysisEngineReqDto> currentDrillDownGroupList) {
		this.currentDrillDownGroupList = currentDrillDownGroupList;
	}

	public List<KprDashboardPromptReqDto> getDashboardPromptDataMap() {
		return dashboardPromptDataMap;
	}

	public void setDashboardPromptDataMap(List<KprDashboardPromptReqDto> dashboardPromptDataMap) {
		this.dashboardPromptDataMap = dashboardPromptDataMap;
	}

	public String getColTotalTypeCode() {
		return colTotalTypeCode;
	}

	public void setColTotalTypeCode(String colTotalTypeCode) {
		this.colTotalTypeCode = colTotalTypeCode;
	}

	public String getColTotalTypeCodeName() {
		return colTotalTypeCodeName;
	}

	public void setColTotalTypeCodeName(String colTotalTypeCodeName) {
		this.colTotalTypeCodeName = colTotalTypeCodeName;
	}

	public String getRowTotalTypeCode() {
		return rowTotalTypeCode;
	}

	public void setRowTotalTypeCode(String rowTotalTypeCode) {
		this.rowTotalTypeCode = rowTotalTypeCode;
	}

	public String getRowTotalTypeCodeName() {
		return rowTotalTypeCodeName;
	}

	public void setRowTotalTypeCodeName(String rowTotalTypeCodeName) {
		this.rowTotalTypeCodeName = rowTotalTypeCodeName;
	}
}