package com.icignal.loyalty.promotion.ruleset.dto.response;

public class LoyRulesetSpecificDayListResDto {

	private String specificDay;			//특정일
	private String rulesetId;
	private String specificDayName;

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

	public String getSpecificDayName() {
		return specificDayName;
	}

	public void setSpecificDayName(String specificDayName) {
		this.specificDayName = specificDayName;
	}


}
