package com.icignal.kepler.analysis.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingResDto;

/*
 * 1. 클래스명	: KPRAnalysisCommonResponseDTO
 * 2. 파일명	: KPRAnalysisCommonResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisCommonResDto extends GridPagingResDto {
	
	private String nodeId;
	private String parNodeId;
	private String nodeText;
	private Boolean expandedFlag;
	private String logicalCompId;
	private String logicalCompSql;
	private String analysisId;
	private String chartType;
	private String atribGroupColumnId;
	private String displayName;
	private String columnName;
	private String columnTypeCode;
	private String leftChartLabelTypeCode;
	private String rightChartLabelTypeCode;
	private String dataDisplayTypeCode;
	private String groupFuncTypeCode;
	private Integer seq;
	//private String baseSql;
	private String chartSql;
	private String tableSql;

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getParNodeId() {
		return parNodeId;
	}

	public void setParNodeId(String parNodeId) {
		this.parNodeId = parNodeId;
	}

	public String getNodeText() {
		return nodeText;
	}

	public void setNodeText(String nodeText) {
		this.nodeText = nodeText;
	}

	public Boolean getExpandedFlag() {
		return expandedFlag;
	}

	public void setExpandedFlag(Boolean expandedFlag) {
		this.expandedFlag = expandedFlag;
	}

	public String getLogicalCompId() {
		return logicalCompId;
	}

	public void setLogicalCompId(String logicalCompId) {
		this.logicalCompId = logicalCompId;
	}

	public String getLogicalCompSql() {
		return logicalCompSql;
	}

	public void setLogicalCompSql(String logicalCompSql) {
		this.logicalCompSql = logicalCompSql;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getChartType() {
		return chartType;
	}

	public void setChartType(String chartType) {
		this.chartType = chartType;
	}

	public String getAtribGroupColumnId() {
		return atribGroupColumnId;
	}

	public void setAtribGroupColumnId(String atribGroupColumnId) {
		this.atribGroupColumnId = atribGroupColumnId;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnTypeCode() {
		return columnTypeCode;
	}

	public void setColumnTypeCode(String columnTypeCode) {
		this.columnTypeCode = columnTypeCode;
	}

	public String getLeftChartLabelTypeCode() {
		return leftChartLabelTypeCode;
	}

	public void setLeftChartLabelTypeCode(String leftChartLabelTypeCode) {
		this.leftChartLabelTypeCode = leftChartLabelTypeCode;
	}

	public String getRightChartLabelTypeCode() {
		return rightChartLabelTypeCode;
	}

	public void setRightChartLabelTypeCode(String rightChartLabelTypeCode) {
		this.rightChartLabelTypeCode = rightChartLabelTypeCode;
	}

	public String getDataDisplayTypeCode() {
		return dataDisplayTypeCode;
	}

	public void setDataDisplayTypeCode(String dataDisplayTypeCode) {
		this.dataDisplayTypeCode = dataDisplayTypeCode;
	}

	public String getGroupFuncTypeCode() {
		return groupFuncTypeCode;
	}

	public void setGroupFuncTypeCode(String groupFuncTypeCode) {
		this.groupFuncTypeCode = groupFuncTypeCode;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

/*	public String getBaseSql() {
		return baseSql;
	}

	public void setBaseSql(String baseSql) {
		this.baseSql = baseSql;
	}*/

	public String getChartSql() {
		return chartSql;
	}

	public void setChartSql(String chartSql) {
		this.chartSql = chartSql;
	}

	public String getTableSql() {
		return tableSql;
	}

	public void setTableSql(String tableSql) {
		this.tableSql = tableSql;
	}
}