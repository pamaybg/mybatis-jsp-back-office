package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 *
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록조회DTO
 */

@CommCode
public class LoyGetTierGroupListResDto extends GridPagingItemResDto {

	private String rid;     			//RID
	private String ridPgm;     			//RID_PGM
	private String tierGrpNm;     		//등급 그룹 명
	private String famlRsltCocalcYn;   //가구 실적 합산 여부
	private String tierupCyclMmVal;    //승급 주기 월 값
	private String validPeriodMmVal;   //유효 기간 월 값
	private String rsltExtrPeriodMmVal;//실적 추출 기간 월 값
	private String ridTierDflt;     		//RID_등급 기본
	private String createDate;     		//CREATE_DATE
	private String createBy;     		//CREATE_BY
	private String tierNm;     			//등급 명
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
	private String useYn;
	private String baseYn;
	private String stnYn;
	private String aplyStartDd;
	@MarkName(groupCode="LOY_TIER_MST_STAT_CD" , codeField="statusCdNm")
	private String statusCd;
	private String statusCdNm; //상태
	private String tierupAplyMm;
	private String purCntMinAmt;
	private String tierupTxnTermsMm;
	
	//다이소 등급그룹
	private String pgmNm; //프로그램명
	private String name; //수정자
	private String modifyDate; //수정일시
	private String tierNotice; //등급 안내문구


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
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	public String getBaseYn() {
		return baseYn;
	}
	public void setBaseYn(String baseYn) {
		this.baseYn = baseYn;
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
	public String getTierupAplyMm() {
		return tierupAplyMm;
	}
	public void setTierupAplyMm(String tierupAplyMm) {
		this.tierupAplyMm = tierupAplyMm;
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
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getStatusCdNm() {
		return statusCdNm;
	}
	public void setStatusCdNm(String statusCdNm) {
		this.statusCdNm = statusCdNm;
	}
	public String getTierNotice() {
		return tierNotice;
	}
	public void setTierNotice(String tierNotice) {
		this.tierNotice = tierNotice;
	}



}