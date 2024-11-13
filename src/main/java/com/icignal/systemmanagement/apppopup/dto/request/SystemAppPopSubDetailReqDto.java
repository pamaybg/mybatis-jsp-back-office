package com.icignal.systemmanagement.apppopup.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppPopSubDetailReqDto extends CommonCondReqDto {
	
	private String appPopId;
	private String appPopLang;
	
	public String getAppPopId() {
		return appPopId;
	}
	public void setAppPopId(String appPopId) {
		this.appPopId = appPopId;
	}
	public String getAppPopLang() {
		return appPopLang;
	}
	public void setAppPopLang(String appPopLang) {
		this.appPopLang = appPopLang;
	}
	
	

}
