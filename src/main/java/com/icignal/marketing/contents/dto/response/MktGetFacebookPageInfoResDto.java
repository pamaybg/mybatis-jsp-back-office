package com.icignal.marketing.contents.dto.response;

public class MktGetFacebookPageInfoResDto {
	
	private String id;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	private String snsPageDesc;
	private String acesToken;
	private String acesExpDt;
	 
	 
	public String getAcesToken() {
		return acesToken;
	}
	public void setAcesToken(String acesToken) {
		this.acesToken = acesToken;
	}
	public String getAcesExpDt() {
		return acesExpDt;
	}
	public void setAcesExpDt(String acesExpDt) {
		this.acesExpDt = acesExpDt;
	}
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
