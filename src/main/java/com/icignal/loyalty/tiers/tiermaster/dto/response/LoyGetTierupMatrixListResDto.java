package com.icignal.loyalty.tiers.tiermaster.dto.response;

import java.util.List;

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
public class LoyGetTierupMatrixListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridTierGroup;     	//RID_TIER_GROUP
	private String ridTierCur;     	
	private String ridTierCurNm;     	
	private String ridTierNext;     	
	private String ridTierNextNm;     	
	
	@MarkName(groupCode="LOY_TIERUP_STAT_CD" , codeField="tierupStatCd")
	private String tierupStatNm;   
	private String tierupStatCd;   
	private String tierupVal;     	
	private String createBy;     	
	private String createDate;
	private String tierupMatrixRid;
	private String ridTierupMatrix;
	
	private String memTypeCd;	
	private String tierCd;
	private String valueTierCd;
	private String startValue;
	private String limitValue;
	
	private List<LoyGetTierupMatrixDtlResDto> condValList;	//조건값 목록
	
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
	public String getRidTierCur() {
		return ridTierCur;
	}
	public void setRidTierCur(String ridTierCur) {
		this.ridTierCur = ridTierCur;
	}
	public String getRidTierNext() {
		return ridTierNext;
	}
	public void setRidTierNext(String ridTierNext) {
		this.ridTierNext = ridTierNext;
	}
	public String getTierupStatCd() {
		return tierupStatCd;
	}
	public void setTierupStatCd(String tierupStatCd) {
		this.tierupStatCd = tierupStatCd;
	}
	public String getTierupStatNm() {
		return tierupStatNm;
	}
	public void setTierupStatNm(String tierupStatNm) {
		this.tierupStatNm = tierupStatNm;
	}
	public String getTierupVal() {
		return tierupVal;
	}
	public void setTierupVal(String tierupVal) {
		this.tierupVal = tierupVal;
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
	public String getRidTierCurNm() {
		return ridTierCurNm;
	}
	public void setRidTierCurNm(String ridTierCurNm) {
		this.ridTierCurNm = ridTierCurNm;
	}
	public String getRidTierNextNm() {
		return ridTierNextNm;
	}
	public void setRidTierNextNm(String ridTierNextNm) {
		this.ridTierNextNm = ridTierNextNm;
	}
	public List<LoyGetTierupMatrixDtlResDto> getCondValList() {
		return condValList;
	}
	public void setCondValList(List<LoyGetTierupMatrixDtlResDto> condValList) {
		this.condValList = condValList;
	}
	public String getMemTypeCd() {
		return memTypeCd;
	}
	public void setMemTypeCd(String memTypeCd) {
		this.memTypeCd = memTypeCd;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getValueTierCd() {
		return valueTierCd;
	}
	public void setValueTierCd(String valueTierCd) {
		this.valueTierCd = valueTierCd;
	}
	public String getStartValue() {
		return startValue;
	}
	public void setStartValue(String startValue) {
		this.startValue = startValue;
	}
	public String getLimitValue() {
		return limitValue;
	}
	public void setLimitValue(String limitValue) {
		this.limitValue = limitValue;
	}
	public String getTierupMatrixRid() {
		return tierupMatrixRid;
	}
	public void setTierupMatrixRid(String tierupMatrixRid) {
		this.tierupMatrixRid = tierupMatrixRid;
	}
	public String getRidTierupMatrix() {
		return ridTierupMatrix;
	}
	public void setRidTierupMatrix(String ridTierupMatrix) {
		this.ridTierupMatrix = ridTierupMatrix;
	}
 	
	
	
}