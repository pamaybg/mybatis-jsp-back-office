package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

public class KprDatabaseUseSchemaResDto extends StatusResDto {
	
	private String rId;
	private String databaseId;
	private String schemaName;
	private String nodeId;
	private String nodeText;

	private List<KprDatabaseUseSchemaResDto> sourceSchemaNameList;
	private List<KprDatabaseUseSchemaResDto> targetSchemaNameList;

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public String getDatabaseId() {
		return databaseId;
	}

	public void setDatabaseId(String databaseId) {
		this.databaseId = databaseId;
	}

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		this.schemaName = schemaName;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeText() {
		return nodeText;
	}

	public void setNodeText(String nodeText) {
		this.nodeText = nodeText;
	}

	public List<KprDatabaseUseSchemaResDto> getSourceSchemaNameList() {
		return sourceSchemaNameList;
	}

	public void setSourceSchemaNameList(List<KprDatabaseUseSchemaResDto> sourceSchemaNameList) {
		this.sourceSchemaNameList = sourceSchemaNameList;
	}

	public List<KprDatabaseUseSchemaResDto> getTargetSchemaNameList() {
		return targetSchemaNameList;
	}

	public void setTargetSchemaNameList(List<KprDatabaseUseSchemaResDto> targetSchemaNameList) {
		this.targetSchemaNameList = targetSchemaNameList;
	}
}