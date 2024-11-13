/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierListNewPageResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 1. 오후 2:46:56
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 1.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyTierListNewPageResDto
 * 2. 파일명	: LoyTierListNewPageResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyTierListNewPageResDto extends GridPagingItemResDto{
	private String rid;
	private String tierTypeCd;
	@MarkName(groupCode="LOY_MBR_TIER_TYPE_CD",codeField="tierTypeCd")
	private String tierTypeCdNm;
	private String tierNm;
	private String seqNo;
	private String baseTierYn;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String tiersUpKeepMm;
	private String tierGroupNm;
	private String upKeepMm;
	private String modifyTierDate;
	
	
	public String getModifyTierDate() {
		return modifyTierDate;
	}
	public void setModifyTierDate(String modifyTierDate) {
		this.modifyTierDate = modifyTierDate;
	}
	public String getUpKeepMm() {
		return upKeepMm;
	}
	public void setUpKeepMm(String upKeepMm) {
		this.upKeepMm = upKeepMm;
	}
	public String getTierGroupNm() {
		return tierGroupNm;
	}
	public void setTierGroupNm(String tierGroupNm) {
		this.tierGroupNm = tierGroupNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getBaseTierYn() {
		return baseTierYn;
	}
	public void setBaseTierYn(String baseTierYn) {
		this.baseTierYn = baseTierYn;
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
	public String getTiersUpKeepMm() {
		return tiersUpKeepMm;
	}
	public void setTiersUpKeepMm(String tiersUpKeepMm) {
		this.tiersUpKeepMm = tiersUpKeepMm;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
}
