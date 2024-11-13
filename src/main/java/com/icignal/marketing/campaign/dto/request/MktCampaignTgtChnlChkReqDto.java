package com.icignal.marketing.campaign.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignTgtChnlChkReqDto extends CommonDataAuthReqDto {
	
	private String id;		//회원 상세 아이디
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

}
