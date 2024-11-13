package com.icignal.loyalty.tiers.membertier.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrTierHistListResponseDTO
* @date : 2019. 4. 18.
* @author : hy.jun
* @description : 회원상세 등급이력
*/
public class LoyMbrTierHistListResDto extends GridPagingItemResDto  {

	private static final long serialVersionUID = 2824623780357320621L;
	
	private String tierNm;
	private String tierCd;
	private String validStartDt;
	private String validEndDt;
	private String rsltExtrStartDt;
	private String rsltExtrEndDt;
	private String tierCalcDate;
	private String tierChgDesc;
	
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getValidStartDt() {
		return validStartDt;
	}
	public void setValidStartDt(String validStartDt) {
		this.validStartDt = validStartDt;
	}
	public String getValidEndDt() {
		return validEndDt;
	}
	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}
	public String getRsltExtrStartDt() {
		return rsltExtrStartDt;
	}
	public void setRsltExtrStartDt(String rsltExtrStartDt) {
		this.rsltExtrStartDt = rsltExtrStartDt;
	}
	public String getRsltExtrEndDt() {
		return rsltExtrEndDt;
	}
	public void setRsltExtrEndDt(String rsltExtrEndDt) {
		this.rsltExtrEndDt = rsltExtrEndDt;
	}
	public String getTierCalcDate() {
		return tierCalcDate;
	}
	public void setTierCalcDate(String tierCalcDate) {
		this.tierCalcDate = tierCalcDate;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getTierChgDesc() {
		return tierChgDesc;
	}
	public void setTierChgDesc(String tierChgDesc) {
		this.tierChgDesc = tierChgDesc;
	}
}
