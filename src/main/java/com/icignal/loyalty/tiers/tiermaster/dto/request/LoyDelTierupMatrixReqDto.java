package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급채널 목록삭제DTO
 */
public class LoyDelTierupMatrixReqDto extends MKTGridPagingReqDto {
	
	private List<String> ridTierupMatrix;     			//RID
	private String ridTierGroup;     	//RID_TIER_GROUP
	
	public List<String> getRidTierupMatrix() {
		return ridTierupMatrix;
	}
	public void setRidTierupMatrix(List<String> ridTierupMatrix) {
		this.ridTierupMatrix = ridTierupMatrix;
	}
	public String getRidTierGroup() {
		return ridTierGroup;
	}
	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
	}

}