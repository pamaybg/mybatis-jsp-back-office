package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class OfferCouponPoolResDto extends GridPagingItemResDto {

	// 시스템
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	// 릴레이션
	private String ridOfr;						/* 연결 오퍼 RID*/
	private String ridCpnM;						/* 연결 쿠폰 RID */
	private String ridMbr;						/* 회원 RID */
	private String cpnNo;						/* 쿠폰번호 */
	private String searchNo;					/* 검색번호 */
	
	// 코드
	private String issueTypeCd;             	/* 쿠폰 Pool 유형 (M:대량발급 / S:단건발급) */
	@MarkName(groupCode = "CPN_ISSUE_TYPE", codeField = "issueTypeCd")
	private String issueTypeCdNm; 			/* 쿠폰 Pool 유형명 */
	private String issueApplyFlag;			/* 발급여부코드 (사용여부) */
	@MarkName(groupCode = "YES_NO_FLAG", codeField = "issueApplyFlag")
	private String issueApplyFlagNm;		/* 발급여부명 (사용여부) */
	
	// 기본 필드
	private String issueApplyDate;			/* 발급일자 */

	//getter, setter
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

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getRidCpnM() {
		return ridCpnM;
	}

	public void setRidCpnM(String ridCpnM) {
		this.ridCpnM = ridCpnM;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getCpnNo() {
		return cpnNo;
	}

	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}

	public String getSearchNo() {
		return searchNo;
	}

	public void setSearchNo(String searchNo) {
		this.searchNo = searchNo;
	}

	public String getIssueTypeCd() {
		return issueTypeCd;
	}

	public void setIssueTypeCd(String issueTypeCd) {
		this.issueTypeCd = issueTypeCd;
	}

	public String getIssueTypeCdNm() {
		return issueTypeCdNm;
	}

	public void setIssueTypeCdNm(String issueTypeCdNm) {
		this.issueTypeCdNm = issueTypeCdNm;
	}

	public String getIssueApplyFlag() {
		return issueApplyFlag;
	}

	public void setIssueApplyFlag(String issueApplyFlag) {
		this.issueApplyFlag = issueApplyFlag;
	}

	public String getIssueApplyFlagNm() {
		return issueApplyFlagNm;
	}

	public void setIssueApplyFlagNm(String issueApplyFlagNm) {
		this.issueApplyFlagNm = issueApplyFlagNm;
	}

	public String getIssueApplyDate() {
		return issueApplyDate;
	}

	public void setIssueApplyDate(String issueApplyDate) {
		this.issueApplyDate = issueApplyDate;
	}
}
