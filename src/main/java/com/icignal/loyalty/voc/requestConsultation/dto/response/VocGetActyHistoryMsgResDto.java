package com.icignal.loyalty.voc.requestConsultation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class VocGetActyHistoryMsgResDto extends GridPagingItemResDto {
	
	private String sbst;

	
	public String getSbst() {
		return sbst;
	}
	public void setSbst(String sbst) {
		this.sbst = sbst;
	}
	
}