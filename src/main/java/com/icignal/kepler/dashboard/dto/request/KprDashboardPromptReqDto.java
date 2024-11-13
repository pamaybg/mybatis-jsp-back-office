package com.icignal.kepler.dashboard.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRDashboardPromptRequestDTO
 * 2. 파일명	: KPRDashboardPromptRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprDashboardPromptReqDto extends MKTBaseReqDto {
	
	private String dashboardId;
	private String dashboardId_New;
	private String analysisMasterFlag;
	private String promptId;
	private String columnId;
	private String promptTypeCode;
	private Integer seq;
	private String promptValue;
	private String promptValue1CodeName;
	private String promptValue2CodeName;
	private String promptValue3CodeName;


	private List<KprDashboardPromptReqDto> promptList;

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}

	public String getDashboardId_New() {
		return dashboardId_New;
	}

	public void setDashboardId_New(String dashboardId_New) {
		this.dashboardId_New = dashboardId_New;
	}

	public String getAnalysisMasterFlag() {
		return analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}

	public String getPromptId() {
		return promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getPromptTypeCode() {
		return promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
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

	public String getPromptValue1CodeName() {
		return promptValue1CodeName;
	}

	public void setPromptValue1CodeName(String promptValue1CodeName) {
		this.promptValue1CodeName = promptValue1CodeName;
	}

	public String getPromptValue2CodeName() {
		return promptValue2CodeName;
	}

	public void setPromptValue2CodeName(String promptValue2CodeName) {
		this.promptValue2CodeName = promptValue2CodeName;
	}
	
	public String getPromptValue3CodeName() {
		return promptValue3CodeName;
	}

	public void setPromptValue3CodeName(String promptValue3CodeName) {
		this.promptValue3CodeName = promptValue3CodeName;
	}

	public List<KprDashboardPromptReqDto> getPromptList() {
		return promptList;
	}

	public void setPromptList(List<KprDashboardPromptReqDto> promptList) {
		this.promptList = promptList;
	}
}