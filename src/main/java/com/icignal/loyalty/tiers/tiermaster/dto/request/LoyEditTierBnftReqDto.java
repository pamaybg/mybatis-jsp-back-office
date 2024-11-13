package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록저장DTO
 */
public class LoyEditTierBnftReqDto extends MKTGridPagingReqDto {
	
	private String rid;     			//RID
	private String ridTiers;     	
	private String tierBnftType1Cd;     	
	private String tierBnftType2Cd;     	
	private String tierBnftNm;     	
	private String splyCyclCd;     	
	private String tierBnftDesctxt;     	
	private String validStartDate;     	
	private String validEndDate;     	
	private String ridCampMst;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidTiers() {
		return ridTiers;
	}
	public void setRidTiers(String ridTiers) {
		this.ridTiers = ridTiers;
	}
	public String getTierBnftType1Cd() {
		return tierBnftType1Cd;
	}
	public void setTierBnftType1Cd(String tierBnftType1Cd) {
		this.tierBnftType1Cd = tierBnftType1Cd;
	}
	public String getTierBnftType2Cd() {
		return tierBnftType2Cd;
	}
	public void setTierBnftType2Cd(String tierBnftType2Cd) {
		this.tierBnftType2Cd = tierBnftType2Cd;
	}
	public String getTierBnftNm() {
		return tierBnftNm;
	}
	public void setTierBnftNm(String tierBnftNm) {
		this.tierBnftNm = tierBnftNm;
	}
	public String getSplyCyclCd() {
		return splyCyclCd;
	}
	public void setSplyCyclCd(String splyCyclCd) {
		this.splyCyclCd = splyCyclCd;
	}
	public String getTierBnftDesctxt() {
		return tierBnftDesctxt;
	}
	public void setTierBnftDesctxt(String tierBnftDesctxt) {
		this.tierBnftDesctxt = tierBnftDesctxt;
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
	public String getRidCampMst() {
		return ridCampMst;
	}
	public void setRidCampMst(String ridCampMst) {
		this.ridCampMst = ridCampMst;
	}    
	
}