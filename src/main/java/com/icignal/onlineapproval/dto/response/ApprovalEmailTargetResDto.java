package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


/**
* @name : infavor.marketing.elapproval.dto.response.MKTApprovalEmailTargetResponseDTO
* @date : 2018. 2. 1.
* @author : 이성원
* @description :
*/

@PersonalData
public class ApprovalEmailTargetResDto extends GridPagingItemResDto{

	public String recordRid ;
	public String tableNm ;
	public String aprvType; 
	public String rqtrRid ;
	
	@Decrypted(masked = "email")
	public String rqtrEmail ;
	public String apvrRid;
	
	@Decrypted(masked = "email")
	public String apvrEmail; 
	private String apvrNm; 
	private String rqtrNm;
	
	
	public String getRecordRid() {
		return recordRid;
	}
	public void setRecordRid(String recordRid) {
		this.recordRid = recordRid;
	}
	public String getTableNm() {
		return tableNm;
	}
	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}
	public String getAprvType() {
		return aprvType;
	}
	public void setAprvType(String aprvType) {
		this.aprvType = aprvType;
	}
	public String getRqtrRid() {
		return rqtrRid;
	}
	public void setRqtrRid(String rqtrRid) {
		this.rqtrRid = rqtrRid;
	}
	public String getApvrRid() {
		return apvrRid;
	}
	public void setApvrRid(String apvrRid) {
		this.apvrRid = apvrRid;
	}
	public String getRqtrEmail() {
		return rqtrEmail;
	}
	public void setRqtrEmail(String rqtrEmail) {
		this.rqtrEmail = rqtrEmail;
	}
	public String getApvrEmail() {
		return apvrEmail;
	}
	public void setApvrEmail(String apvrEmail) {
		this.apvrEmail = apvrEmail;
	}
	public String getApvrNm() {
		return apvrNm;
	}
	public void setApvrNm(String apvrNm) {
		this.apvrNm = apvrNm;
	}
	public String getRqtrNm() {
		return rqtrNm;
	}
	public void setRqtrNm(String rqtrNm) {
		this.rqtrNm = rqtrNm;
	}


	
	
	

}
