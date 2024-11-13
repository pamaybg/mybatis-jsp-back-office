package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;



public class AprvCountResDto extends GridPagingItemResDto{

	private String aprvReq;        //요청 건수
	private String lastApvrReq;    //미승인 건수
	
	public String getLastApvrReq() {
		return lastApvrReq;
	}
	public void setLastApvrReq(String lastApvrReq) {
		this.lastApvrReq = lastApvrReq;
	}
	public String getAprvReq() {
		return aprvReq;
	}
	public void setAprvReq(String aprvReq) {
		this.aprvReq = aprvReq;
	}
	
	
	
}
