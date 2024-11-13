package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrTierBenefitHistResDto extends GridPagingItemResDto {
	// 필드
	private String rid;                     
	private String ridMbr;                  
	private String ridTiersBnft;            
	private String ridOfr;           
	private String ofrTypeCd;               
	private String ofrTypeCdNm;             
	private String ofrSubType;            
	private String ofrSubTypeNm;            
	private String tierBnftTypeCd;          
	private String tierBnftTypeCdNm;        
	private String bnftActCycleCd;          
	private String bnftActCycleCdNm;        
	private String bnftActRotCycleCd;       
	private String bnftActRotCycleCdNm;     
	private String payYear;                 
	private String payMonth;                
	private String payDay;
	private String cpnYn;
	private String ofrNo;
	private String ofrNm;
	private String amt;          
	private String qty;
	private String ofrValType;   
	private String ofrValAmt;    
	private String createDate;   
	private String createBy;     
	private String modifyDate;   
	private String modifyBy;     
	//private String tierRid;                                    
	
	private String combinedBnftActCycleNm;	
	
	
	
	// 게터세터
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidTiersBnft() {
		return ridTiersBnft;
	}
	public void setRidTiersBnft(String ridTiersBnft) {
		this.ridTiersBnft = ridTiersBnft;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getOfrTypeCd() {
		return ofrTypeCd;
	}
	public void setOfrTypeCd(String ofrTypeCd) {
		this.ofrTypeCd = ofrTypeCd;
	}
	public String getOfrTypeCdNm() {
		return ofrTypeCdNm;
	}
	public void setOfrTypeCdNm(String ofrTypeCdNm) {
		this.ofrTypeCdNm = ofrTypeCdNm;
	}
	public String getOfrSubType() {
		return ofrSubType;
	}
	public void setOfrSubType(String ofrSubType) {
		this.ofrSubType = ofrSubType;
	}
	public String getOfrSubTypeNm() {
		return ofrSubTypeNm;
	}
	public void setOfrSubTypeNm(String ofrSubTypeNm) {
		this.ofrSubTypeNm = ofrSubTypeNm;
	}
	public String getTierBnftTypeCd() {
		return tierBnftTypeCd;
	}
	public void setTierBnftTypeCd(String tierBnftTypeCd) {
		this.tierBnftTypeCd = tierBnftTypeCd;
	}
	public String getTierBnftTypeCdNm() {
		return tierBnftTypeCdNm;
	}
	public void setTierBnftTypeCdNm(String tierBnftTypeCdNm) {
		this.tierBnftTypeCdNm = tierBnftTypeCdNm;
	}
	public String getBnftActCycleCd() {
		return bnftActCycleCd;
	}
	public void setBnftActCycleCd(String bnftActCycleCd) {
		this.bnftActCycleCd = bnftActCycleCd;
	}
	public String getBnftActCycleCdNm() {
		return bnftActCycleCdNm;
	}
	public void setBnftActCycleCdNm(String bnftActCycleCdNm) {
		this.bnftActCycleCdNm = bnftActCycleCdNm;
	}
	public String getBnftActRotCycleCd() {
		return bnftActRotCycleCd;
	}
	public void setBnftActRotCycleCd(String bnftActRotCycleCd) {
		this.bnftActRotCycleCd = bnftActRotCycleCd;
	}
	public String getBnftActRotCycleCdNm() {
		return bnftActRotCycleCdNm;
	}
	public void setBnftActRotCycleCdNm(String bnftActRotCycleCdNm) {
		this.bnftActRotCycleCdNm = bnftActRotCycleCdNm;
	}
	public String getPayYear() {
		return payYear;
	}
	public void setPayYear(String payYear) {
		this.payYear = payYear;
	}
	public String getPayMonth() {
		return payMonth;
	}
	public void setPayMonth(String payMonth) {
		this.payMonth = payMonth;
	}
	public String getPayDay() {
		return payDay;
	}
	public void setPayDay(String payDay) {
		this.payDay = payDay;
	}
	public String getCpnYn() {
		return cpnYn;
	}
	public void setCpnYn(String cpnYn) {
		this.cpnYn = cpnYn;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getAmt() {
		return amt;
	}
	public void setAmt(String amt) {
		this.amt = amt;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getCombinedBnftActCycleNm() {
		return combinedBnftActCycleNm;
	}
	public void setCombinedBnftActCycleNm(String combinedBnftActCycleNm) {
		this.combinedBnftActCycleNm = combinedBnftActCycleNm;
	}
//	public String getTierRid() {
//		return tierRid;
//	}
//	public void setTierRid(String tierRid) {
//		this.tierRid = tierRid;
//	}
		
}
