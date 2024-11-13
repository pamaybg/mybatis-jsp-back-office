package com.icignal.loyalty.tiers.tiermaster.dto.response;
import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹상세 목록조회DTO
 */
@CommCode
public class LoyGetTierBnftListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridTiers;     	
	private String tierBnftType1Cd;     	
	private String tierBnftType1Nm;     	
	private String tierBnftType2Cd;     	
	private String tierBnftType2Nm;     	
	private String tierBnftNm;     	
	private String splyCyclCd;     	
	private String splyCyclNm;     	
	private String tierBnftDesctxt;     	
	private String validStartDate;     	
	private String validEndDate;     	
	private String camId;     	
	private String camNm;     	
	private String createBy;     	
	private String createDate;
	
	private String dispNo;
	private String offerNo;
	private String offerNm;
	private int acrlAmt;
	private String modifyBy;
	private String modifyDate;
	
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
	public String getTierBnftType1Nm() {
		return tierBnftType1Nm;
	}
	public void setTierBnftType1Nm(String tierBnftType1Nm) {
		this.tierBnftType1Nm = tierBnftType1Nm;
	}
	public String getTierBnftType2Nm() {
		return tierBnftType2Nm;
	}
	public void setTierBnftType2Nm(String tierBnftType2Nm) {
		this.tierBnftType2Nm = tierBnftType2Nm;
	}
	public String getTierBnftNm() {
		return tierBnftNm;
	}
	public void setTierBnftNm(String tierBnftNm) {
		this.tierBnftNm = tierBnftNm;
	}
	public String getSplyCyclNm() {
		return splyCyclNm;
	}
	public void setSplyCyclNm(String splyCyclNm) {
		this.splyCyclNm = splyCyclNm;
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
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
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
	public String getSplyCyclCd() {
		return splyCyclCd;
	}
	public void setSplyCyclCd(String splyCyclCd) {
		this.splyCyclCd = splyCyclCd;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getOfferNo() {
		return offerNo;
	}
	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}
	public String getOfferNm() {
		return offerNm;
	}
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}
	public int getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(int acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	
	
}