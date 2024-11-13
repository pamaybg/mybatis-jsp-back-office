/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierRuleMasterReqDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 3. 오후 5:20:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierRuleMasterReqDto
 * 2. 파일명	: LoyTierRuleMasterReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierRuleMasterReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tierGrpJobRid;
	private String tierRid;
	private String dataSetRid;
	private String dataSetItemRid;
	private Integer seqNo;
	private String condVal;
	private String ridTier;
	private String tierTypeCd;
	private String tierNm;
	private String type;
	private String tierGrpDataSetRid;
	private String saveRid;
	private String tierCdRid;
	private String tierGrpDataSetItemRid;
	private String tierBatchJobCd;
	private String tiersRulesTierRid;
	private String logicOper;
	private String frntBrktYn;
	private String backBrktYn;
	
	private ArrayList<LoyTierRuleMasterReqDto> tierCondDetail;
	private ArrayList<LoyTierRuleMasterReqDto> tierCondDetailRemove;
	
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
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getDataSetRid() {
		return dataSetRid;
	}
	public void setDataSetRid(String dataSetRid) {
		this.dataSetRid = dataSetRid;
	}
	public String getDataSetItemRid() {
		return dataSetItemRid;
	}
	public void setDataSetItemRid(String dataSetItemRid) {
		this.dataSetItemRid = dataSetItemRid;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public String getRidTier() {
		return ridTier;
	}
	public void setRidTier(String ridTier) {
		this.ridTier = ridTier;
	}
	public String getTierTypeCd() {
		return tierTypeCd;
	}
	public void setTierTypeCd(String tierTypeCd) {
		this.tierTypeCd = tierTypeCd;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public ArrayList<LoyTierRuleMasterReqDto> getTierCondDetail() {
		return tierCondDetail;
	}
	public void setTierCondDetail(ArrayList<LoyTierRuleMasterReqDto> tierCondDetail) {
		this.tierCondDetail = tierCondDetail;
	}
	public ArrayList<LoyTierRuleMasterReqDto> getTierCondDetailRemove() {
		return tierCondDetailRemove;
	}
	public void setTierCondDetailRemove(ArrayList<LoyTierRuleMasterReqDto> tierCondDetailRemove) {
		this.tierCondDetailRemove = tierCondDetailRemove;
	}
	public String getTierGrpDataSetRid() {
		return tierGrpDataSetRid;
	}
	public void setTierGrpDataSetRid(String tierGrpDataSetRid) {
		this.tierGrpDataSetRid = tierGrpDataSetRid;
	}
	public String getSaveRid() {
		return saveRid;
	}
	public void setSaveRid(String saveRid) {
		this.saveRid = saveRid;
	}
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
		this.seqNo = seqNo;
	}
	public String getTierCdRid() {
		return tierCdRid;
	}
	public void setTierCdRid(String tierCdRid) {
		this.tierCdRid = tierCdRid;
	}
	public String getTierGrpDataSetItemRid() {
		return tierGrpDataSetItemRid;
	}
	public void setTierGrpDataSetItemRid(String tierGrpDataSetItemRid) {
		this.tierGrpDataSetItemRid = tierGrpDataSetItemRid;
	}
	public String getTierBatchJobCd() {
		return tierBatchJobCd;
	}
	public void setTierBatchJobCd(String tierBatchJobCd) {
		this.tierBatchJobCd = tierBatchJobCd;
	}
	public String getTiersRulesTierRid() {
		return tiersRulesTierRid;
	}
	public void setTiersRulesTierRid(String tiersRulesTierRid) {
		this.tiersRulesTierRid = tiersRulesTierRid;
	}
	public String getLogicOper() {
		return logicOper;
	}
	public void setLogicOper(String logicOper) {
		this.logicOper = logicOper;
	}
	public String getFrntBrktYn() {
		return frntBrktYn;
	}
	public void setFrntBrktYn(String frntBrktYn) {
		this.frntBrktYn = frntBrktYn;
	}
	public String getBackBrktYn() {
		return backBrktYn;
	}
	public void setBackBrktYn(String backBrktYn) {
		this.backBrktYn = backBrktYn;
	}
	

	
	
	
	
}
