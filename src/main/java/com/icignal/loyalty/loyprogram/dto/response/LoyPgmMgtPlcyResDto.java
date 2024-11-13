package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyPgmMgtPlcyResDto extends GridPagingItemResDto {

	// 기본 필드
	private String val = "";						/* 속성 값 */
	
	// 코드
	private String mgtCate;             	/* 분류 */
	@MarkName(groupCode = "LOY_MGT_CATE_CD", codeField = "mgtCate")
	private String mgtCateNm; 				/* 분류명 */
	private String mgtCateSub;             	/* 유형 */
	@MarkName(groupCode = "LOY_MGT_CATE_SUB_CD", codeField = "mgtCateSub")
	private String mgtCateSubNm; 			/* 유형명 */
	private String mgtRange;             	/* 구간 */
	@MarkName(groupCode = "LOY_MGT_RANGE_CD", codeField = "mgtRange")
	private String mgtRangeNm; 				/* 구간명 */
	private String mgtCond;             	/* 조건 */
	@MarkName(groupCode = "LOY_MGT_COND_CD", codeField = "mgtCond")
	private String mgtCondNm; 				/* 조건명 */
	private String mgtDate;             	/* 날짜구분 */
	@MarkName(groupCode = "LOY_DATE_CD", codeField = "mgtDate")
	private String mgtDateNm; 				/* 날짜구분명 */
	

	// 릴레이션
	private String pgmRid;					/* 프로그램 RID */

	// 시스템
	private String rid;             		/* RID */
	private String modifyDate;             	/* 수정일시 */
	private String modifyBy;             	/* 수정자 */
	@MarkName(groupCode = "REQUIRED_YN", codeField = "useYnCd")
	private String useYn;
	private String useYnCd;
	private String comments;
	
	
	public String getUseYnCd() {
		return useYnCd;
	}
	public void setUseYnCd(String useYnCd) {
		this.useYnCd = useYnCd;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getVal() {
		return val;
	}
	public void setVal(String val) {
		this.val = val;
	}
	public String getDescription() {
		return this.mgtCateSubNm + ": " + this.mgtCondNm + " " + this.val + " " +this.mgtDateNm + this.mgtRangeNm;
	}
	public String getMgtCate() {
		return mgtCate;
	}
	public void setMgtCate(String mgtCate) {
		this.mgtCate = mgtCate;
	}
	public String getMgtCateNm() {
		return mgtCateNm;
	}
	public void setMgtCateNm(String mgtCateNm) {
		this.mgtCateNm = mgtCateNm;
	}
	public String getMgtCateSub() {
		return mgtCateSub;
	}
	public void setMgtCateSub(String mgtCateSub) {
		this.mgtCateSub = mgtCateSub;
	}
	public String getMgtCateSubNm() {
		return mgtCateSubNm;
	}
	public void setMgtCateSubNm(String mgtCateSubNm) {
		this.mgtCateSubNm = mgtCateSubNm;
	}
	public String getMgtRange() {
		return mgtRange;
	}
	public void setMgtRange(String mgtRange) {
		this.mgtRange = mgtRange;
	}
	public String getMgtRangeNm() {
		return mgtRangeNm;
	}
	public void setMgtRangeNm(String mgtRangeNm) {
		this.mgtRangeNm = mgtRangeNm;
	}
	public String getMgtCond() {
		return mgtCond;
	}
	public void setMgtCond(String mgtCond) {
		this.mgtCond = mgtCond;
	}
	public String getMgtCondNm() {
		return mgtCondNm;
	}
	public void setMgtCondNm(String mgtCondNm) {
		this.mgtCondNm = mgtCondNm;
	}
	public String getMgtDate() {
		return mgtDate;
	}
	public void setMgtDate(String mgtDate) {
		this.mgtDate = mgtDate;
	}
	public String getMgtDateNm() {
		return mgtDateNm;
	}
	public void setMgtDateNm(String mgtDateNm) {
		this.mgtDateNm = mgtDateNm;
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
