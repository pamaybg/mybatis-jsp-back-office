/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
  * @fileName : LoyMbrTierHistRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 5.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 등급 이력
  */
public class LoyMbrIntactPurReqDto  extends CommonDataAuthReqDto {
	/** RID */
	private String rid;

	/** RID_채널 */
	private String ridChnl;

	/** RID_회원 */
	private String ridMbr;

	/** 카드 법인 채널 */
	private String ridCardCorpChnl;

	/** RID 카드 번호 */
	private String ridMbrCard;

	/** RID_INTACT_TYPE */
	private String ridIntactType;

	/** 발생 일자 */
	private String occuDate;

	/** 산출 완료 일자 */
	private String calcCmpltDate;

	/** 적립 완료 일자 */
	private String acrlCmpltDate;

	/** 적립 예외 사유 코드 */
	private String acrlExcptReasCd;

	/** 금액 */
	private String amt;

	/** 결제 수단 코드 */
	private String payMethdCd;

	/** 배송 수단 코드 */
	private String delvMethdCd;

	/** 결제 완료 일자 */
	private String payCmpltDate;

	/** 배송 완료 일자 */
	private String delvCmpltDate;

	/** 구매 상태 코드 */
	private String purStatCd;

	/** 취소 일자 */
	private String cancDate;

	/** 단말기 번호 */
	private String posNo;

	/** 영수증 번호 */
	private String rcptNo;

	/** 원 영수증 번호 */
	private String orgnRcptNo;

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
	 * @return the ridChnl
	 */
	public String getRidChnl() {
		return ridChnl;
	}

	/**
	 * @param ridChnl the ridChnl to set
	 */
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
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
	 * @return the ridCardCorpChnl
	 */
	public String getRidCardCorpChnl() {
		return ridCardCorpChnl;
	}

	/**
	 * @param ridCardCorpChnl the ridCardCorpChnl to set
	 */
	public void setRidCardCorpChnl(String ridCardCorpChnl) {
		this.ridCardCorpChnl = ridCardCorpChnl;
	}

	/**
	 * @return the ridMbrCard
	 */
	public String getRidMbrCard() {
		return ridMbrCard;
	}

	/**
	 * @param ridMbrCard the ridMbrCard to set
	 */
	public void setRidMbrCard(String ridMbrCard) {
		this.ridMbrCard = ridMbrCard;
	}

	/**
	 * @return the ridIntactType
	 */
	public String getRidIntactType() {
		return ridIntactType;
	}

	/**
	 * @param ridIntactType the ridIntactType to set
	 */
	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}

	/**
	 * @return the occuDate
	 */
	public String getOccuDate() {
		return occuDate;
	}

	/**
	 * @param occuDate the occuDate to set
	 */
	public void setOccuDate(String occuDate) {
		this.occuDate = occuDate;
	}

	/**
	 * @return the calcCmpltDate
	 */
	public String getCalcCmpltDate() {
		return calcCmpltDate;
	}

	/**
	 * @param calcCmpltDate the calcCmpltDate to set
	 */
	public void setCalcCmpltDate(String calcCmpltDate) {
		this.calcCmpltDate = calcCmpltDate;
	}

	/**
	 * @return the acrlCmpltDate
	 */
	public String getAcrlCmpltDate() {
		return acrlCmpltDate;
	}

	/**
	 * @param acrlCmpltDate the acrlCmpltDate to set
	 */
	public void setAcrlCmpltDate(String acrlCmpltDate) {
		this.acrlCmpltDate = acrlCmpltDate;
	}

	/**
	 * @return the acrlExcptReasCd
	 */
	public String getAcrlExcptReasCd() {
		return acrlExcptReasCd;
	}

	/**
	 * @param acrlExcptReasCd the acrlExcptReasCd to set
	 */
	public void setAcrlExcptReasCd(String acrlExcptReasCd) {
		this.acrlExcptReasCd = acrlExcptReasCd;
	}

	/**
	 * @return the amt
	 */
	public String getAmt() {
		return amt;
	}

	/**
	 * @param amt the amt to set
	 */
	public void setAmt(String amt) {
		this.amt = amt;
	}

	/**
	 * @return the payMethdCd
	 */
	public String getPayMethdCd() {
		return payMethdCd;
	}

	/**
	 * @param payMethdCd the payMethdCd to set
	 */
	public void setPayMethdCd(String payMethdCd) {
		this.payMethdCd = payMethdCd;
	}

	/**
	 * @return the delvMethdCd
	 */
	public String getDelvMethdCd() {
		return delvMethdCd;
	}

	/**
	 * @param delvMethdCd the delvMethdCd to set
	 */
	public void setDelvMethdCd(String delvMethdCd) {
		this.delvMethdCd = delvMethdCd;
	}

	/**
	 * @return the payCmpltDate
	 */
	public String getPayCmpltDate() {
		return payCmpltDate;
	}

	/**
	 * @param payCmpltDate the payCmpltDate to set
	 */
	public void setPayCmpltDate(String payCmpltDate) {
		this.payCmpltDate = payCmpltDate;
	}

	/**
	 * @return the delvCmpltDate
	 */
	public String getDelvCmpltDate() {
		return delvCmpltDate;
	}

	/**
	 * @param delvCmpltDate the delvCmpltDate to set
	 */
	public void setDelvCmpltDate(String delvCmpltDate) {
		this.delvCmpltDate = delvCmpltDate;
	}

	/**
	 * @return the purStatCd
	 */
	public String getPurStatCd() {
		return purStatCd;
	}

	/**
	 * @param purStatCd the purStatCd to set
	 */
	public void setPurStatCd(String purStatCd) {
		this.purStatCd = purStatCd;
	}

	/**
	 * @return the cancDate
	 */
	public String getCancDate() {
		return cancDate;
	}

	/**
	 * @param cancDate the cancDate to set
	 */
	public void setCancDate(String cancDate) {
		this.cancDate = cancDate;
	}

	/**
	 * @return the posNo
	 */
	public String getPosNo() {
		return posNo;
	}

	/**
	 * @param posNo the posNo to set
	 */
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}

	/**
	 * @return the rcptNo
	 */
	public String getRcptNo() {
		return rcptNo;
	}

	/**
	 * @param rcptNo the rcptNo to set
	 */
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}

	/**
	 * @return the orgnRcptNo
	 */
	public String getOrgnRcptNo() {
		return orgnRcptNo;
	}

	/**
	 * @param orgnRcptNo the orgnRcptNo to set
	 */
	public void setOrgnRcptNo(String orgnRcptNo) {
		this.orgnRcptNo = orgnRcptNo;
	}








}
