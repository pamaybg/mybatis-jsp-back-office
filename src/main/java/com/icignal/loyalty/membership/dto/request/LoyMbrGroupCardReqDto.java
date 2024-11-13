package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrGroupCardReqDto extends CommonDataAuthReqDto {

	private String cardNo;
	private String cardKindCd;
	private String stat;
	private String ridMbr;
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardKindCd() {
		return cardKindCd;
	}
	public void setCardKindCd(String cardKindCd) {
		this.cardKindCd = cardKindCd;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}



}
