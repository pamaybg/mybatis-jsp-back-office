package com.icignal.systemmanagement.appversion.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppVerInsertReqDto extends CommonCondReqDto {

	private String appVerId;
	private String appName;
	private String appOs;
	private String AppDistVer;
	private String AppMinVer;
	private String storeType;
	private String appSchema;
	private String os_Info;
	private Boolean updateFlag;
	private String storeUrl;

	private String serviceId;
	private String versionId;
	private String description;


	public String getAppVerId() {
		return appVerId;
	}
	public void setAppVerId(String appVerId) {
		this.appVerId = appVerId;
	}
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
	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
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
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getStoreUrl() {
		return storeUrl;
	}
	public void setStoreUrl(String storeUrl) {
		this.storeUrl = storeUrl;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getVersionId() {
		return versionId;
	}
	public void setVersionId(String versionId) {
		this.versionId = versionId;
	}



}
