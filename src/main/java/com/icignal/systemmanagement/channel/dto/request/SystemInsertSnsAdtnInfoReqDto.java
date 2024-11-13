package com.icignal.systemmanagement.channel.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemInsertSnsAdtnInfoReqDto extends GridPagingReqDto {
	
	private String id;
	private String mktChnlId;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	private String snsPageDesc;
	private String memId;
	
	
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
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMktChnlId() {
		return mktChnlId;
	}
	public void setMktChnlId(String mktChnlId) {
		this.mktChnlId = mktChnlId;
	}
}
