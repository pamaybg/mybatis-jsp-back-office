package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCampaignScheduleCheckReqDto extends CommonDataAuthReqDto {
	private String camId;	 //캪메인아이디
	private String chnlType; //채널타입
	
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
}
