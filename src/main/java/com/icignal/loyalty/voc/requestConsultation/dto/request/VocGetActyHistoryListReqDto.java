package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : VOCGetActyHistoryListRequestDTO.java
 * @date : 2017. 10. 17.
 * @author : jun.lee
 * @description : 활동내역 목록 조회
 */
public class VocGetActyHistoryListReqDto extends CommonDataAuthReqDto {
	
	private String ridSvcReq;

	
	public String getRidSvcReq() {
		return ridSvcReq;
	}
	public void setRidSvcReq(String ridSvcReq) {
		this.ridSvcReq = ridSvcReq;
	}
	
}

	
