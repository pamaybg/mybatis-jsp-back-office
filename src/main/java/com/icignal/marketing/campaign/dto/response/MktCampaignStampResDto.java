package com.icignal.marketing.campaign.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MktCampaignStampListResDto.java
 * @date : 2018. 4. 26.
 * @author : 이필수
 * @description : 캠페인 B2C이벤트 스탬프형 목록 ResDto
 */
public class MktCampaignStampResDto extends StatusResDto {
	
	private String inactiveStampImgUrl;		//비활성스탬프 이미지 URL
	private String activeStampImgUrl;		//활성스탬프 이미지 URL
	
	List<MktCampaignStampListResDto> rows;
	

	public String getInactiveStampImgUrl() {
		return inactiveStampImgUrl;
	}

	public void setInactiveStampImgUrl(String inactiveStampImgUrl) {
		this.inactiveStampImgUrl = inactiveStampImgUrl;
	}

	public String getActiveStampImgUrl() {
		return activeStampImgUrl;
	}

	public void setActiveStampImgUrl(String activeStampImgUrl) {
		this.activeStampImgUrl = activeStampImgUrl;
	}

	public List<MktCampaignStampListResDto> getRows() {
		return rows;
	}

	public void setRows(List<MktCampaignStampListResDto> rows) {
		this.rows = rows;
	}
	
	

}
