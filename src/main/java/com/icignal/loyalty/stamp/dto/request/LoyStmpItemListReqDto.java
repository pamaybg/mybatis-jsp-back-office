package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpItemListRequestDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpItemListReqDto extends MKTGridPagingReqDto {
	private String ridStmp;

	public String getRidStmp() {
		return ridStmp;
	}

	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
}
