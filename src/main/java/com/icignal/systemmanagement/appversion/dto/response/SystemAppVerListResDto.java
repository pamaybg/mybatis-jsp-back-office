package com.icignal.systemmanagement.appversion.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemAppVerListResDto extends GridPagingItemResDto {

	private String id;
	private String appName;
	private String storeName;
	private String distributeVer;
	private String minVer;
	private String appRegDate;
	private String appUpdateDate;
	private String description;

	private String serviceId;


	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getDistributeVer() {
		return distributeVer;
	}
	public void setDistributeVer(String distributeVer) {
		this.distributeVer = distributeVer;
	}
	public String getMinVer() {
		return minVer;
	}
	public void setMinVer(String minVer) {
		this.minVer = minVer;
	}
	public String getAppRegDate() {
		return appRegDate;
	}
	public void setAppRegDate(String appRegDate) {
		this.appRegDate = appRegDate;
	}
	public String getAppUpdateDate() {
		return appUpdateDate;
	}
	public void setAppUpdateDate(String appUpdateDate) {
		this.appUpdateDate = appUpdateDate;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}




}
