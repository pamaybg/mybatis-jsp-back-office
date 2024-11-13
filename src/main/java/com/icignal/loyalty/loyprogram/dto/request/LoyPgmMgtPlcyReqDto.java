package com.icignal.loyalty.loyprogram.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyPgmMgtPlcyReqDto extends CommonDataAuthReqDto {
	
	// 기본 필드
	private String val;						/* 속성 값 */
	
	// 코드
	private String mgtCate;             	/* 분류 */
	private String mgtCateSub;             	/* 유형 */
	private String mgtRange;             	/* 구간 */
	private String mgtCond;             	/* 조건 */
	private String mgtDate;             	/* 날짜구분 */

	// 시스템
	private String rid;             		/* RID */
	private String pgmRid;					/* 부모 프로그램 RID */
	private String useYn;
	private String comments;

	
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
	public String getMgtCate() {
		return mgtCate;
	}
	public void setMgtCate(String mgtCate) {
		this.mgtCate = mgtCate;
	}
	public String getMgtCateSub() {
		return mgtCateSub;
	}
	public void setMgtCateSub(String mgtCateSub) {
		this.mgtCateSub = mgtCateSub;
	}
	public String getMgtRange() {
		return mgtRange;
	}
	public void setMgtRange(String mgtRange) {
		this.mgtRange = mgtRange;
	}
	public String getMgtCond() {
		return mgtCond;
	}
	public void setMgtCond(String mgtCond) {
		this.mgtCond = mgtCond;
	}
	public String getMgtDate() {
		return mgtDate;
	}
	public void setMgtDate(String mgtDate) {
		this.mgtDate = mgtDate;
	}

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
}
