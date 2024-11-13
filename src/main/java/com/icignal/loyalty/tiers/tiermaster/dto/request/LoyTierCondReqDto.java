package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.membership.tiers.dto.request.LOYTierCondRequestDTO
* @date : 2019. 4. 8.
* @author : hy.jun
* @description :
*/
public class LoyTierCondReqDto extends CommonDataAuthReqDto {
	private String ridTier;
	private String tierCd;
	private String tierNm;
	private String tierCdStatCd;
	private String type;
	
	private String dataStatus;
	
	private ArrayList<LoyTierCondDetailReqDto> tierCondDetail;
	private ArrayList<LoyTierCondDetailReqDto> tierCondDetailRemove;
	
	public String getRidTier() {
		return ridTier;
	}
	public void setRidTier(String ridTier) {
		this.ridTier = ridTier;
	}
	public ArrayList<LoyTierCondDetailReqDto> getTierCondDetail() {
		return tierCondDetail;
	}
	public void setTierCondDetail(ArrayList<LoyTierCondDetailReqDto> tierCondDetail) {
		this.tierCondDetail = tierCondDetail;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getTierCdStatCd() {
		return tierCdStatCd;
	}
	public void setTierCdStatCd(String tierCdStatCd) {
		this.tierCdStatCd = tierCdStatCd;
	}
	public ArrayList<LoyTierCondDetailReqDto> getTierCondDetailRemove() {
		return tierCondDetailRemove;
	}
	public void setTierCondDetailRemove(ArrayList<LoyTierCondDetailReqDto> tierCondDetailRemove) {
		this.tierCondDetailRemove = tierCondDetailRemove;
	}
	public String getDataStatus() {
		return dataStatus;
	}
	public void setDataStatus(String dataStatus) {
		this.dataStatus = dataStatus;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
