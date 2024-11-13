package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급채널상세 목록조회DTO
 */
@CommCode
public class LoyGetMbrMstPopResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridChnl;      
	private String ridPgm; 
	private String mbrNo;		
	private String ridCust;		
	private String custNm;	
	private String ridTierCur;	
	private String tierNm;		
	private String mbrTypeCd;	
	
	@MarkName(groupCode="LOY_MEM_TYPE_CD" , codeField="MBR_TYPE_CD")
	private String mbrTypeNm;	
	private String mbrStatCd;
	
	@MarkName(groupCode="LOY_MBR_STAT_CD" , codeField="MBR_STAT_CD")
	private String mbrStatNm;
	private String hpNo;
	
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
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRidTierCur() {
		return ridTierCur;
	}
	public void setRidTierCur(String ridTierCur) {
		this.ridTierCur = ridTierCur;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeNm() {
		return mbrTypeNm;
	}
	public void setMbrTypeNm(String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatNm() {
		return mbrStatNm;
	}
	public void setMbrStatNm(String mbrStatNm) {
		this.mbrStatNm = mbrStatNm;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	
}