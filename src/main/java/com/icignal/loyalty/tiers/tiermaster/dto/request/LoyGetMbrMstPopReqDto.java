package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록조회DTO
 */
public class LoyGetMbrMstPopReqDto extends CommonDataAuthReqDto {
	
	private String  rid;
	private String  ridChnl;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

}