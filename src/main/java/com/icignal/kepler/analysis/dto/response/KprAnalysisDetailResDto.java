package com.icignal.kepler.analysis.dto.response;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;


/*
 * 1. 클래스명	: KPRAnalysisDetailResponseDTO
 * 2. 파일명	: KPRAnalysisDetailResponseDTO.java
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
public class KprAnalysisDetailResDto extends KprAnalysisCommonResDto {
	
	private String analysisName;
	private String folderId;
	private String dashboardId;
	private String dashboardType;
	private String logicalCompName;
	private String columnGroupFlag;
	private Integer filterCount;

	public String getAnalysisName() {
		return this.analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}

	public String getFolderId() {
		return this.folderId;
	}

	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}

	public String getDashboardId() {
		return this.dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}

	public String getDashboardType() {
		return this.dashboardType;
	}

	public void setDashboardType(String dashboardType) {
		this.dashboardType = dashboardType;
	}

	public String getLogicalCompName() {
		return this.logicalCompName;
	}

	public void setLogicalCompName(String logicalCompName) {
		this.logicalCompName = logicalCompName;
	}

	public String getColumnGroupFlag() {
		return this.columnGroupFlag;
	}

	public void setColumnGroupFlag(String columnGroupFlag) {
		this.columnGroupFlag = columnGroupFlag;
	}

	public Integer getFilterCount() {
		return this.filterCount;
	}

	public void setFilterCount(Integer filterCount) {
		this.filterCount = filterCount;
	}
}