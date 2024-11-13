package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPgmReqDto extends CommonDataAuthReqDto {
	
	// 기본 필드
	private String repYn;					/* 대표 프로그램 여부 */
	private String pgmNo;             		/* 프로그램 번호 */
	private String pgmNm;             		/* 프로그램 명 */
	private String contents; 			    /* 프로그램 소개 */
	
	// 코드
	private String pgmStat;             	/* 프로그램 상태 */
	private String pgmType;             	/* 프로그램 유형 */
	private String pgmSubType;             	/* 프로그램 세부 유형 */

	// 릴레이션
	private String parPgmRid;				/* 상위 프로그램 RID */
	private String chnlRid;             	/* 주관사 RID */
	private String cardKindPrRid;           /* 대표 카드 유형 RID */
	private String pgmRid;					/* 부모 프로그램 RID */
	private String repPgmRid;				/* 대표 프로그램 RID */

	// 시스템
	private String rid;             		/* RID */

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
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
	public String getPgmType() {
		return pgmType;
	}
	public void setPgmType(String pgmType) {
		this.pgmType = pgmType;
	}
	public String getPgmSubType() {
		return pgmSubType;
	}
	public void setPgmSubType(String pgmSubType) {
		this.pgmSubType = pgmSubType;
	}
	public String getParPgmRid() {
		return parPgmRid;
	}
	public void setParPgmRid(String parPgmRid) {
		this.parPgmRid = parPgmRid;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlPrRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}

	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}

	public String getCardKindPrRid() {
		return cardKindPrRid;
	}

	public void setCardKindPrRid(String cardKindPrRid) {
		this.cardKindPrRid = cardKindPrRid;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public String getRepPgmRid() {
		return repPgmRid;
	}

	public void setRepPgmRid(String repPgmRid) {
		this.repPgmRid = repPgmRid;
	}
}
