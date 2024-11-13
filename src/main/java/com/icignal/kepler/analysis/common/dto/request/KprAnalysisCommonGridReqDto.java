package com.icignal.kepler.analysis.common.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

/*
 * 1. 클래스명	: KPRAnalysisCommonGridRequestDTO
 * 2. 파일명	: KPRAnalysisCommonGridRequestDTO.java
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
public class KprAnalysisCommonGridReqDto extends GridPagingReqDto {
	
	private String empId;
	private String logicalCompId;
	private String atribGroupColumnId;
	private String analysisId;
	private String analysisId_New;
	private String analysisTypeCode;
	private String analysisMasterFlag;
	private String chartTypeCode;
	private Integer columnGroupFlag;
	private String columnId;
	private String columnUseTypeCode;
	private String groupFuncTypeCode;
	private Integer seq;
	private String promptValue;
	private String promptTypeCode;
	private String fieldGroupColumnId;
	private List<KprAnalysisCommonReqDto> atribGroupColumnList;

	private Boolean pagingFlag;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getLogicalCompId() {
		return logicalCompId;
	}

	public void setLogicalCompId(String logicalCompId) {
		this.logicalCompId = logicalCompId;
	}

	public String getAtribGroupColumnId() {
		return atribGroupColumnId;
	}

	public void setAtribGroupColumnId(String atribGroupColumnId) {
		this.atribGroupColumnId = atribGroupColumnId;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisId_New() {
		return analysisId_New;
	}

	public void setAnalysisId_New(String analysisId_New) {
		this.analysisId_New = analysisId_New;
	}

	public String getAnalysisTypeCode() {
		return analysisTypeCode;
	}

	public void setAnalysisTypeCode(String analysisTypeCode) {
		this.analysisTypeCode = analysisTypeCode;
	}

	public String getAnalysisMasterFlag() {
		return analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}

	public String getChartTypeCode() {
		return chartTypeCode;
	}

	public void setChartTypeCode(String chartTypeCode) {
		this.chartTypeCode = chartTypeCode;
	}

	public Integer getColumnGroupFlag() {
		return columnGroupFlag;
	}

	public void setColumnGroupFlag(Integer columnGroupFlag) {
		this.columnGroupFlag = columnGroupFlag;
	}

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getColumnUseTypeCode() {
		return columnUseTypeCode;
	}

	public void setColumnUseTypeCode(String columnUseTypeCode) {
		this.columnUseTypeCode = columnUseTypeCode;
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

	public String getPromptValue() {
		return promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getPromptTypeCode() {
		return promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getFieldGroupColumnId() {
		return fieldGroupColumnId;
	}

	public void setFieldGroupColumnId(String fieldGroupColumnId) {
		this.fieldGroupColumnId = fieldGroupColumnId;
	}

	public List<KprAnalysisCommonReqDto> getAtribGroupColumnList() {
		return atribGroupColumnList;
	}

	public void setAtribGroupColumnList(List<KprAnalysisCommonReqDto> atribGroupColumnList) {
		this.atribGroupColumnList = atribGroupColumnList;
	}

	public Boolean getPagingFlag() {
		return pagingFlag;
	}

	public void setPagingFlag(Boolean pagingFlag) {
		this.pagingFlag = pagingFlag;
	}
}