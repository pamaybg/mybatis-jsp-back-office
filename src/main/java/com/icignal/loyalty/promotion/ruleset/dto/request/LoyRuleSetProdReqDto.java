package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYRuleSetProdRequestDTO.java
 * @date : 2016. 12. 12.
 * @author : dg.ryu
 * @description : ruleSet Prod RequestDTO
 */
public class LoyRuleSetProdReqDto extends CommonDataAuthReqDto {

	private String rid;               //RID
	private String ridMktCamMst;      //RID_캠페인마스터
	private String ridMktOfferMst;    //오퍼 아이디
	private String prodType;          //상품 유형
	private String brdId;             //브랜드 ID
	private String type;              //유형
	private String prodCate;          //상품 분류
	private String prodCd;            //상품 코드
	private String acrlType;          //적립 유형
	private String acrlAmt;           //적립 금액
	private String createDate;        //CREATE_DATE
	private String createByNm;        //CREATE_BY
	private String rulesetId;        //rulesetId
	
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getBrdId() {
        return brdId;
    }
    
    public void setBrdId(String brdId) {
        this.brdId = brdId;
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

	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProdCate() {
		return prodCate;
	}

	public void setProdCate(String prodCate) {
		this.prodCate = prodCate;
	}

	public String getProdCd() {
		return prodCd;
	}

	public void setProdCd(String prodCd) {
		this.prodCd = prodCd;
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

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

	public String getRulesetId() {
		return rulesetId;
	}

	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
	}

	
}