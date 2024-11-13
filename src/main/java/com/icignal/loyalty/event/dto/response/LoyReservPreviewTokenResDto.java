package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyReservPreviewTokenResDto extends StatusResDto{
	private String rid;			//RID
	private String ridMbr;		//회원 RID
	private String foUserId;	//FO 사용자 ID
	private String token;		//토큰
	private int validTime;		//유효시간
	private String validDt;		//유효일시
	private String url;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getFoUserId() {
		return foUserId;
	}
	public void setFoUserId(String foUserId) {
		this.foUserId = foUserId;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public int getValidTime() {
		return validTime;
	}
	public void setValidTime(int validTime) {
		this.validTime = validTime;
	}
	public String getValidDt() {
		return validDt;
	}
	public void setValidDt(String validDt) {
		this.validDt = validDt;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
