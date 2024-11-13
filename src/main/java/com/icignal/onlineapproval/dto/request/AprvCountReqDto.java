package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTApprvReqRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결재 승인자 조회
 */

public class AprvCountReqDto extends CommonDataAuthReqDto{
	private String id;
	private String memId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	
}
