package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYRuleSetLimitRequestDTO.java
 * @date : 2016. 12. 12.
 * @author : dg.ryu
 * @description : ruleSet 제한 RequestDTO
 */
public class LoyRuleSetLimitReq extends CommonDataAuthReqDto {

	private String rid;              //RID
	private String ridMktCamMst;     //RID_캠페인마스터
	private String ridBrdCate;       //RID 브랜드 카테고리
	private String ridChnl;          //RID 채널
	private String type;             //제한 유형
	private String chnlType;         //채널 유형
	private String brdCd;            //브랜드 코드
	private String distrbnetType;    //유통망 유형
	private String chnlCd;           //채널 코드
	private String cardType;         //카드 유형
    private String allianCardYn;     //제휴 카드 여부
    private String rulesetId;
    
    private String ouTypeCd;         //가맹점 유형
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getOuTypeCd() {
        return ouTypeCd;
    }

    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }

    public String getRulesetId() {
        return rulesetId;
    }

    public void setRulesetId(String rulesetId) {
        this.rulesetId = rulesetId;
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

	public String getRidBrdCate() {
		return ridBrdCate;
	}

	public void setRidBrdCate(String ridBrdCate) {
		this.ridBrdCate = ridBrdCate;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}

	public String getBrdCd() {
		return brdCd;
	}

	public void setBrdCd(String brdCd) {
		this.brdCd = brdCd;
	}

	public String getDistrbnetType() {
		return distrbnetType;
	}

	public void setDistrbnetType(String distrbnetType) {
		this.distrbnetType = distrbnetType;
	}

	public String getChnlCd() {
		return chnlCd;
	}

	public void setChnlCd(String chnlCd) {
		this.chnlCd = chnlCd;
	}

	public String getCardType() {
		return cardType;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public String getAllianCardYn() {
		return allianCardYn;
	}

	public void setAllianCardYn(String allianCardYn) {
		this.allianCardYn = allianCardYn;
	}

}
