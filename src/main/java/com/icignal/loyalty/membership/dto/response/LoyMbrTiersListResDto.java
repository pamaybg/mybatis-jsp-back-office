/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTiersListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 10. 오후 4:58:08
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrTiersListResDto
 * 2. 파일명	: LoyMbrTiersListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrTiersListResDto extends GridPagingItemResDto{
	private String rid;
	private String tierCalcDate;
	private String tierNm;
	private String tierTypeCd;
	private String tierGrpNm;
	private String vaildStartDt;
	private String validEndDt;
	private String tierMnlReasonCd;
	@MarkName(groupCode="LOY_TIER_MNL_REASON_CD",codeField="tierMnlReasonCd")
	private String tierMnlReasonCdNm;
	private String tierMnlReasonDesc;
	private String createBy;
	private String createDate;
	private String tierGrpRid;
	private String tierRid;
	private String validHistYn;
	private String upKeepMm;
	private String mbrTierCol;
	private String seqNo;
	@MarkName(groupCode="LOY_TIER_CHG_TYPE_CD",codeField="tierChgTypeCd")
	private String tierChgTypeCdNm;
	private String tierChgTypeCd;
	private String tierChgRstCd;
	@MarkName(groupCode="TIER_CHG_RST_CD",codeField="tierChgRstCd")
	private String tierChgRstCdNm;
	private String tiersGrpNm;
	
	
	public String getTiersGrpNm() {
		return tiersGrpNm;
	}
	public void setTiersGrpNm(String tiersGrpNm) {
		this.tiersGrpNm = tiersGrpNm;
	}
	public String getTierChgTypeCdNm() {
		return tierChgTypeCdNm;
	}
	public void setTierChgTypeCdNm(String tierChgTypeCdNm) {
		this.tierChgTypeCdNm = tierChgTypeCdNm;
	}
	public String getTierChgTypeCd() {
		return tierChgTypeCd;
	}
	public void setTierChgTypeCd(String tierChgTypeCd) {
		this.tierChgTypeCd = tierChgTypeCd;
	}
	public String getTierChgRstCd() {
		return tierChgRstCd;
	}
	public void setTierChgRstCd(String tierChgRstCd) {
		this.tierChgRstCd = tierChgRstCd;
	}
	public String getTierChgRstCdNm() {
		return tierChgRstCdNm;
	}
	public void setTierChgRstCdNm(String tierChgRstCdNm) {
		this.tierChgRstCdNm = tierChgRstCdNm;
	}
	public String getMbrTierCol() {
		return mbrTierCol;
	}
	public void setMbrTierCol(String mbrTierCol) {
		this.mbrTierCol = mbrTierCol;
	}
	public String getUpKeepMm() {
		return upKeepMm;
	}
	public void setUpKeepMm(String upKeepMm) {
		this.upKeepMm = upKeepMm;
	}
	public String getValidHistYn() {
		return validHistYn;
	}
	public void setValidHistYn(String validHistYn) {
		this.validHistYn = validHistYn;
	}
	public String getTierGrpRid() {
		return tierGrpRid;
	}
	public void setTierGrpRid(String tierGrpRid) {
		this.tierGrpRid = tierGrpRid;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
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
	public String getTierGrpNm() {
		return tierGrpNm;
	}
	public void setTierGrpNm(String tierGrpNm) {
		this.tierGrpNm = tierGrpNm;
	}
	public String getVaildStartDt() {
		return vaildStartDt;
	}
	public void setVaildStartDt(String vaildStartDt) {
		this.vaildStartDt = vaildStartDt;
	}
	public String getTierCalcDate() {
		return tierCalcDate;
	}
	public void setTierCalcDate(String tierCalcDate) {
		this.tierCalcDate = tierCalcDate;
	}
	public String getValidEndDt() {
		return validEndDt;
	}
	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}
	public String getTierMnlReasonCd() {
		return tierMnlReasonCd;
	}
	public void setTierMnlReasonCd(String tierMnlReasonCd) {
		this.tierMnlReasonCd = tierMnlReasonCd;
	}
	public String getTierMnlReasonDesc() {
		return tierMnlReasonDesc;
	}
	public void setTierMnlReasonDesc(String tierMnlReasonDesc) {
		this.tierMnlReasonDesc = tierMnlReasonDesc;
	}
	public String getTierMnlReasonCdNm() {
		return tierMnlReasonCdNm;
	}
	public void setTierMnlReasonCdNm(String tierMnlReasonCdNm) {
		this.tierMnlReasonCdNm = tierMnlReasonCdNm;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	
	
}
