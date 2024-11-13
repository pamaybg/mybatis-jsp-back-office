/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierListNewResDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 27. 오후 3:53:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 27.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.response;

import java.sql.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyTierListNewResDto
 * 2. 파일명	: LoyTierListNewResDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyTierListNewResDto extends GridPagingItemResDto {
	private String rid;
	private String pgmNm;
	private String loyMbrTypeCd;
	@MarkName(groupCode="LOY_TIERS_GRP_TG_MBR_TYPE_CD", codeField="loyMbrTypeCd")
	private String loyMbrTypeCdNm;
	private Date vaildStartDt;
	private String createDate;
	private String modifyDate;
	private String statCd;
	@MarkName(groupCode="COM_STAT_TYPE_2_CD", codeField="statCd")
	private String statCdNm;
	private String tiersGrpNm;
	private String mbrTierCol;
	@MarkName(groupCode="LOY_MBR_TIER_TYPE_COL_CD", codeField="mbrTierCol")
	private String mbrTierColNm;
	private String name;
	private String brdNm;
	private String tiersGrpCd;

	

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMbrTierColNm() {
		return mbrTierColNm;
	}
	public void setMbrTierColNm(String mbrTierColNm) {
		this.mbrTierColNm = mbrTierColNm;
	}
	public String getMbrTierCol() {
		return mbrTierCol;
	}
	public void setMbrTierCol(String mbrTierCol) {
		this.mbrTierCol = mbrTierCol;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public String getStatCdNm() {
		return statCdNm;
	}
	public void setStatCdNm(String statCdNm) {
		this.statCdNm = statCdNm;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public Date getVaildStartDt() {
		return vaildStartDt;
	}
	public void setVaildStartDt(Date vaildStartDt) {
		this.vaildStartDt = vaildStartDt;
	}
	public String getTiersGrpNm() {
		return tiersGrpNm;
	}
	public void setTiersGrpNm(String tiersGrpNm) {
		this.tiersGrpNm = tiersGrpNm;
	}
	public String getLoyMbrTypeCd() {
		return loyMbrTypeCd;
	}
	public void setLoyMbrTypeCd(String loyMbrTypeCd) {
		this.loyMbrTypeCd = loyMbrTypeCd;
	}
	public String getLoyMbrTypeCdNm() {
		return loyMbrTypeCdNm;
	}
	public void setLoyMbrTypeCdNm(String loyMbrTypeCdNm) {
		this.loyMbrTypeCdNm = loyMbrTypeCdNm;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getTiersGrpCd() {
		return tiersGrpCd;
	}

	public void setTiersGrpCd(String tiersGrpCd) {
		this.tiersGrpCd = tiersGrpCd;
	}
}
