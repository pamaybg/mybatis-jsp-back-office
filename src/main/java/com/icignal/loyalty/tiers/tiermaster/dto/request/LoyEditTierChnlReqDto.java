package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급 채널 목록수정DTO
 */
public class LoyEditTierChnlReqDto extends MKTGridPagingReqDto {
	
	private List<String> rid;     			//RID
	private String ridChnl;      
	private String ridTierGroup; 
	private List<String> subInclYn;
	
	public List<String> getRid() {
		return rid;
	}
	public void setRid(List<String> rid) {
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
	public List<String> getSubInclYn() {
		return subInclYn;
	}
	public void setSubInclYn(List<String> subInclYn) {
		this.subInclYn = subInclYn;
	}

}