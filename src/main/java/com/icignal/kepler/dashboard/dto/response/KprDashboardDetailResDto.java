package com.icignal.kepler.dashboard.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRDashboardDetailResponseDTO
 * 2. 파일명	: KPRDashboardDetailResponseDTO.java
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
public class KprDashboardDetailResDto extends StatusResDto {
	
	private String dashboardId;
	private String dashboardName;
	private Integer dashboardSeq;
	private String dashboardEmbedType;
	private String analysisId;
	private String analysisName;
	private String layoutId;
	private String layoutHtml;
	private String layoutSeq;
	private String layoutImage;
	private String folderId;
	private Boolean nameFlag;

	private List<KprDashboardDetailResDto> analysisList;

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

	public Integer getDashboardSeq() {
		return dashboardSeq;
	}

	public void setDashboardSeq(Integer dashboardSeq) {
		this.dashboardSeq = dashboardSeq;
	}

	public String getDashboardEmbedType() {
		return dashboardEmbedType;
	}

	public void setDashboardEmbedType(String dashboardEmbedType) {
		this.dashboardEmbedType = dashboardEmbedType;
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

	public String getLayoutId() {
		return layoutId;
	}

	public void setLayoutId(String layoutId) {
		this.layoutId = layoutId;
	}

	public String getLayoutHtml() {
		return layoutHtml;
	}

	public void setLayoutHtml(String layoutHtml) {
		this.layoutHtml = layoutHtml;
	}

	public String getLayoutSeq() {
		return layoutSeq;
	}

	public void setLayoutSeq(String layoutSeq) {
		this.layoutSeq = layoutSeq;
	}

	public String getLayoutImage() {
		return layoutImage;
	}

	public void setLayoutImage(String layoutImage) {
		this.layoutImage = layoutImage;
	}

	public String getFolderId() {
		return folderId;
	}

	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}

	public Boolean getNameFlag() {
		return nameFlag;
	}

	public void setNameFlag(Boolean nameFlag) {
		this.nameFlag = nameFlag;
	}

	public List<KprDashboardDetailResDto> getAnalysisList() {
		return analysisList;
	}

	public void setAnalysisList(List<KprDashboardDetailResDto> analysisList) {
		this.analysisList = analysisList;
	}
}