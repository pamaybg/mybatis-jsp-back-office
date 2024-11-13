package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalEmpRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 기안자 조회
 */
public class ApprovalEmpReqDto extends CommonDataAuthReqDto{
	private String id;                 //아이디
	private String memId;              //맴버 아이디

	
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
