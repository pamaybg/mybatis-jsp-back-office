package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPgmJoinPlcyReqDto extends CommonDataAuthReqDto {

	// 기본 필드
	private String val;					    /* 속성 값 */
	private String description;             /* 가입 정책 설명 */

	// 코드
	private String joinCate;             	/* 가임 정책 속성 코드 */
	private String joinRange; 				/* 가임 구간 코드 */
	private String joinCond;             	/* 가임 조건 코드  */
	private String joinDate; 				/* 가임 날짜 구분 코드 */

	// 시스템
	private String rid;             	 	/* RID */
	private String pgmRid;					/* 부모 프로그램 RID */

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getVal() {
		return val;
	}
	public void setVal(String val) {
		this.val = val;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getJoinCate() {
		return joinCate;
	}
	public void setJoinCate(String joinCate) {
		this.joinCate = joinCate;
	}
	public String getJoinRange() {
		return joinRange;
	}
	public void setJoinRange(String joinRange) {
		this.joinRange = joinRange;
	}
	public String getJoinCond() {
		return joinCond;
	}
	public void setJoinCond(String joinCond) {
		this.joinCond = joinCond;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
}
