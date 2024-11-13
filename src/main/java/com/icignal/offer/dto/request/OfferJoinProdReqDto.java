package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OfferJoinProdReqDto extends CommonDataAuthReqDto {

	// 시스템
	private String rid;

	// 릴레이션
	private String ridSupplyProd;
	private String ridOfrgrpSel;
	private String ridStmp;
	private String prodLimitYn;
	private String chnlLimitYn;
	
	// 코드
	private String ridOfr;
	private String ridProdM;
	private String relTypeCd;
	
	private String prodUseType;
	private String prodUseTypeDup;
	
	public String getProdUseType() {
		return prodUseType;
	}
	public void setProdUseType(String prodUseType) {
		this.prodUseType = prodUseType;
	}
	//getter, setter
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidSupplyProd() {
		return ridSupplyProd;
	}
	public void setRidSupplyProd(String ridSupplyProd) {
		this.ridSupplyProd = ridSupplyProd;
	}
	public String getRidOfrgrpSel() {
		return ridOfrgrpSel;
	}
	public void setRidOfrgrpSel(String ridOfrgrpSel) {
		this.ridOfrgrpSel = ridOfrgrpSel;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidProdM() {
		return ridProdM;
	}
	public void setRidProdM(String ridProdM) {
		this.ridProdM = ridProdM;
	}
	public String getRelTypeCd() {
		return relTypeCd;
	}
	public void setRelTypeCd(String relTypeCd) {
		this.relTypeCd = relTypeCd;
	}
	public String getProdLimitYn() {
		return prodLimitYn;
	}
	public void setProdLimitYn(String prodLimitYn) {
		this.prodLimitYn = prodLimitYn;
	}
	public String getChnlLimitYn() {
		return chnlLimitYn;
	}
	public void setChnlLimitYn(String chnlLimitYn) {
		this.chnlLimitYn = chnlLimitYn;
	}
	public String getProdUseTypeDup() {
		return prodUseTypeDup;
	}
	public void setProdUseTypeDup(String prodUseTypeDup) {
		this.prodUseTypeDup = prodUseTypeDup;
	}
}
