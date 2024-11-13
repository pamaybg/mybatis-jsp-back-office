package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록저장DTO
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyEditTierupMatrixReqDto extends MKTBaseReqDto {
	
	private String rid;     			//RID
	private String ridTierupMatrix;     			//RID
	private String ridTierGroup;     	//RID_TIER_GROUP
	private String ridTierCur; 
	private String ridTierNext; 
	private String tierupStatCd;
	private String dataStatus;
	private String tierupMtxSetType;
	private String memTypeCd;	
	private String tierCd;
	private String valueTierCd;
	private String startValue;
	private String limitValue;
	private String type;
	
	
	private List<LoyEditTierupMatrixDtlReqDto> condValList;
	private List<String> delRidRierupMatrixDtl;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
	public String getRidTierupMatrix() {
		return ridTierupMatrix;
	}

	public void setRidTierupMatrix(String ridTierupMatrix) {
		this.ridTierupMatrix = ridTierupMatrix;
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
	public List<LoyEditTierupMatrixDtlReqDto> getCondValList() {
		return condValList;
	}
	public void setCondValList(List<LoyEditTierupMatrixDtlReqDto> condValList) {
		this.condValList = condValList;
	}
	public String getDataStatus() {
		return dataStatus;
	}
	public void setDataStatus(String dataStatus) {
		this.dataStatus = dataStatus;
	}
	public List<String> getDelRidRierupMatrixDtl() {
		return delRidRierupMatrixDtl;
	}
	public void setDelRidRierupMatrixDtl(List<String> delRidRierupMatrixDtl) {
		this.delRidRierupMatrixDtl = delRidRierupMatrixDtl;
	}

	public String getTierupMtxSetType() {
		return tierupMtxSetType;
	}

	public void setTierupMtxSetType(String tierupMtxSetType) {
		this.tierupMtxSetType = tierupMtxSetType;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	

}