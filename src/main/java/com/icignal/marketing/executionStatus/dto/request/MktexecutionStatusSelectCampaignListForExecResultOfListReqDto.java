package com.icignal.marketing.executionStatus.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktexecutionStatusSelectCampaignListForExecResultOfListReqDto extends CommonDataAuthReqDto {
	private String camId;

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}
	
}
