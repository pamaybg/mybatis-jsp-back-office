package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급 채널 목록수정DTO
 */
public class LoySetTierChnlReqDto extends MKTGridPagingReqDto {
	
	private String rid;     			//RID
	private String ridChnl;      
	private String ridTierGroup; 
	private String subInclYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getRidTierGroup() {
		return ridTierGroup;
	}
	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
	}
	public String getSubInclYn() {
		return subInclYn;
	}
	public void setSubInclYn(String subInclYn) {
		this.subInclYn = subInclYn;
	}
	
}