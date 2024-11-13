package com.icignal.loyalty.tiers.membertier.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrTierHistListRequestDTO
* @date : 2019. 4. 18.
* @author : hy.jun
* @description : 회원상세 등급이력
*/
public class LoyMbrTierHistListReqDto extends MKTGridPagingReqDto {
	private String ridMbr;

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
}
