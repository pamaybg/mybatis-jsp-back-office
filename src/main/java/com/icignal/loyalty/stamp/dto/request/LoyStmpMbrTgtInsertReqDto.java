package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpMbrTgtInsertRequestDTO
* @date : 2019. 4. 24.
* @author : hy.jun
* @description :
*/
public class LoyStmpMbrTgtInsertReqDto extends MKTBaseReqDto {
	private String ridStmp;
	private String mbrNo;
	
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
}
