package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

public class LoyReservPreviewTokenReqDto extends BaseReqDto{
	private String rid;			//RID
	private String ridMbr;		//회원RID
	private String foUSerId;	//FO 사용자 ID
	private String token;		//토큰
	private int validTime;		//유효시간
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
	public String getFoUSerId() {
		return foUSerId;
	}
	public void setFoUSerId(String foUSerId) {
		this.foUSerId = foUSerId;
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
	
	
}
