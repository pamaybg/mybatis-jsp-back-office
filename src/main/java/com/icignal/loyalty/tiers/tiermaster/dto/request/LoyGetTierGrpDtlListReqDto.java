package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹상세 목록조회DTO
 */
public class LoyGetTierGrpDtlListReqDto extends CommonDataAuthReqDto {
	
	private String  tiersRid;
	private String  ridTierGroup;
	
	public String getTiersRid() {
		return tiersRid;
	}
	public void setTiersRid(String tiersRid) {
		this.tiersRid = tiersRid;
	}
	public String getRidTierGroup() {
		return ridTierGroup;
	}
	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
	}
	
}