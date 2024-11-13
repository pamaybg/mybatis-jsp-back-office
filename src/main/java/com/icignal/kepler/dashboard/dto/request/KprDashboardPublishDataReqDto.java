package com.icignal.kepler.dashboard.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRDashboardPublishDataRequestDTO
 * 2. 파일명	: KPRDashboardPublishDataRequestDTO.java
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
public class KprDashboardPublishDataReqDto extends MKTBaseReqDto {
	
	private String dashboardId;
	private String analysisMasterFlag;

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}

	public String getAnalysisMasterFlag() {
		return analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}
}