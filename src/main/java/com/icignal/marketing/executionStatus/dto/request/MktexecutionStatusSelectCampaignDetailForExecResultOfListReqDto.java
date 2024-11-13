package com.icignal.marketing.executionStatus.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto extends CommonDataAuthReqDto {
	private String dataType;
	private String chnlId;
	private String itemId;
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

}
