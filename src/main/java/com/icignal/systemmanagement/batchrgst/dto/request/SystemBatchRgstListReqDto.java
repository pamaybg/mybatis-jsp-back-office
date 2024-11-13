package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.Loyalty.batchRegist.dto.request.LoyBatchRegistListRequestDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
public class SystemBatchRgstListReqDto extends CommonDataAuthReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}
	
}
