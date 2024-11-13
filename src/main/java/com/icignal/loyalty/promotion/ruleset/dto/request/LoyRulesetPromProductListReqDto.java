package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyRulesetPromProductListReqDto extends CommonDataAuthReqDto{
	private String gdsNam;
	private String etcSnam;
	private String etcCod;
	private String gdsNum;
	private String salePrc;
	private String barCod;
	private String prodRId;
	private String camRid;
	private String offerRid;
	private String rid;
	private String ruleSetProd;
	private String radio;
	
	public String getGdsNam() {
		return gdsNam;
	}
	public void setGdsNam(String gdsNam) {
		this.gdsNam = gdsNam;
	}
	public String getEtcSnam() {
		return etcSnam;
	}
	public void setEtcSnam(String etcSnam) {
		this.etcSnam = etcSnam;
	}
	public String getEtcCod() {
		return etcCod;
	}
	public void setEtcCod(String etcCod) {
		this.etcCod = etcCod;
	}
	public String getGdsNum() {
		return gdsNum;
	}
	public void setGdsNum(String gdsNum) {
		this.gdsNum = gdsNum;
	}
	public String getSalePrc() {
		return salePrc;
	}
	public void setSalePrc(String salePrc) {
		this.salePrc = salePrc;
	}
	public String getBarCod() {
		return barCod;
	}
	public void setBarCod(String barCod) {
		this.barCod = barCod;
	}
	public String getProdRId() {
		return prodRId;
	}
	public void setProdRId(String prodRId) {
		this.prodRId = prodRId;
	}
	public String getCamRid() {
		return camRid;
	}
	public void setCamRid(String camRid) {
		this.camRid = camRid;
	}
	public String getOfferRid() {
		return offerRid;
	}
	public void setOfferRid(String offerRid) {
		this.offerRid = offerRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRuleSetProd() {
		return ruleSetProd;
	}
	public void setRuleSetProd(String ruleSetProd) {
		this.ruleSetProd = ruleSetProd;
	}
	public String getRadio() {
		return radio;
	}
	public void setRadio(String radio) {
		this.radio = radio;
	}
	
	
}
