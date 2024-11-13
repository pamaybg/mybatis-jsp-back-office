package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrPntYnResponseDTO
* @date : 2019. 1. 25.
* @author : hy.jun
* @description : 회원 포인트 적립/사용 가능여부 조회
*/
public class LoyMbrPntYnResDto extends StatusResDto {
	private boolean pntAcrlYn;
	private boolean pntUseYn;
	
	public boolean isPntAcrlYn() {
		return pntAcrlYn;
	}
	public void setPntAcrlYn(boolean pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}
	public boolean isPntUseYn() {
		return pntUseYn;
	}
	public void setPntUseYn(boolean pntUseYn) {
		this.pntUseYn = pntUseYn;
	}
}
