package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetPaymentStandardListRequestDTO
* @date : 2018. 10. 17.
* @author : hy.jun
* @description :
*/
public class LoyRulesetPaymentStandardListReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String rulesetId;
	private String cardType;
	private String acrlType;
	private String acrlAmt;
	
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
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getAcrlType() {
		return acrlType;
	}
	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
}
