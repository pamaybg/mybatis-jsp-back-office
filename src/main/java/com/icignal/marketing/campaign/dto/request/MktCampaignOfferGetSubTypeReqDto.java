package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktCampaignOfferGetSubTypeReqDto extends MKTBaseReqDto{
	private String camId;	//캠페인 아이디
	private String subType;	//오퍼 서브 타입
	
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getSubType() {
		return subType;
	}
	public void setSubType(String subType) {
		this.subType = subType;
	}
	
	
}
