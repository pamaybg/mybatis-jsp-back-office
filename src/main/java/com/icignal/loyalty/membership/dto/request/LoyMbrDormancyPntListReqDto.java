package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrDormancyPntListRequestDTO
* @date : 2018. 12. 11.
* @author : hy.jun
* @description :
*/
public class LoyMbrDormancyPntListReqDto extends CommonDataAuthReqDto {
	private String ridMbr;

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
}
