package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingResDto;

/*
 * 1. 클래스명	: KPRCommonColumnResponseDTO
 * 2. 파일명	: KPRCommonColumnResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: Duck
 * 5. 작성일자	: 2015. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprCommonColumnResDto extends GridPagingResDto {
	private String connectIp;
	private String connectPort;
	private String connectId;
	private String connectPw;
	private String connectUrl;
	private String connectDatabaseType;
	private String connectDatabaseClass;
	private String schemaName;
	private String tableName;
	private String columnName;
	private String secretNm;

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

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
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

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
}