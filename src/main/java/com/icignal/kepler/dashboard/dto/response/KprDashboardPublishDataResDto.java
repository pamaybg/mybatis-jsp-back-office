package com.icignal.kepler.dashboard.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRDashboardPublishDataResponseDTO
 * 2. 파일명	: KPRDashboardPublishDataResponseDTO.java
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
public class KprDashboardPublishDataResDto extends StatusResDto {
	
	private String dashboardId;
	private String dashboardName;
	private String analysisId;
	private String analysisName;
	private String dashboardEmbedType;
	private String layoutHtml;

	private List<KprDashboardPublishDataResDto> analysisList;
	private List<KprDashboardPromptResDto> dashboardPromptList;

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}

	public String getDashboardName() {
		return dashboardName;
	}

	public void setDashboardName(String dashboardName) {
		this.dashboardName = dashboardName;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisName() {
		return analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}

	public String getDashboardEmbedType() {
		return dashboardEmbedType;
	}

	public void setDashboardEmbedType(String dashboardEmbedType) {
		this.dashboardEmbedType = dashboardEmbedType;
	}

	public String getLayoutHtml() {
		return layoutHtml;
	}

	public void setLayoutHtml(String layoutHtml) {
		this.layoutHtml = layoutHtml;
	}

	public List<KprDashboardPublishDataResDto> getAnalysisList() {
		return analysisList;
	}

	public void setAnalysisList(List<KprDashboardPublishDataResDto> analysisList) {
		this.analysisList = analysisList;
	}

	public List<KprDashboardPromptResDto> getDashboardPromptList() {
		return dashboardPromptList;
	}

	public void setDashboardPromptList(List<KprDashboardPromptResDto> dashboardPromptList) {
		this.dashboardPromptList = dashboardPromptList;
	}
}