package com.icignal.systemmanagement.appversion.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppVerDetailReqDto extends CommonCondReqDto {
	
	private String appId;

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

}
