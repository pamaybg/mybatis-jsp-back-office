package com.icignal.loyalty.stamp.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpStoreInsertRequestDTO
* @date : 2019. 4. 12.
* @author : hy.jun
* @description :
*/
public class LoyStmpStoreInsertReqDto extends MKTBaseReqDto {
	private String ridStmp;
	private String ridChnl;
	
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
}
