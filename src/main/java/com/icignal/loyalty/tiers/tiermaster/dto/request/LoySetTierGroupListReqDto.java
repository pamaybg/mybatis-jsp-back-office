package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록저장DTO
 */
public class LoySetTierGroupListReqDto extends MKTGridPagingReqDto {
	
	private String rid;     				//RID
	private String ridPgm;     				//RID_PGM
	private String tierGrpNm;     			//등급 그룹 명
	private String famlRsltCocalcYn;     	//가구 실적 합산 여부
	private String tierupCyclMmVal;     	//승급 주기 월 값
	private String validPeriodMmVal;     	//유효 기간 월 값
	private String rsltExtrPeriodMmVal;    //실적 추출 기간 월 값
	private String ridTierDflt;     			//RID_등급 기본
	private String tierupRuleBasType;
	private String tierupAply1myn;
	private String tierupAply2myn;
	private String tierupAply3myn;
	private String tierupAply4myn;
	private String tierupAply5myn;
	private String tierupAply6myn;
	private String tierupAply7myn;
	private String tierupAply8myn;
	private String tierupAply9myn;
	private String tierupAply10myn;
	private String tierupAply11myn;
	private String tierupAply12myn;
	private String tierupAplyMm;
	
	private String useYn;
	private String stnYn;
	private String aplyStartDd;
	private String statusCd;
	
	private String purCntMinAmt; 		//방문횟수 최소금액
	private String tierupTxnTermsMm; 	//승급심사 실적 기간월
	private String tierNotice;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getTierGrpNm() {
		return tierGrpNm;
	}
	public void setTierGrpNm(String tierGrpNm) {
		this.tierGrpNm = tierGrpNm;
	}
	public String getFamlRsltCocalcYn() {
		return famlRsltCocalcYn;
	}
	public void setFamlRsltCocalcYn(String famlRsltCocalcYn) {
		this.famlRsltCocalcYn = famlRsltCocalcYn;
	}
	public String getTierupCyclMmVal() {
		return tierupCyclMmVal;
	}
	public void setTierupCyclMmVal(String tierupCyclMmVal) {
		this.tierupCyclMmVal = tierupCyclMmVal;
	}
	public String getValidPeriodMmVal() {
		return validPeriodMmVal;
	}
	public void setValidPeriodMmVal(String validPeriodMmVal) {
		this.validPeriodMmVal = validPeriodMmVal;
	}
	public String getRsltExtrPeriodMmVal() {
		return rsltExtrPeriodMmVal;
	}
	public void setRsltExtrPeriodMmVal(String rsltExtrPeriodMmVal) {
		this.rsltExtrPeriodMmVal = rsltExtrPeriodMmVal;
	}
	public String getRidTierDflt() {
		return ridTierDflt;
	}
	public void setRidTierDflt(String ridTierDflt) {
		this.ridTierDflt = ridTierDflt;
	}
	public String getTierupRuleBasType() {
		return tierupRuleBasType;
	}
	public void setTierupRuleBasType(String tierupRuleBasType) {
		this.tierupRuleBasType = tierupRuleBasType;
	}
	public String getTierupAply1myn() {
		return tierupAply1myn;
	}
	public void setTierupAply1myn(String tierupAply1myn) {
		this.tierupAply1myn = tierupAply1myn;
	}
	public String getTierupAply2myn() {
		return tierupAply2myn;
	}
	public void setTierupAply2myn(String tierupAply2myn) {
		this.tierupAply2myn = tierupAply2myn;
	}
	public String getTierupAply3myn() {
		return tierupAply3myn;
	}
	public void setTierupAply3myn(String tierupAply3myn) {
		this.tierupAply3myn = tierupAply3myn;
	}
	public String getTierupAply4myn() {
		return tierupAply4myn;
	}
	public void setTierupAply4myn(String tierupAply4myn) {
		this.tierupAply4myn = tierupAply4myn;
	}
	public String getTierupAply5myn() {
		return tierupAply5myn;
	}
	public void setTierupAply5myn(String tierupAply5myn) {
		this.tierupAply5myn = tierupAply5myn;
	}
	public String getTierupAply6myn() {
		return tierupAply6myn;
	}
	public void setTierupAply6myn(String tierupAply6myn) {
		this.tierupAply6myn = tierupAply6myn;
	}
	public String getTierupAply7myn() {
		return tierupAply7myn;
	}
	public void setTierupAply7myn(String tierupAply7myn) {
		this.tierupAply7myn = tierupAply7myn;
	}
	public String getTierupAply8myn() {
		return tierupAply8myn;
	}
	public void setTierupAply8myn(String tierupAply8myn) {
		this.tierupAply8myn = tierupAply8myn;
	}
	public String getTierupAply9myn() {
		return tierupAply9myn;
	}
	public void setTierupAply9myn(String tierupAply9myn) {
		this.tierupAply9myn = tierupAply9myn;
	}
	public String getTierupAply10myn() {
		return tierupAply10myn;
	}
	public void setTierupAply10myn(String tierupAply10myn) {
		this.tierupAply10myn = tierupAply10myn;
	}
	public String getTierupAply11myn() {
		return tierupAply11myn;
	}
	public void setTierupAply11myn(String tierupAply11myn) {
		this.tierupAply11myn = tierupAply11myn;
	}
	public String getTierupAply12myn() {
		return tierupAply12myn;
	}
	public void setTierupAply12myn(String tierupAply12myn) {
		this.tierupAply12myn = tierupAply12myn;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getStnYn() {
		return stnYn;
	}
	public void setStnYn(String stnYn) {
		this.stnYn = stnYn;
	}
	public String getAplyStartDd() {
		return aplyStartDd;
	}
	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getPurCntMinAmt() {
		return purCntMinAmt;
	}
	public void setPurCntMinAmt(String purCntMinAmt) {
		this.purCntMinAmt = purCntMinAmt;
	}
	public String getTierupTxnTermsMm() {
		return tierupTxnTermsMm;
	}
	public void setTierupTxnTermsMm(String tierupTxnTermsMm) {
		this.tierupTxnTermsMm = tierupTxnTermsMm;
	}
	public String getTierupAplyMm() {
		return tierupAplyMm;
	}
	public void setTierupAplyMm(String tierupAplyMm) {
		this.tierupAplyMm = tierupAplyMm;
	}
	public String getTierNotice() {
		return tierNotice;
	}
	public void setTierNotice(String tierNotice) {
		this.tierNotice = tierNotice;
	}

	
	
	
}