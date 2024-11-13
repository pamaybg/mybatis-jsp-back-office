package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹상세 목록조회DTO
 */
@CommCode
public class LoyGetTierGrpDtlListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridTierGroup;     	//RID_TIER_GROUP
	private String tierCd;     			//등급 코드
	private String tierNm;     			//등급 명
	private Integer seqNo;     			//순서 번호
	private String validStartDate;     //유효 시작 일자
	private String validEndDate;     	//유효 종료 일자
	
	@MarkName(groupCode="LOY_TIER_MST_STAT_CD" , codeField="tierCdStatCd")
	private String tierCdStatNm;     	//등급 코드 상태 코드
	private String tierCdStatCd;     	//등급 코드 상태 코드
	
	private String createDate;     		//CREATE_DATE
	private String createBy;     		//CREATE_BY
	
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
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
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
	public String getTierCdStatNm() {
		return tierCdStatNm;
	}
	public void setTierCdStatNm(String tierCdStatNm) {
		this.tierCdStatNm = tierCdStatNm;
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
	
}