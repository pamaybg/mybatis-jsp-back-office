package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LOYMemberResDto extends GridPagingItemResDto {
	/** 회원 번호 */
	private String mbrNo    ;
	/** 가입 일자 */
	private String joinDate ;
	/** 가입 채널 */
	private String chnlNm   ;
	/** 회원 유형 코드 */
	private String mbrTypeCd;
	/** 회원 유형명 */
	@MarkName(groupCode="LOY_MEM_TYPE_CD", codeField="mbrTypeCd")
	private String mbrTypeNm;
	/** 회원 상태명 */
	private String mbrStatCd;
	/** 부가 정보 유형  명 */
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
	private String mbrStatNm;
	/** 로열티 프로그램명*/
	private String pgmNm    ;

	/** 등급*/
	private String tierNm   ;

	/**
	 * @return the mbrNo
	 */
	public String getMbrNo() {
		return mbrNo;
	}
	/**
	 * @param mbrNo the mbrNo to set
	 */
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	/**
	 * @return the joinDate
	 */
	public String getJoinDate() {
		return joinDate;
	}
	/**
	 * @param joinDate the joinDate to set
	 */
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	/**
	 * @return the chnlNm
	 */
	public String getChnlNm() {
		return chnlNm;
	}
	/**
	 * @param chnlNm the chnlNm to set
	 */
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	/**
	 * @return the mbrTypeCd
	 */
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	/**
	 * @param mbrTypeCd the mbrTypeCd to set
	 */
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	/**
	 * @return the mbrTypeNm
	 */
	public String getMbrTypeNm() {
		return mbrTypeNm;
	}
	/**
	 * @param mbrTypeNm the mbrTypeNm to set
	 */
	public void setMbrTypeNm(String mbrTypeNm) {
		this.mbrTypeNm = mbrTypeNm;
	}
	/**
	 * @return the mbrStatCd
	 */
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	/**
	 * @param mbrStatCd the mbrStatCd to set
	 */
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	/**
	 * @return the mbrStatNm
	 */
	public String getMbrStatNm() {
		return mbrStatNm;
	}
	/**
	 * @param mbrStatNm the mbrStatNm to set
	 */
	public void setMbrStatNm(String mbrStatNm) {
		this.mbrStatNm = mbrStatNm;
	}
	/**
	 * @return the pgmNm
	 */
	public String getPgmNm() {
		return pgmNm;
	}
	/**
	 * @param pgmNm the pgmNm to set
	 */
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	/**
	 * @return the tierNm
	 */
	public String getTierNm() {
		return tierNm;
	}
	/**
	 * @param tierNm the tierNm to set
	 */
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}


}
