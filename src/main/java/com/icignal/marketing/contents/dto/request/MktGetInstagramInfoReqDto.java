package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class MktGetInstagramInfoReqDto extends MKTGridPagingReqDto{
	
	private String id;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	
	private String memId;
	
	
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
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
