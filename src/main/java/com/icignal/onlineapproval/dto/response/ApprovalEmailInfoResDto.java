package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
* @name : infavor.marketing.elapproval.dto.response.MKTApprovalEmailTargetResponseDTO
* @date : 2018. 2. 1.
* @author : 이성원
* @description :
*/
public class ApprovalEmailInfoResDto extends GridPagingItemResDto{
	 
	public String rqtrNm ;
	public String apvrNm ;
	public String type;
	private String elecAprvType; //전자결재 업무유형
	private String aprvRid; //전자결재 헤더 아이디
	private String rejectRsn; //반려사유
	
	public String getRqtrNm() {
		return rqtrNm;
	}
	public void setRqtrNm(String rqtrNm) {
		this.rqtrNm = rqtrNm;
	}
	public String getApvrNm() {
		return apvrNm;
	}
	public void setApvrNm(String apvrNm) {
		this.apvrNm = apvrNm;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getElecAprvType() {
		return elecAprvType;
	}
	public void setElecAprvType(String elecAprvType) {
		this.elecAprvType = elecAprvType;
	}
	public String getAprvRid() {
		return aprvRid;
	}
	public void setAprvRid(String aprvRid) {
		this.aprvRid = aprvRid;
	}
	public String getRejectRsn() {
		return rejectRsn;
	}
	public void setRejectRsn(String rejectRsn) {
		this.rejectRsn = rejectRsn;
	}
	
	
	
	

}
