package com.icignal.loyalty.promotion.ruleset.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : LOYRuleSetMstRequestDTO.java
 * @date : 2016. 12. 12.
 * @author : dg.ryu
 * @description : ruleSet ResponseDTO
 */
public class LoyRuleSetMstResDto extends MKTBaseReqDto {

	private String rid;               //RID
	private String ridMktCamMst;      //RID_캠페인마스터
	private String ridMktOfferMst;    //오퍼 아이디
	private String type;              //RULESET 유형
	private String ridTiers;          //RID_등급
	private String clubCd;            //클럽 코드
	private String minAmt;            //최소 금액
	private String maxAmt;            //최대 금액
	private String acrlType;          //적립 유형
	private String acrlTypeNm;        //적립 유형명
	private String acrlAmt;           //적립 금액
	private String tierNm;			   //등급명
	private String tierCd;			   //등급코드
	
	private String modifyDate;
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRidTiers() {
		return ridTiers;
	}

	public void setRidTiers(String ridTiers) {
		this.ridTiers = ridTiers;
	}

	public String getClubCd() {
		return clubCd;
	}

	public void setClubCd(String clubCd) {
		this.clubCd = clubCd;
	}

	public String getMinAmt() {
		return minAmt;
	}

	public void setMinAmt(String minAmt) {
		this.minAmt = minAmt;
	}

	public String getMaxAmt() {
		return maxAmt;
	}

	public void setMaxAmt(String maxAmt) {
		this.maxAmt = maxAmt;
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

	public String getAcrlTypeNm() {
		return acrlTypeNm;
	}

	public void setAcrlTypeNm(String acrlTypeNm) {
		this.acrlTypeNm = acrlTypeNm;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getTierCd() {
		return tierCd;
	}

	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}


}
