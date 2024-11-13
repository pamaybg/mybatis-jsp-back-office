package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYPntBatchRgstUploadResponseDTO
* @date : 2018. 11. 5.
* @author : hy.jun
* @description :
*/
public class SystemPntBatchRgstUploadResDto extends StatusResDto {
	private String mbrNo;
	private String rid;
	private String hhpNo;
	private String custNm;
	
	
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
	
}
