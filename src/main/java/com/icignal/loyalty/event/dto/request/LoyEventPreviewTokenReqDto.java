package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyEventPreviewTokenReqDto extends CommonDataAuthReqDto {
	
	private String rid;			//RID
	private String ridMbr;		//회원 RID
	private String foUserId;	//FO 사용자 ID
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
	
}
