package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 룰셋 > 지급정책 (탭) 목록 조회 Request DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetPymntPolicyListRequestDTO
 * @date : 2018. 7. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetPymntPolicyListReqDto extends CommonDataAuthReqDto {

    private String rid;
    private String rulesetId;
    private String tierRid;
    private String custGradeCd;
    private String acrlAmt;
    private String acrlType;
    
    private String ridMktCamMst;
    private String ridMktOfferMst;

    
    private String mbrCnt;		//인원
    private String minAmt;	//구매금액
    private String minCnt;	//구매횟수

 
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
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getCustGradeCd() {
		return custGradeCd;
	}
	public void setCustGradeCd(String custGradeCd) {
		this.custGradeCd = custGradeCd;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getAcrlType() {
		return acrlType;
	}
	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}
	public String getRidMktCamMst() {
		return ridMktCamMst;
	}
	public void setRidMktCamMst(String ridMktCamMst) {
		this.ridMktCamMst = ridMktCamMst;
	}
	public String getRidMktOfferMst() {
		return ridMktOfferMst;
	}
	public void setRidMktOfferMst(String ridMktOfferMst) {
		this.ridMktOfferMst = ridMktOfferMst;
	}
	public String getMbrCnt() {
		return mbrCnt;
	}
	public void setMbrCnt(String mbrCnt) {
		this.mbrCnt = mbrCnt;
	}
	public String getMinAmt() {
		return minAmt;
	}
	public void setMinAmt(String minAmt) {
		this.minAmt = minAmt;
	}
	public String getMinCnt() {
		return minCnt;
	}
	public void setMinCnt(String minCnt) {
		this.minCnt = minCnt;
	}
	


}
