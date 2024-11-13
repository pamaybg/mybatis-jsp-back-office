package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTApproverListRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 승인자 추가 목록  조회
 */
public class ApproverListReqDto extends CommonDataAuthReqDto{
	private String id;                    //아이디
	private String memId;                 //요청 아이디
	private String seq;
	private String apprRid;
	private String apvrTypeCd;
	
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

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getApprRid() {
		return apprRid;
	}

	public void setApprRid(String apprRid) {
		this.apprRid = apprRid;
	}

	public String getApvrTypeCd() {
		return apvrTypeCd;
	}

	public void setApvrTypeCd(String apvrTypeCd) {
		this.apvrTypeCd = apvrTypeCd;
	}
	
	
	
	
}
