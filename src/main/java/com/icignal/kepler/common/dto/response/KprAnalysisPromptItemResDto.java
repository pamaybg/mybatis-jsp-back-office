package com.icignal.kepler.common.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRAnalysisPromptItemResponseDTO
 * 2. 파일명	: KPRAnalysisPromptItemResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisPromptItemResDto extends StatusResDto {
	
	private String analysisId;
	private String promptId;
	private String promptValue;
	private String promptAlias;
	private String databaseId;
	private String connectIp;
	private String connectPort;
	private String connectId;
	private String connectPw;
	private String connectUrl;
	private String tableSchemaName;
	private String tableName;
	private String columnName;
	private String atribGroupColumnId;
	private String atribGroupColumnName;
	private String connectDatabaseType;
	private String connectDatabaseClass;
	private String promptTypeCode;
	private String tableAliasColumnName;

	private List<KprAnalysisPromptItemResDto> promptValueList;

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getPromptId() {
		return promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getPromptValue() {
		return promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getPromptAlias() {
		return promptAlias;
	}

	public void setPromptAlias(String promptAlias) {
		this.promptAlias = promptAlias;
	}

	public String getDatabaseId() {
		return databaseId;
	}

	public void setDatabaseId(String databaseId) {
		this.databaseId = databaseId;
	}

	public String getConnectIp() {
		return connectIp;
	}

	public void setConnectIp(String connectIp) {
		this.connectIp = connectIp;
	}

	public String getConnectPort() {
		return connectPort;
	}

	public void setConnectPort(String connectPort) {
		this.connectPort = connectPort;
	}

	public String getConnectId() {
		return connectId;
	}

	public void setConnectId(String connectId) {
		this.connectId = connectId;
	}

	public String getConnectPw() {
		return connectPw;
	}

	public void setConnectPw(String connectPw) {
		this.connectPw = connectPw;
	}

	public String getConnectUrl() {
		return connectUrl;
	}

	public void setConnectUrl(String connectUrl) {
		this.connectUrl = connectUrl;
	}

	public String getTableSchemaName() {
		return tableSchemaName;
	}

	public void setTableSchemaName(String tableSchemaName) {
		this.tableSchemaName = tableSchemaName;
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

	public String getAtribGroupColumnId() {
		return atribGroupColumnId;
	}

	public void setAtribGroupColumnId(String atribGroupColumnId) {
		this.atribGroupColumnId = atribGroupColumnId;
	}

	public String getAtribGroupColumnName() {
		return atribGroupColumnName;
	}

	public void setAtribGroupColumnName(String atribGroupColumnName) {
		this.atribGroupColumnName = atribGroupColumnName;
	}

	public String getConnectDatabaseType() {
		return connectDatabaseType;
	}

	public void setConnectDatabaseType(String connectDatabaseType) {
		this.connectDatabaseType = connectDatabaseType;
	}

	public String getConnectDatabaseClass() {
		return connectDatabaseClass;
	}

	public void setConnectDatabaseClass(String connectDatabaseClass) {
		this.connectDatabaseClass = connectDatabaseClass;
	}

	public String getPromptTypeCode() {
		return promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getTableAliasColumnName() {
		return tableAliasColumnName;
	}

	public void setTableAliasColumnName(String tableAliasColumnName) {
		this.tableAliasColumnName = tableAliasColumnName;
	}

	public List<KprAnalysisPromptItemResDto> getPromptValueList() {
		return promptValueList;
	}

	public void setPromptValueList(List<KprAnalysisPromptItemResDto> promptValueList) {
		this.promptValueList = promptValueList;
	}
}