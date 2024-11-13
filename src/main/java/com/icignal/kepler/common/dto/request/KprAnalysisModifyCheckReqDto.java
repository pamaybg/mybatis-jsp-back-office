package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRAnalysisModifyCheckRequestDTO
 * 2. 파일명	: KPRAnalysisModifyCheckRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisModifyCheckReqDto extends MKTBaseReqDto {
	
	private String empId;
	private String analysisId;
	private String dashboardId;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}
}