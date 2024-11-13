package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록조회DTO
 */
public class LoyGetTierGroupListReqDto extends CommonDataAuthReqDto {
	
	private String  accntId;
	private String  rid;
	private String  tierGrpJobRid;
	private String  cateMbr;
	private String evtLimitTier;
	
	
	public String getEvtLimitTier() {
		return evtLimitTier;
	}

	public void setEvtLimitTier(String evtLimitTier) {
		this.evtLimitTier = evtLimitTier;
	}

	public String getCateMbr() {
		return cateMbr;
	}

	public void setCateMbr(String cateMbr) {
		this.cateMbr = cateMbr;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}


	public String getTierGrpJobRid() {
		return tierGrpJobRid;
	}

	public void setTierGrpJobRid(String tierGrpJobRid) {
		this.tierGrpJobRid = tierGrpJobRid;
	}

	
}