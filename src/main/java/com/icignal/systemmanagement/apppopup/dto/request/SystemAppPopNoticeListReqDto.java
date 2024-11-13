package com.icignal.systemmanagement.apppopup.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppPopNoticeListReqDto extends CommonCondReqDto{
	
	private String appPopLang;

	public String getAppPopLang() {
		return appPopLang;
	}

	public void setAppPopLang(String appPopLang) {
		this.appPopLang = appPopLang;
	}

}
