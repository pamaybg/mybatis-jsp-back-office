package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.membership.tiers.dto.request.LOYTierCondListRequestDTO
* @date : 2019. 4. 2.
* @author : hy.jun
* @description :
*/
public class LoyTierCondListReqDto extends CommonDataAuthReqDto {
	private String ridTierGroup;
	private String type;
	private String evtLimitTier;

	
	public String getEvtLimitTier() {
		return evtLimitTier;
	}

	public void setEvtLimitTier(String evtLimitTier) {
		this.evtLimitTier = evtLimitTier;
	}

	public String getRidTierGroup() {
		return ridTierGroup;
	}

	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
