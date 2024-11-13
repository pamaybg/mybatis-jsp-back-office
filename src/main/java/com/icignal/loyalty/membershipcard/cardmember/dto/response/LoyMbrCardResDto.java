/**
 *
 */
package com.icignal.loyalty.membershipcard.cardmember.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


/**
  * @fileName : LoyMbrCardResponseDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 2.
  * @author : knlee
  * @변경이력 :
  * @descripton :
  */
@PersonalData
public class LoyMbrCardResDto  extends GridPagingItemResDto {

	/** rid MbrCard */
	private String rid;

	private String ridMbr;

	/** 카드번호 */
	@Decrypted(masked="cardNum")
    private String  cardNo    ;

    /** 발급일자 */
    private String  issueDate ;

    /** 카드상태 */
    private String  stat      ;

    /** 카드상태명 */
    private String  statNm    ;

    /** 카드상태 순번 */
    private String  statSeq   ;

    /** 카드유형명 */
    private String  cardKndNm ;

    /** 유형상세 */
    private String  typeDesc  ;


	/**
	 * @return the cardNo
	 */
	public String getCardNo() {
		return cardNo;
	}

	/**
	 * @param cardNo the cardNo to set
	 */
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	/**
	 * @return the issueDate
	 */
	public String getIssueDate() {
		return issueDate;
	}

	/**
	 * @param issueDate the issueDate to set
	 */
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	/**
	 * @return the stat
	 */
	public String getStat() {
		return stat;
	}

	/**
	 * @param stat the stat to set
	 */
	public void setStat(String stat) {
		this.stat = stat;
	}

	/**
	 * @return the statNm
	 */
	public String getStatNm() {
		return statNm;
	}

	/**
	 * @param statNm the statNm to set
	 */
	public void setStatNm(String statNm) {
		this.statNm = statNm;
	}

	/**
	 * @return the statSeq
	 */
	public String getStatSeq() {
		return statSeq;
	}

	/**
	 * @param statSeq the statSeq to set
	 */
	public void setStatSeq(String statSeq) {
		this.statSeq = statSeq;
	}

	/**
	 * @return the cardKndNm
	 */
	public String getCardKndNm() {
		return cardKndNm;
	}

	/**
	 * @param cardKndNm the cardKndNm to set
	 */
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}

	/**
	 * @return the typeDesc
	 */
	public String getTypeDesc() {
		return typeDesc;
	}

	/**
	 * @param typeDesc the typeDesc to set
	 */
	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc;
	}

	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}

	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	 * @return the ridMbr
	 */
	public String getRidMbr() {
		return ridMbr;
	}

	/**
	 * @param ridMbr the ridMbr to set
	 */
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}




}
