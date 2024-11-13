package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class OfferJoinPgmResDto extends GridPagingItemResDto {

	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	// 릴레이션
	private String ridSupplyChnl;
	private String chnlNm;
	private String ridOfrgrpSel;
	private String ofrgrpSelNm;
	private String ridStmp;
	private String stmpNm;
	
	// 코드
	private String pgmStat;             	/* 프로그램 상태 */
	@MarkName(groupCode = "LOY_PGM_STAT_CD", codeField = "pgmStat")
	private String pgmStatNm; 			/* 프로그램 상태명 */
	private String pgmType;             	/* 프로그램 유형 */
	@MarkName(groupCode = "LOY_PGM_JOIN_CD", codeField = "pgmType")
	private String pgmTypeNm; 			/* 프로그램 유형명 */
	private String pgmSubType;          /* 프로그램 세부 유형 */
	@MarkName(groupCode = "LOY_PGM_SUB_JOIN_CD", codeField = "pgmSubType")
	private String pgmSubTypeNm; 		/* 프로그램 세부 유형명 */
	
	// 기본 필드
	private String ridOfr;					/* 연결 오퍼 RID*/
	private String ridPgm;					/* 연결 로열티프로그램 RID*/
	private String descText;				/* 비고 */
	private String pgmNo;					/* 프로그램 번호 */
	private String pgmNm;					/* 프로그램 명 */
	private String chnlPrNm;				/* 채널명 (주관사) */
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getRidSupplyChnl() {
		return ridSupplyChnl;
	}
	public void setRidSupplyChnl(String ridSupplyChnl) {
		this.ridSupplyChnl = ridSupplyChnl;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getRidOfrgrpSel() {
		return ridOfrgrpSel;
	}
	public void setRidOfrgrpSel(String ridOfrgrpSel) {
		this.ridOfrgrpSel = ridOfrgrpSel;
	}
	public String getOfrgrpSelNm() {
		return ofrgrpSelNm;
	}
	public void setOfrgrpSelNm(String ofrgrpSelNm) {
		this.ofrgrpSelNm = ofrgrpSelNm;
	}
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getStmpNm() {
		return stmpNm;
	}
	public void setStmpNm(String stmpNm) {
		this.stmpNm = stmpNm;
	}
	public String getPgmStat() {
		return pgmStat;
	}
	public void setPgmStat(String pgmStat) {
		this.pgmStat = pgmStat;
	}
	public String getPgmStatNm() {
		return pgmStatNm;
	}
	public void setPgmStatNm(String pgmStatNm) {
		this.pgmStatNm = pgmStatNm;
	}
	public String getPgmType() {
		return pgmType;
	}
	public void setPgmType(String pgmType) {
		this.pgmType = pgmType;
	}
	public String getPgmTypeNm() {
		return pgmTypeNm;
	}
	public void setPgmTypeNm(String pgmTypeNm) {
		this.pgmTypeNm = pgmTypeNm;
	}
	public String getPgmSubType() {
		return pgmSubType;
	}
	public void setPgmSubType(String pgmSubType) {
		this.pgmSubType = pgmSubType;
	}
	public String getPgmSubTypeNm() {
		return pgmSubTypeNm;
	}
	public void setPgmSubTypeNm(String pgmSubTypeNm) {
		this.pgmSubTypeNm = pgmSubTypeNm;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getChnlPrNm() {
		return chnlPrNm;
	}
	public void setChnlPrNm(String chnlPrNm) {
		this.chnlPrNm = chnlPrNm;
	}
}
