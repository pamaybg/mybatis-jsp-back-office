package com.icignal.kepler.dashboard.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class KprDashboardPromptCheckReqDto extends MKTBaseReqDto {
	
	private String dashboardId;

	public String getDashboardId() {
		return dashboardId;
	}

	public void setDashboardId(String dashboardId) {
		this.dashboardId = dashboardId;
	}
}
