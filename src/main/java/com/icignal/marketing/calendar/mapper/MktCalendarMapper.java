package com.icignal.marketing.calendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.calendar.dto.request.MktgetCampaignReqDto;
import com.icignal.marketing.calendar.dto.response.MktgetCampaignResDto;

@Mapper
public interface MktCalendarMapper {

	public List<MktgetCampaignResDto> getCampaignType(MktgetCampaignReqDto dto);

	public List<MktgetCampaignResDto> getCampaign(MktgetCampaignReqDto dto);

}
