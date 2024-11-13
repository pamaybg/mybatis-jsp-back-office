package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
* @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetPaymentStandardListResponseDTO
* @date : 2018. 10. 17.
* @author : hy.jun
* @description :
*/
public class LoyRulesetPaymentStandardListResDto {
	private String rid;
	private String acrlTypeNm;
	private String acrlType;
	private String acrlAmt;
	private String cardType;
	private String cardTypeNm;
	private String rulesetId;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAcrlTypeNm() {
		return acrlTypeNm;
	}
	public void setAcrlTypeNm(String acrlTypeNm) {
		this.acrlTypeNm = acrlTypeNm;
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
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getRulesetId() {
		return rulesetId;
	}
	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
	}
	public String getCardTypeNm() {
		return cardTypeNm;
	}
	public void setCardTypeNm(String cardTypeNm) {
		this.cardTypeNm = cardTypeNm;
	}
}
