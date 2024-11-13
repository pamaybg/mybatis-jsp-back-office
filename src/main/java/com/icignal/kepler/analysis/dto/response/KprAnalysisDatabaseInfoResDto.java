package com.icignal.kepler.analysis.dto.response;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;


/*
 * 1. 클래스명	: KPRAnalysisDatabaseInfoResponseDTO
 * 2. 파일명	: KPRAnalysisDatabaseInfoResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisDatabaseInfoResDto extends KprAnalysisCommonResDto {
	
	private String databaseId;
	private String connectIp;
	private String connectPort;
	private String connectId;
	private String connectPw;
	private String connectUrl;
	private String tableSchemaName;
	private String tableName;
	private String connectDatabaseType;
	private String connectDatabaseClass;
	private String logicalCompSql;
	private String secretNm;

	public String getDatabaseId() {
		return this.databaseId;
	}

	public void setDatabaseId(String databaseId) {
		this.databaseId = databaseId;
	}

	public String getConnectIp() {
		return this.connectIp;
	}

	public void setConnectIp(String connectIp) {
		this.connectIp = connectIp;
	}

	public String getConnectPort() {
		return this.connectPort;
	}

	public void setConnectPort(String connectPort) {
		this.connectPort = connectPort;
	}

	public String getConnectId() {
		return this.connectId;
	}

	public void setConnectId(String connectId) {
		this.connectId = connectId;
	}

	public String getConnectPw() {
		return this.connectPw;
	}

	public void setConnectPw(String connectPw) {
		this.connectPw = connectPw;
	}

	public String getConnectUrl() {
		return this.connectUrl;
	}

	public void setConnectUrl(String connectUrl) {
		this.connectUrl = connectUrl;
	}

	public String getTableSchemaName() {
		return this.tableSchemaName;
	}

	public void setTableSchemaName(String tableSchemaName) {
		this.tableSchemaName = tableSchemaName;
	}

	public String getTableName() {
		return this.tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getConnectDatabaseType() {
		return this.connectDatabaseType;
	}

	public void setConnectDatabaseType(String connectDatabaseType) {
		this.connectDatabaseType = connectDatabaseType;
	}

	public String getConnectDatabaseClass() {
		return this.connectDatabaseClass;
	}

	public void setConnectDatabaseClass(String connectDatabaseClass) {
		this.connectDatabaseClass = connectDatabaseClass;
	}

	public String getLogicalCompSql() {
		return this.logicalCompSql;
	}

	public void setLogicalCompSql(String logicalCompSql) {
		this.logicalCompSql = logicalCompSql;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
}