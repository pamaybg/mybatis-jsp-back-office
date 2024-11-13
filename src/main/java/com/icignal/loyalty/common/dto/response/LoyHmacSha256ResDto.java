package com.icignal.loyalty.common.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
* @name : infavor.loyalty.common.dto.response.LOYHmacSha256ResponseDTO
* @date : 2018. 11. 26.
* @author : hy.jun
* @description :
*/
public class LoyHmacSha256ResDto extends StatusResDto {
	private String plainData; //원문
	private String encData; //암호화된 값
	
	public String getPlainData() {
		return plainData;
	}
	public void setPlainData(String plainData) {
		this.plainData = plainData;
	}
	public String getEncData() {
		return encData;
	}
	public void setEncData(String encData) {
		this.encData = encData;
	}
}
