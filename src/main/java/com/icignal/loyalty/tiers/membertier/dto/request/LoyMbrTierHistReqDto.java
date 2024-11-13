/**
 *
 */
package com.icignal.loyalty.tiers.membertier.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
  * @fileName : LoyMbrTierHistRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 5.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 등급 이력
  */
public class LoyMbrTierHistReqDto  extends CommonDataAuthReqDto {
	/** RID */
	private String rid;

	/** RID_MEM */
	private String ridMbr;

	/** RID_현재 등급 */
	private String ridCurTier;

	/** 유효 이력 여부 */
	private String validHistYn;

	/** 등급 산출 일자 */
	private String tierCalcDate;

	/** 유효 시작 일자 */
	private String validStartDt;

	/** 유효 종료 일자 */
	private String validEndDt;

	/** RID_이전 등급 */
	private String ridBefTier;

	/** 실적 추출 시작 일자 */
	private String rsltExtrStartDt;

	/** 실적 추출 종료 일자 */
	private String rsltExtrEndDt;

	/** RID_다음 등급 */
	private String ridNextTier;

	/** 현재 등급 적용 기준 금액 */
	private String curTierApplyBasAmt;

	/** 다음 등급 승급 기준 금액 */
	private String nextTierTierupBasAmt;

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

	/**
	 * @return the ridCurTier
	 */
	public String getRidCurTier() {
		return ridCurTier;
	}

	/**
	 * @param ridCurTier the ridCurTier to set
	 */
	public void setRidCurTier(String ridCurTier) {
		this.ridCurTier = ridCurTier;
	}

	/**
	 * @return the validHistYn
	 */
	public String getValidHistYn() {
		return validHistYn;
	}

	/**
	 * @param validHistYn the validHistYn to set
	 */
	public void setValidHistYn(String validHistYn) {
		this.validHistYn = validHistYn;
	}

	/**
	 * @return the tierCalcDate
	 */
	public String getTierCalcDate() {
		return tierCalcDate;
	}

	/**
	 * @param tierCalcDate the tierCalcDate to set
	 */
	public void setTierCalcDate(String tierCalcDate) {
		this.tierCalcDate = tierCalcDate;
	}

	/**
	 * @return the validStartDt
	 */
	public String getValidStartDt() {
		return validStartDt;
	}

	/**
	 * @param validStartDt the validStartDt to set
	 */
	public void setValidStartDt(String validStartDt) {
		this.validStartDt = validStartDt;
	}

	/**
	 * @return the validEndDt
	 */
	public String getValidEndDt() {
		return validEndDt;
	}

	/**
	 * @param validEndDt the validEndDt to set
	 */
	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}

	/**
	 * @return the ridBefTier
	 */
	public String getRidBefTier() {
		return ridBefTier;
	}

	/**
	 * @param ridBefTier the ridBefTier to set
	 */
	public void setRidBefTier(String ridBefTier) {
		this.ridBefTier = ridBefTier;
	}

	/**
	 * @return the rsltExtrStartDt
	 */
	public String getRsltExtrStartDt() {
		return rsltExtrStartDt;
	}

	/**
	 * @param rsltExtrStartDt the rsltExtrStartDt to set
	 */
	public void setRsltExtrStartDt(String rsltExtrStartDt) {
		this.rsltExtrStartDt = rsltExtrStartDt;
	}

	/**
	 * @return the rsltExtrEndDt
	 */
	public String getRsltExtrEndDt() {
		return rsltExtrEndDt;
	}

	/**
	 * @param rsltExtrEndDt the rsltExtrEndDt to set
	 */
	public void setRsltExtrEndDt(String rsltExtrEndDt) {
		this.rsltExtrEndDt = rsltExtrEndDt;
	}

	/**
	 * @return the ridNextTier
	 */
	public String getRidNextTier() {
		return ridNextTier;
	}

	/**
	 * @param ridNextTier the ridNextTier to set
	 */
	public void setRidNextTier(String ridNextTier) {
		this.ridNextTier = ridNextTier;
	}

	/**
	 * @return the curTierApplyBasAmt
	 */
	public String getCurTierApplyBasAmt() {
		return curTierApplyBasAmt;
	}

	/**
	 * @param curTierApplyBasAmt the curTierApplyBasAmt to set
	 */
	public void setCurTierApplyBasAmt(String curTierApplyBasAmt) {
		this.curTierApplyBasAmt = curTierApplyBasAmt;
	}

	/**
	 * @return the nextTierTierupBasAmt
	 */
	public String getNextTierTierupBasAmt() {
		return nextTierTierupBasAmt;
	}

	/**
	 * @param nextTierTierupBasAmt the nextTierTierupBasAmt to set
	 */
	public void setNextTierTierupBasAmt(String nextTierTierupBasAmt) {
		this.nextTierTierupBasAmt = nextTierTierupBasAmt;
	}







}
