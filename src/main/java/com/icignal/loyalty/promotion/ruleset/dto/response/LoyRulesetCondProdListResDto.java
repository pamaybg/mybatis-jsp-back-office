package com.icignal.loyalty.promotion.ruleset.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * RuleSet > 조건-상품 (탭) 목록 Response DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetCondProdListResponseDTO
 * @date : 2018. 07. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondProdListResDto  extends MKTBaseReqDto{

    private String rid;              //RID
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String rulesetId;        //룰셋헤더ID
    private String camRid;
    
    private String type;        	//제한유형
    private String prodType;        //상품코드유형
    private String prodCd;        	//상품코드
    private String prodNm;        	//상품이름
    private String prodRid;        	//상품rid

    private String typeNm;
    private String targetTypeNm;

    private String targetType;      //대상
    private String promoId;			//상품프로모션코드
    private String acrlAmt;			//적립금액/적립율
    private String minSalesAmt;		//적용 최소금액
    private String acrlType;		//정액/정률
    private String acrlTypeNm;		//정액정률 공통코드
    
	public String getPromoId() {
		return promoId;
	}
	public void setPromoId(String promoId) {
		this.promoId = promoId;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getMinSalesAmt() {
		return minSalesAmt;
	}
	public void setMinSalesAmt(String minSalesAmt) {
		this.minSalesAmt = minSalesAmt;
	}
	public String getAcrlType() {
		return acrlType;
	}
	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRulesetId() {
		return rulesetId;
	}
	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
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
	public String getTypeNm() {
		return typeNm;
	}
	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}
	public String getTargetTypeNm() {
		return targetTypeNm;
	}
	public void setTargetTypeNm(String targetTypeNm) {
		this.targetTypeNm = targetTypeNm;
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
	/**
	 * @return the acrlTypeNm
	 */
	public String getAcrlTypeNm() {
		return acrlTypeNm;
	}
	/**
	 * @param acrlTypeNm the acrlTypeNm to set
	 */
	public void setAcrlTypeNm(String acrlTypeNm) {
		this.acrlTypeNm = acrlTypeNm;
	}
	public String getCamRid() {
		return camRid;
	}
	public void setCamRid(String camRid) {
		this.camRid = camRid;
	}





}
