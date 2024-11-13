package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrPntYnRequestDTO
* @date : 2019. 1. 25.
* @author : hy.jun
* @description : 회원 포인트 적립/사용 가능여부 조회
*/
public class LoyMbrPntYnReqDto extends MKTBaseReqDto {
	private String mbrNo;

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
}
