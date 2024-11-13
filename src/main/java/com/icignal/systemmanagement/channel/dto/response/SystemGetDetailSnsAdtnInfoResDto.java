package com.icignal.systemmanagement.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemGetDetailSnsAdtnInfoResDto extends GridPagingItemResDto{
	
	private String id;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	private String snsPageDesc;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSnsPageId() {
		return snsPageId;
	}
	public void setSnsPageId(String snsPageId) {
		this.snsPageId = snsPageId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAppSecurCode() {
		return appSecurCode;
	}
	public void setAppSecurCode(String appSecurCode) {
		this.appSecurCode = appSecurCode;
	}
	public String getSnsPageDesc() {
		return snsPageDesc;
	}
	public void setSnsPageDesc(String snsPageDesc) {
		this.snsPageDesc = snsPageDesc;
	}
}
