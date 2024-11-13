package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;




/**
 * @name : VOCGetRecordFileListRequestDTO.java
 * @date : 2017. 11. 30.
 * @author : jun.lee
 * @description : 녹취청취 목록 조회 
 */
public class VocGetRecordFileListReqDto extends CommonDataAuthReqDto {
	
	private String callId;
	private String callDate;
	
	private String callIdFlag;
	
	
	public String getCallId() {
		return callId;
	}
	public void setCallId(String callId) {
		this.callId = callId;
	}
	public String getCallDate() {
		return callDate;
	}
	public void setCallDate(String callDate) {
		this.callDate = callDate;
	}
	public String getCallIdFlag() {
		return callIdFlag;
	}
	public void setCallIdFlag(String callIdFlag) {
		this.callIdFlag = callIdFlag;
	}
	
}

	
