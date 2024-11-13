package com.icignal.systemmanagement.apppopup.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppPopMasterDetailReqDto extends CommonCondReqDto {
	
	private String appPopId;

	public String getAppPopId() {
		return appPopId;
	}

	public void setAppPopId(String appPopId) {
		this.appPopId = appPopId;
	}

}
