/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierRuleResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 3. 오후 5:10:08
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 3.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

/*
 * 1. 클래스명	: LoyTierRuleResDto
 * 2. 파일명	: LoyTierRuleResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyTierRuleResDto extends GridPagingItemResDto{
	private String rid;
	private String tierNm;
	private String tierTypeCd;
	private String tierTypeCdNm;
	private String condVal;
	private String createBy;
	private String name;
	private String createDate;
	private String fieldNm;
	private String dsNm;
	private String tiersRulesTierRid;
	private String tierRid;
	private String fieldDesc;
	private String fieldTypeCdNm;
	private String tierGrpDataSetRid;
	private String tierGrpDataSetItemRid;
	private String logicOper;
	private String frntBrktYn;
	private String backBrktYn;
	private String tierSeqNo;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getTierTypeCd() {
		return tierTypeCd;
	}
	public void setTierTypeCd(String tierTypeCd) {
		this.tierTypeCd = tierTypeCd;
	}
	public String getTierTypeCdNm() {
		return tierTypeCdNm;
	}
	public void setTierTypeCdNm(String tierTypeCdNm) {
		this.tierTypeCdNm = tierTypeCdNm;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
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
	public String getFieldNm() {
		return fieldNm;
	}
	public void setFieldNm(String fieldNm) {
		this.fieldNm = fieldNm;
	}
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTiersRulesTierRid() {
		return tiersRulesTierRid;
	}
	public void setTiersRulesTierRid(String tiersRulesTierRid) {
		this.tiersRulesTierRid = tiersRulesTierRid;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}
	public String getFieldDesc() {
		return fieldDesc;
	}
	public void setFieldDesc(String fieldDesc) {
		this.fieldDesc = fieldDesc;
	}
	public String getFieldTypeCdNm() {
		return fieldTypeCdNm;
	}
	public void setFieldTypeCdNm(String fieldTypeCdNm) {
		this.fieldTypeCdNm = fieldTypeCdNm;
	}
	public String getTierGrpDataSetRid() {
		return tierGrpDataSetRid;
	}
	public void setTierGrpDataSetRid(String tierGrpDataSetRid) {
		this.tierGrpDataSetRid = tierGrpDataSetRid;
	}
	public String getTierGrpDataSetItemRid() {
		return tierGrpDataSetItemRid;
	}
	public void setTierGrpDataSetItemRid(String tierGrpDataSetItemRid) {
		this.tierGrpDataSetItemRid = tierGrpDataSetItemRid;
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
	public String getTierSeqNo() {
		return tierSeqNo;
	}
	public void setTierSeqNo(String tierSeqNo) {
		this.tierSeqNo = tierSeqNo;
	}
	
	
	
}
