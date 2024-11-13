package com.icignal.systemmanagement.appversion.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemAppVerDetailResDto extends StatusResDto {

	private String appName;
	private String appOs;
	private String AppDistVer;
	private String AppMinVer;
	private String appSchema;
	private String os_Info;
	private String storeUrl;
	private String description;


	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public String getAppOs() {
		return appOs;
	}
	public void setAppOs(String appOs) {
		this.appOs = appOs;
	}
	public String getAppDistVer() {
		return AppDistVer;
	}
	public void setAppDistVer(String appDistVer) {
		AppDistVer = appDistVer;
	}
	public String getAppMinVer() {
		return AppMinVer;
	}
	public void setAppMinVer(String appMinVer) {
		AppMinVer = appMinVer;
	}
	public String getAppSchema() {
		return appSchema;
	}
	public void setAppSchema(String appSchema) {
		this.appSchema = appSchema;
	}
	public String getOs_Info() {
		return os_Info;
	}
	public void setOs_Info(String os_Info) {
		this.os_Info = os_Info;
	}
	public String getStoreUrl() {
		return storeUrl;
	}
	public void setStoreUrl(String storeUrl) {
		this.storeUrl = storeUrl;
	}



}
