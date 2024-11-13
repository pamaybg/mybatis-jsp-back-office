package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.auth.dto.response.AuthMenuListResDto;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYBatchRgstUploadResponseDTO
* @date : 2017. 11. 28.
* @author : kimjunki
* @description :
*/
public class SystemBatchRgstUploadResDto extends AuthMenuListResDto {

	private String mbrId;
	private String saveStamp;
	private String stampDiv;
	private String mbrNo;
	private String ridMbr;
	
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getSaveStamp() {
		return saveStamp;
	}
	public void setSaveStamp(String saveStamp) {
		this.saveStamp = saveStamp;
	}
	public String getStampDiv() {
		return stampDiv;
	}
	public void setStampDiv(String stampDiv) {
		this.stampDiv = stampDiv;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	
	

}
