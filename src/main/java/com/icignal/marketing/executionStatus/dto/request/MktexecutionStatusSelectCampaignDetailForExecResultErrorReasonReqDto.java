package com.icignal.marketing.executionStatus.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto extends CommonDataAuthReqDto {
	private String id;
	private String chnlId;
	private String dataType;
	
	
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	
	
}
