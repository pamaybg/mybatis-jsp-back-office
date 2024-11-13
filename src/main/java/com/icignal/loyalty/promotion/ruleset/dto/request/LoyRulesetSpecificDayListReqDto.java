package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyRulesetSpecificDayListReqDto extends CommonDataAuthReqDto {
	
	private String specificDay;			//특정일
	
	private String rulesetId;			//룰셋 아이디

	public String getSpecificDay() {
		return specificDay;
	}

	public void setSpecificDay(String specificDay) {
		this.specificDay = specificDay;
	}

	public String getRulesetId() {
		return rulesetId;
	}

	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
	}

}
