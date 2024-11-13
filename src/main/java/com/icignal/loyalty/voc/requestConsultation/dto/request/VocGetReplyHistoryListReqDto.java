package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : VOCGetActyHistoryListRequestDTO.java
 * @date : 2017. 10. 17.
 * @author : jun.lee
 * @description : 활동내역 목록 조회
 */
public class VocGetReplyHistoryListReqDto extends CommonDataAuthReqDto {
	
	private String rid;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	
}

	
