package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyPgmResDto extends GridPagingItemResDto {

	// 기본 필드
	private String repYn;					/* 대표 프로그램 여부 */
	private String pgmNo;             		/* 프로그램 번호 */
	private String pgmNm;             		/* 프로그램 명 */
	private String contents; 			    /* 프로그램 소개 */
	
	// 코드
	private String pgmStat;             	/* 프로그램 상태 */
	@MarkName(groupCode = "LOY_PGM_STAT_CD", codeField = "pgmStat")
	private String pgmStatNm; 				/* 프로그램 상태명 */
	private String pgmType;             	/* 프로그램 유형 */
	@MarkName(groupCode = "LOY_PGM_JOIN_CD", codeField = "pgmType")
	private String pgmTypeNm; 				/* 프로그램 유형명 */
	private String pgmSubType;             	/* 프로그램 세부 유형 */
	@MarkName(groupCode = "LOY_PGM_SUB_JOIN_CD", codeField = "pgmSubType")
	private String pgmSubTypeNm; 			/* 프로그램 세부 유형명 */

	// 릴레이션
	private String parPgmRid;				/* 상위 프로그램 RID */
	private String parPgmNm;				/* 상위 프로그램명 */
	private String chnlRid;             	/* 주관사 */
	private String chnlNm;                  /* 주관사명*/
	private String cardKindPrRid;           /* 대표 카드 유형 RID */
	private String cardKindPrNm;            /* 대표 카드 유형명 */
	private String repPgmRid;				/* 대표 프로그램 RID */
	private String repPgmNm;				/* 대표 프로그램명 */

	// 시스템
	private String rid;             		/* RID */
	private String createDate;             	/* 생성일 */
	private String createBy;             	/* 생성자 */
	private String modifyDate;             	/* 수정일시 */
	private String modifyBy;             	/* 수정자 */

	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
	public String getParPgmRid() {
		return parPgmRid;
	}
	public void setParPgmRid(String parPgmRid) {
		this.parPgmRid = parPgmRid;
	}
	public String getParPgmNm() {
		return parPgmNm;
	}
	public void setParPgmNm(String parPgmNm) {
		this.parPgmNm = parPgmNm;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
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

	public String getCardKindPrRid() {
		return cardKindPrRid;
	}

	public void setCardKindPrRid(String cardKindPrRid) {
		this.cardKindPrRid = cardKindPrRid;
	}

	public String getCardKindPrNm() {
		return cardKindPrNm;
	}

	public void setCardKindPrNm(String cardKindPrNm) {
		this.cardKindPrNm = cardKindPrNm;
	}

	public String getRepPgmRid() {
		return repPgmRid;
	}

	public void setRepPgmRid(String repPgmRid) {
		this.repPgmRid = repPgmRid;
	}

	public String getRepPgmNm() {
		return repPgmNm;
	}

	public void setRepPgmNm(String repPgmNm) {
		this.repPgmNm = repPgmNm;
	}
}
