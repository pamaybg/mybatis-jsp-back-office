package com.icignal.loyalty.promotion.ruleset.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyPromProdListResDto extends GridPagingItemResDto{
	
	private String rid;
	private String etcCod;
	private String etcSnam;
	private String gdsNum;
	private String gdsNam;
	private String salePrc;
	private String barCod;
	private String camRid;
	private String ruleSetProd;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEtcCod() {
		return etcCod;
	}
	public void setEtcCod(String etcCod) {
		this.etcCod = etcCod;
	}
	public String getEtcSnam() {
		return etcSnam;
	}
	public void setEtcSname(String etcSnam) {
		this.etcSnam = etcSnam;
	}
	public String getGdsNum() {
		return gdsNum;
	}
	public void setGdsNum(String gdsNum) {
		this.gdsNum = gdsNum;
	}
	public String getGdsNam() {
		return gdsNam;
	}
	public void setGdsNam(String gdsNam) {
		this.gdsNam = gdsNam;
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
	public String getCamRid() {
		return camRid;
	}
	public void setCamRid(String camRid) {
		this.camRid = camRid;
	}
	public String getRuleSetProd() {
		return ruleSetProd;
	}
	public void setRuleSetProd(String ruleSetProd) {
		this.ruleSetProd = ruleSetProd;
	}
	
	
}
