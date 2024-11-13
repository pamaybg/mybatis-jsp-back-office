/**
 *
 */
package com.icignal.loyalty.tiers.membertier.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;



/**
  * @fileName : LoyMbrTierHistResponseDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 5.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 등급이력 응답 DTO
  *
  */
public class LoyMbrTierListResDto  extends GridPagingItemResDto {

	private String rsltCd;
	private String rsltDtlCd;
	private String rsltMsg;
	
	private String ridTier;
	private String ridTierGroup;
	private String ridTierDflt;
	private String tierCd ;
	private String seqNo;
	private String validStartDate;
	private String validEndDate;
	private Integer validPeriodMmVal;
	
	
	
	
	
	
	public String getRsltCd() {
		return rsltCd;
	}
	public void setRsltCd(String rsltCd) {
		this.rsltCd = rsltCd;
	}
	public String getRsltDtlCd() {
		return rsltDtlCd;
	}
	public void setRsltDtlCd(String rsltDtlCd) {
		this.rsltDtlCd = rsltDtlCd;
	}
	public String getRsltMsg() {
		return rsltMsg;
	}
	public void setRsltMsg(String rsltMsg) {
		this.rsltMsg = rsltMsg;
	}
	public String getRidTier() {
		return ridTier;
	}
	public void setRidTier(String ridTier) {
		this.ridTier = ridTier;
	}
	public String getRidTierGroup() {
		return ridTierGroup;
	}
	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getValidStartDate() {
		return validStartDate;
	}
	public void setValidStartDate(String validStartDate) {
		this.validStartDate = validStartDate;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getRidTierDflt() {
		return ridTierDflt;
	}
	public void setRidTierDflt(String ridTierDflt) {
		this.ridTierDflt = ridTierDflt;
	}
	public Integer getValidPeriodMmVal() {
		return validPeriodMmVal;
	}
	public void setValidPeriodMmVal(Integer validPeriodMmVal) {
		this.validPeriodMmVal = validPeriodMmVal;
	}
	
	
	



}
