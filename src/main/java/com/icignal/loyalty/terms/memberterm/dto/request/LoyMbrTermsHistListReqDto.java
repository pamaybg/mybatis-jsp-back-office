package com.icignal.loyalty.terms.memberterm.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrTermsHistListRequestDTO
* @date : 2018. 12. 14.
* @author : hy.jun
* @description :
*/
public class LoyMbrTermsHistListReqDto extends MKTGridPagingReqDto {
	private String ridMbr;

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
}
