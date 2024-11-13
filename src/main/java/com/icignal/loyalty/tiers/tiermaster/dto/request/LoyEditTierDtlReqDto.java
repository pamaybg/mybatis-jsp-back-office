package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록수정DTO
 */
public class LoyEditTierDtlReqDto extends MKTGridPagingReqDto {
	
	private String rid;     			//RID
	private String ridTierGroup;     	//RID_TIER_GROUP
	private String tierCd;     			//등급 코드
	private String tierNm;     			//등급 명
	private String seqNo;     			//순서 번호
	private String validStartDate;     //유효 시작 일자
	private String validEndDate;     	//유효 종료 일자
	private String tierCdStatCd;     	//등급 코드 상태 코드
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
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
	public String getTierCdStatCd() {
		return tierCdStatCd;
	}
	public void setTierCdStatCd(String tierCdStatCd) {
		this.tierCdStatCd = tierCdStatCd;
	}

}