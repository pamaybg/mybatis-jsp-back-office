package com.icignal.kepler.analysis.dto.request;

import java.util.HashMap;
import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisFilterDetailResDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;

/*
 * 1. 클래스명	: KPRAnalysisDataRequestDTO
 * 2. 파일명	: KPRAnalysisDataRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisDataReqDto extends KprAnalysisCommonReqDto {
	
	private String userId;
	private Boolean publishFlag;
	private String measureType;
	private Integer tableType;
	private Integer measureMin;
	private Integer dimensionMax;
	private String analysisSql;
	private String vSQL;
	private String displayName;
	private String columnName;
	private String dataRequestSequence;
	private String promptAlias;
	private Boolean promptFlag;
	private String setupFlag;
	private String whereString;

	private List<KprAnalysisDataReqDto> promptDataList;

	private HashMap<String, Object> promptDataMap;

	private List<KprAnalysisFilterDetailResDto> filterList;

	private List<KprAnalysisEngineReqDto> currentDrillDownGroupList;

	private List<KprDashboardPromptReqDto> dashboardPromptDataMap;

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Boolean getPublishFlag() {
		return this.publishFlag;
	}

	public void setPublishFlag(Boolean publishFlag) {
		this.publishFlag = publishFlag;
	}

	public String getMeasureType() {
		return this.measureType;
	}

	public void setMeasureType(String measureType) {
		this.measureType = measureType;
	}

	public Integer getTableType() {
		return this.tableType;
	}

	public void setTableType(Integer tableType) {
		this.tableType = tableType;
	}

	public Integer getMeasureMin() {
		return this.measureMin;
	}

	public void setMeasureMin(Integer measureMin) {
		this.measureMin = measureMin;
	}

	public Integer getDimensionMax() {
		return this.dimensionMax;
	}

	public void setDimensionMax(Integer dimensionMax) {
		this.dimensionMax = dimensionMax;
	}

	public String getAnalysisSql() {
		return this.analysisSql;
	}

	public void setAnalysisSql(String analysisSql) {
		this.analysisSql = analysisSql;
	}

	public String getvSQL() {
		return this.vSQL;
	}

	public void setvSQL(String vSQL) {
		this.vSQL = vSQL;
	}

	public String getDisplayName() {
		return this.displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getColumnName() {
		return this.columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getDataRequestSequence() {
		return this.dataRequestSequence;
	}

	public void setDataRequestSequence(String dataRequestSequence) {
		this.dataRequestSequence = dataRequestSequence;
	}

	public String getPromptAlias() {
		return this.promptAlias;
	}

	public void setPromptAlias(String promptAlias) {
		this.promptAlias = promptAlias;
	}

	public Boolean getPromptFlag() {
		return this.promptFlag;
	}

	public void setPromptFlag(Boolean promptFlag) {
		this.promptFlag = promptFlag;
	}

	public String getSetupFlag() {
		return this.setupFlag;
	}

	public void setSetupFlag(String setupFlag) {
		this.setupFlag = setupFlag;
	}

	public String getWhereString() {
		return this.whereString;
	}

	public void setWhereString(String whereString) {
		this.whereString = whereString;
	}

	public List<KprAnalysisDataReqDto> getPromptDataList() {
		return this.promptDataList;
	}

	public void setPromptDataList(List<KprAnalysisDataReqDto> promptDataList) {
		this.promptDataList = promptDataList;
	}

	public HashMap<String, Object> getPromptDataMap() {
		return this.promptDataMap;
	}

	public void setPromptDataMap(HashMap<String, Object> promptDataMap) {
		this.promptDataMap = promptDataMap;
	}

	public List<KprAnalysisFilterDetailResDto> getFilterList() {
		return this.filterList;
	}

	public void setFilterList(List<KprAnalysisFilterDetailResDto> filterList) {
		this.filterList = filterList;
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
}