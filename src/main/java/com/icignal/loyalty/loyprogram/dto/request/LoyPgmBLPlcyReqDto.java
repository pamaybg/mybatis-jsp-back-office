package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPgmBLPlcyReqDto  extends CommonDataAuthReqDto {

	// 기본 필드
	private String blCd;
	private String blNm;
	private String blStat;             
	
	// 릴레이션
	private String pgmRid;					/* 프로그램 RID */

	// 시스템
	private String rid;             	 	/* RID */
	
	public String getBlCd() {
		return blCd;
	}
	public void setBlCd(String blCd) {
		this.blCd = blCd;
	}
	public String getBlNm() {
		return blNm;
	}
	public void setBlNm(String blNm) {
		this.blNm = blNm;
	}
	public String getBlStat() {
		return blStat;
	}
	public void setBlStat(String blStat) {
		this.blStat = blStat;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

}
