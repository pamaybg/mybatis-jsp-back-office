package com.icignal.systemmanagement.log.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.common.log.dto.request.ICNLoginHistoryRequestDTO
 * @date : 2017. 6. 7.
 * @author : "dg.ryu"
 * @description : 개인정보 취급 이력 Request
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class SystemLoginHistoryReqDto extends CommonDataAuthReqDto {
	
	private String loginUserId;
	private String rid;
	
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	

}