package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetCondTimeListRequestDTO
* @date : 2018. 10. 15.
* @author : hy.jun
* @description :
*/
public class LoyRulesetCondTimeListReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String rulesetId;
	private String startTime;
	private String endTime;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRulesetId() {
		return rulesetId;
	}
	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}
