package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : MktCampaignEntryInfoReqDto.java
 * @date : 2018. 04. 25.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 설문형  ReqDto
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignSurveyInfoReqDto extends MKTBaseReqDto {
    
	private String ridCam;						//캠페인 RID
	
	private List<String> notDelRids;			//삭제 제외 RID
	
	private List<MktCampaignSurveyListReqDto> rows;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRidCam() {
		return ridCam;
	}

	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}

	public List<String> getNotDelRids() {
		return notDelRids;
	}

	public void setNotDelRids(List<String> notDelRids) {
		this.notDelRids = notDelRids;
	}

	public List<MktCampaignSurveyListReqDto> getRows() {
		return rows;
	}

	public void setRows(List<MktCampaignSurveyListReqDto> rows) {
		this.rows = rows;
	}


}
