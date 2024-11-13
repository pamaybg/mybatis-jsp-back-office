package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.marketing.elapproval.dto.request.MKTApprovalEmailTargetRequestDTO
* @date : 2018. 2. 1.
* @author : 이성원
* @description :
*/
public class ApprovalEmailTargetReqtDto extends CommonDataAuthReqDto {
    
    private String aprvRid;
    private String type;

	
	public String getAprvRid() {
		return aprvRid;
	}
	public void setAprvRid(String aprvRid) {
		this.aprvRid = aprvRid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

    
    
}
