/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTierGroupDetailReqDto.java
 * 2. Package	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 27. 오후 6:07:28
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 27.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.tiers.tiermaster.dto.request;

import java.sql.Date;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyTierGroupDetailReqDto
 * 2. 파일명	: LoyTierGroupDetailReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyTierGroupDetailReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String tiersGrpNm;
	private String tiersGrpCd;
	private String pgmRid;
	private String pgmNm;
	private String loyMbrTypeCd;
	private String dataSetRid;
	private String dsNm;
	private Date vaildStartDt;
	private Integer upKeepMm;
	private String tgComment;
	private String statCd;
	private String mbrTierCol;
	private String brdRid;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getDsNm() {
		return dsNm;
	}
	public void setDsNm(String dsNm) {
		this.dsNm = dsNm;
	}
	
	public Integer getUpKeepMm() {
		return upKeepMm;
	}
	public void setUpKeepMm(Integer upKeepMm) {
		this.upKeepMm = upKeepMm;
	}
	public String getTgComment() {
		return tgComment;
	}
	public void setTgComment(String tgComment) {
		this.tgComment = tgComment;
	}
	public String getTiersGrpNm() {
		return tiersGrpNm;
	}
	public void setTiersGrpNm(String tiersGrpNm) {
		this.tiersGrpNm = tiersGrpNm;
	}
	public String getDataSetRid() {
		return dataSetRid;
	}
	public void setDataSetRid(String dataSetRid) {
		this.dataSetRid = dataSetRid;
	}
	public String getLoyMbrTypeCd() {
		return loyMbrTypeCd;
	}
	public void setLoyMbrTypeCd(String loyMbrTypeCd) {
		this.loyMbrTypeCd = loyMbrTypeCd;
	}
	public String getStatCd() {
		return statCd;
	}
	public void setStatCd(String statCd) {
		this.statCd = statCd;
	}
	public Date getVaildStartDt() {
		return vaildStartDt;
	}
	public void setVaildStartDt(Date vaildStartDt) {
		this.vaildStartDt = vaildStartDt;
	}
	public String getMbrTierCol() {
		return mbrTierCol;
	}
	public void setMbrTierCol(String mbrTierCol) {
		this.mbrTierCol = mbrTierCol;
	}

	public String getBrdRid() {
		return brdRid;
	}

	public void setBrdRid(String brdRid) {
		this.brdRid = brdRid;
	}

	public String getTiersGrpCd() {
		return tiersGrpCd;
	}

	public void setTiersGrpCd(String tiersGrpCd) {
		this.tiersGrpCd = tiersGrpCd;
	}
}
