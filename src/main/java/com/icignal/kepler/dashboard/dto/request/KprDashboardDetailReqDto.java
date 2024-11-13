package com.icignal.kepler.dashboard.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


/*
 * 1. 클래스명	: KPRDashboardDetailRequestDTO
 * 2. 파일명	: KPRDashboardDetailRequestDTO.java
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
public class KprDashboardDetailReqDto extends MKTBaseReqDto {
	
	private String dashboardId;
	private String dashboardId_New;
	private String dashboardName;
	private Integer dashboardSeq;
	private String dashboardEmbedType;
	private String folderId;
	private String dashboardMasterFlag;
	private String analysisId;
	private String analysisId_New;
	private String layoutId;

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

	public String getFolderId() {
		return folderId;
	}

	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}

	public String getDashboardMasterFlag() {
		return dashboardMasterFlag;
	}

	public void setDashboardMasterFlag(String dashboardMasterFlag) {
		this.dashboardMasterFlag = dashboardMasterFlag;
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

	public String getLayoutId() {
		return layoutId;
	}

	public void setLayoutId(String layoutId) {
		this.layoutId = layoutId;
	}
}