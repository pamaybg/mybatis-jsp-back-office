package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class MktGetFacebookPageInfoReqDto extends MKTGridPagingReqDto{
	
	private String fbId;
	private String snsPageId;
	private String appId;
	private String appSecurCode;
	private String shortLivedToken;
	private String longLivedToken;
	private String expiresIn;
	
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
	public String getFbId() {
		return fbId;
	}
	public void setFbId(String fbId) {
		this.fbId = fbId;
	}
	public String getShortLivedToken() {
		return shortLivedToken;
	}
	public void setShortLivedToken(String shortLivedToken) {
		this.shortLivedToken = shortLivedToken;
	}
	public String getLongLivedToken() {
		return longLivedToken;
	}
	public void setLongLivedToken(String longLivedToken) {
		this.longLivedToken = longLivedToken;
	}
	public String getExpiresIn() {
		return expiresIn;
	}
	public void setExpiresIn(String expiresIn) {
		this.expiresIn = expiresIn;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
}
