package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTGetUserIpInfoListResponseDTO.java
 * @date : 2017. 11. 21.
 * @author : jun.lee
 * @description : 로그인 시, 유저 ip 정보 체크
 */
public class UserIpInfoListReqDto extends CommonDataAuthReqDto {
	
	private String rid;

	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}

	
