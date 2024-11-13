package com.icignal.common.logging.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;



/**
 * @name : infavor.common.log.dto.request.ICNLoginHistoryRequestDTO
 * @date : 2017. 6. 7.
 * @author : "dg.ryu"
 * @description : 로그인 이력 Request
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class LoginHistoryReqDto extends CommonDataAuthReqDto {
	
	private String loginUserId;
	
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	
}