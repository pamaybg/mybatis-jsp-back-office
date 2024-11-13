package com.icignal.loyalty.voc.requestConsultation.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class VocGetActyHistoryMsgReqDto extends MKTGridPagingReqDto {
	
	private String rid;

	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
}