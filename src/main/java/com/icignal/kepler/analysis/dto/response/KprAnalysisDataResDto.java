package com.icignal.kepler.analysis.dto.response;

import java.util.HashMap;
import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisEngineResDto;

/*
 * 1. 클래스명	: KPRAnalysisDataResponseDTO
 * 2. 파일명	: KPRAnalysisDataResponseDTO.java
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
public class KprAnalysisDataResDto extends KprAnalysisCommonResDto {
	
	private String baseSQL;
	private String fieldGroupColumnId;
	private Boolean dateFlag;
	private Boolean fieldGroupFlag;
	private Boolean promptFlag;
	private String measureLoc;
	private String filterValue;
	private HashMap<String, Object> promptDataMap;
	private HashMap<String, Object> chartInformation;
	private HashMap<String, Object> analysisDataMap;
	private List<KprAnalysisEngineResDto> measureList;
	private List<HashMap<String, Object>> columnNameList;
	private List<HashMap<String, Object>> rowNameList;
	private List<HashMap<String, Object>> valueNameList;
	private List<HashMap<String, Object>> martDataList;
	private List<KprAnalysisEngineReqDto> currentDrillDownGroupList;
	private List<KprAnalysisEngineResDto> metaDrillDownGroupList;
	private String colTotalTypeCode;
	private String colTotalTypeCodeName;
	private String rowTotalTypeCode;
	private String rowTotalTypeCodeName;

	public String getBaseSQL() {
		return baseSQL;
	}

	public void setBaseSQL(String baseSQL) {
		this.baseSQL = baseSQL;
	}

	public String getFieldGroupColumnId() {
		return fieldGroupColumnId;
	}

	public void setFieldGroupColumnId(String fieldGroupColumnId) {
		this.fieldGroupColumnId = fieldGroupColumnId;
	}

	public Boolean getDateFlag() {
		return dateFlag;
	}

	public void setDateFlag(Boolean dateFlag) {
		this.dateFlag = dateFlag;
	}

	public Boolean getFieldGroupFlag() {
		return fieldGroupFlag;
	}

	public void setFieldGroupFlag(Boolean fieldGroupFlag) {
		this.fieldGroupFlag = fieldGroupFlag;
	}

	public Boolean getPromptFlag() {
		return promptFlag;
	}

	public void setPromptFlag(Boolean promptFlag) {
		this.promptFlag = promptFlag;
	}

	public String getMeasureLoc() {
		return measureLoc;
	}

	public void setMeasureLoc(String measureLoc) {
		this.measureLoc = measureLoc;
	}

	public String getFilterValue() {
		return filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public HashMap<String, Object> getPromptDataMap() {
		return promptDataMap;
	}

	public void setPromptDataMap(HashMap<String, Object> promptDataMap) {
		this.promptDataMap = promptDataMap;
	}

	public HashMap<String, Object> getChartInformation() {
		return chartInformation;
	}

	public void setChartInformation(HashMap<String, Object> chartInformation) {
		this.chartInformation = chartInformation;
	}

	public HashMap<String, Object> getAnalysisDataMap() {
		return analysisDataMap;
	}

	public void setAnalysisDataMap(HashMap<String, Object> analysisDataMap) {
		this.analysisDataMap = analysisDataMap;
	}

	public List<KprAnalysisEngineResDto> getMeasureList() {
		return measureList;
	}

	public void setMeasureList(List<KprAnalysisEngineResDto> measureList) {
		this.measureList = measureList;
	}

	public List<HashMap<String, Object>> getColumnNameList() {
		return columnNameList;
	}

	public void setColumnNameList(List<HashMap<String, Object>> columnNameList) {
		this.columnNameList = columnNameList;
	}

	public List<HashMap<String, Object>> getRowNameList() {
		return rowNameList;
	}

	public void setRowNameList(List<HashMap<String, Object>> rowNameList) {
		this.rowNameList = rowNameList;
	}

	public List<HashMap<String, Object>> getValueNameList() {
		return valueNameList;
	}

	public void setValueNameList(List<HashMap<String, Object>> valueNameList) {
		this.valueNameList = valueNameList;
	}

	public List<HashMap<String, Object>> getMartDataList() {
		return martDataList;
	}

	public void setMartDataList(List<HashMap<String, Object>> martDataList) {
		this.martDataList = martDataList;
	}

	public List<KprAnalysisEngineReqDto> getCurrentDrillDownGroupList() {
		return currentDrillDownGroupList;
	}

	public void setCurrentDrillDownGroupList(List<KprAnalysisEngineReqDto> currentDrillDownGroupList) {
		this.currentDrillDownGroupList = currentDrillDownGroupList;
	}

	public List<KprAnalysisEngineResDto> getMetaDrillDownGroupList() {
		return metaDrillDownGroupList;
	}

	public void setMetaDrillDownGroupList(List<KprAnalysisEngineResDto> metaDrillDownGroupList) {
		this.metaDrillDownGroupList = metaDrillDownGroupList;
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