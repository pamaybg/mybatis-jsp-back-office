package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.batchRgst.dto.request.LOYPntBatchRgstListRequestDTO
* @date : 2018. 11. 5.
* @author : hy.jun
* @description :
*/
public class LoyPntManualRgstListReqDto extends CommonDataAuthReqDto {
	private String rid;
	private String fileName; //원본 파일명
	private String status;
	private String errorDesc;
	private String itemRid;
	
	public String getItemRid() {
		return itemRid;
	}

	public void setItemRid(String itemRid) {
		this.itemRid = itemRid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getErrorDesc() {
		return errorDesc;
	}

	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
