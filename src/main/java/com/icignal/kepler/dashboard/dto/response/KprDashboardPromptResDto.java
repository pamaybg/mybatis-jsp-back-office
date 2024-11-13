package com.icignal.kepler.dashboard.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRDashboardPromptResponseDTO
 * 2. 파일명	: KPRDashboardPromptResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprDashboardPromptResDto extends StatusResDto {
	
	private String nodeId;
	private String nodeText;
	private String columnId;
	private String displayName;
	private String tableName;
	private String columnName;
	private String promptId;
	private String promptTypeCode;
	private String promptValue;
	private String promptValue1MarkName;
	private String promptValue1CodeName;
	private String promptValue2MarkName;
	private String promptValue2CodeName;
	private String promptValue3MarkName;
	private String promptValue3CodeName;
	private String upperPromptId;

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

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
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

	public String getPromptId() {
		return promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getPromptTypeCode() {
		return promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getPromptValue() {
		return promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getPromptValue1MarkName() {
		return promptValue1MarkName;
	}

	public void setPromptValue1MarkName(String promptValue1MarkName) {
		this.promptValue1MarkName = promptValue1MarkName;
	}

	public String getPromptValue1CodeName() {
		return promptValue1CodeName;
	}

	public void setPromptValue1CodeName(String promptValue1CodeName) {
		this.promptValue1CodeName = promptValue1CodeName;
	}

	public String getPromptValue2MarkName() {
		return promptValue2MarkName;
	}

	public void setPromptValue2MarkName(String promptValue2MarkName) {
		this.promptValue2MarkName = promptValue2MarkName;
	}

	public String getPromptValue2CodeName() {
		return promptValue2CodeName;
	}

	public void setPromptValue2CodeName(String promptValue2CodeName) {
		this.promptValue2CodeName = promptValue2CodeName;
	}

	public String getPromptValue3MarkName() {
		return promptValue3MarkName;
	}

	public void setPromptValue3MarkName(String promptValue3MarkName) {
		this.promptValue3MarkName = promptValue3MarkName;
	}

	public String getPromptValue3CodeName() {
		return promptValue3CodeName;
	}

	public void setPromptValue3CodeName(String promptValue3CodeName) {
		this.promptValue3CodeName = promptValue3CodeName;
	}

	public String getUpperPromptId() {
		return upperPromptId;
	}

	public void setUpperPromptId(String upperPromptId) {
		this.upperPromptId = upperPromptId;
	}
}