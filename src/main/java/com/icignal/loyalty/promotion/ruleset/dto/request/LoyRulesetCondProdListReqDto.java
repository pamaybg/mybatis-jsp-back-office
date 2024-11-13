package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 룰셋 > 조건 상품 (탭) 목록 조회 Request DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetCondProdListRequestDTO
 * @date : 2018. 7. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondProdListReqDto extends MKTBaseReqDto {

    private String id;
    private String rulesetId;
    private String rid;
    private String type;
    private String prodType;
    private String targetType;
    private String prodCd;
    private String prodNm;        	//상품이름
    private String prodRid;        	//상품rid
    private String ridMktCamMst;
    private String acrlType;
    private String minSalesAmt;
    private String acrlAmt;
    private String acrlTypeNm;
    private String ruleSetProd;
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getProdCd() {
		return prodCd;
	}
	public void setProdCd(String prodCd) {
		this.prodCd = prodCd;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getProdRid() {
		return prodRid;
	}
	public void setProdRid(String prodRid) {
		this.prodRid = prodRid;
	}
	public String getRidMktCamMst() {
		return ridMktCamMst;
	}
	public void setRidMktCamMst(String ridMktCamMst) {
		this.ridMktCamMst = ridMktCamMst;
	}
	public String getAcrlType() {
		return acrlType;
	}
	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}
	public String getMinSalesAmt() {
		return minSalesAmt;
	}
	public void setMinSalesAmt(String minSalesAmt) {
		this.minSalesAmt = minSalesAmt;
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
	public String getRuleSetProd() {
		return ruleSetProd;
	}
	public void setRuleSetProd(String ruleSetProd) {
		this.ruleSetProd = ruleSetProd;
	}



}
