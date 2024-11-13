package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : MKTApproverListRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 승인자 추가 목록  조회
 */
public class ApproverListResDto extends GridPagingItemResDto{
	private String valid;					// 있으면 Y 없으면 N 
	private String rid;                    //아이디
	private String email;                 //요청 아이디
	private String seq;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getValid() {
		return valid;
	}
	public void setValid(String valid) {
		this.valid = valid;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	

	
	
	
	
}
