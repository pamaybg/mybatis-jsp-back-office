package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPromProdListReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String ruleSetProdRid;
	private String etcCod;
	private String etcSname;
	private String gdsNum;
	private String gdsNam;
	private String salePrc;
	
	public String getEtcCod() {
		return etcCod;
	}

	public void setEtcCod(String etcCod) {
		this.etcCod = etcCod;
	}

	public String getEtcSname() {
		return etcSname;
	}

	public void setEtcSname(String etcSname) {
		this.etcSname = etcSname;
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

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRuleSetProdRid() {
		return ruleSetProdRid;
	}

	public void setRuleSetProdRid(String ruleSetProdRid) {
		this.ruleSetProdRid = ruleSetProdRid;
	}
	
}
