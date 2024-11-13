package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.Loyalty.batchRegist.dto.request.LoyBatchRegistListRequestDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
public class SystemUpldItemListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String parRid;
	private String uploadRslt;
	
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getUploadRslt() {
		return uploadRslt;
	}

	public void setUploadRslt(String uploadRslt) {
		this.uploadRslt = uploadRslt;
	}
	
	
}
