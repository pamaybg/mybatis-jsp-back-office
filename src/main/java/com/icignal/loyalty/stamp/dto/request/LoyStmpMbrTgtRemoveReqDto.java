package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpMbrTgtRemoveRequestDTO
* @date : 2019. 4. 22.
* @author : hy.jun
* @description :
*/
public class LoyStmpMbrTgtRemoveReqDto extends MKTBaseReqDto {
	private String ridStmp;

	public String getRidStmp() {
		return ridStmp;
	}

	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
}
