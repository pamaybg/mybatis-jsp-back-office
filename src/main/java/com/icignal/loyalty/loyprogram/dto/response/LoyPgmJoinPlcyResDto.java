package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyPgmJoinPlcyResDto extends GridPagingItemResDto {

	// 기본 필드
	private String val = "";					    /* 속성 값 */
	
	// 코드
	private String joinCate;             	/* 가임 정책 속성 코드 */
	@MarkName(groupCode = "LOY_JOIN_CATE_CD", codeField = "joinCate")
    private String joinCateNm;             	/* 가임 정책 속성명 */
	private String joinRange; 				/* 가임 구간 코드 */
	@MarkName(groupCode = "LOY_MGT_RANGE_CD", codeField = "joinRange")
	private String joinRangeNm; 			/* 가임 구간명 */
	private String joinCond;             	/* 가임 조건 코드  */
	@MarkName(groupCode = "LOY_MGT_COND_CD", codeField = "joinCond")
    private String joinCondNm;             	/* 가임 조건명  */
	private String joinDate; 				/* 가임 날짜 구분 코드 */
	@MarkName(groupCode = "LOY_DATE_CD", codeField = "joinDate")
	private String joinDateNm; 				/* 가임 날짜 구분명 */

	// 시스템
	private String rid;             		/* RID */
	private String modifyDate;             	/* 수정일시 */
	private String modifyBy;             	/* 수정자 */

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
		return this.joinCateNm + ": " + this.joinCondNm + this.joinRangeNm + " " + this.val + this.joinDateNm;
	}
	public String getJoinCate() {
		return joinCate;
	}
	public void setJoinCate(String joinCate) {
		this.joinCate = joinCate;
	}
	public String getJoinCateNm() {
		return joinCateNm;
	}
	public void setJoinCateNm(String joinCateNm) {
		this.joinCateNm = joinCateNm;
	}
	public String getJoinRange() {
		return joinRange;
	}
	public void setJoinRange(String joinRange) {
		this.joinRange = joinRange;
	}
	public String getJoinRangeNm() {
		return joinRangeNm;
	}
	public void setJoinRangeNm(String joinRangeNm) {
		this.joinRangeNm = joinRangeNm;
	}
	public String getJoinCond() {
		return joinCond;
	}
	public void setJoinCond(String joinCond) {
		this.joinCond = joinCond;
	}
	public String getJoinCondNm() {
		return joinCondNm;
	}
	public void setJoinCondNm(String joinCondNm) {
		this.joinCondNm = joinCondNm;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getJoinDateNm() {
		return joinDateNm;
	}
	public void setJoinDateNm(String joinDateNm) {
		this.joinDateNm = joinDateNm;
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
