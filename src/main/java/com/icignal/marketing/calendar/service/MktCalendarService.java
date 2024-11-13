package com.icignal.marketing.calendar.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.calendar.dto.request.MktgetCampaignReqDto;
import com.icignal.marketing.calendar.dto.response.MktgetCampaignResDto;
import com.icignal.marketing.calendar.mapper.MktCalendarMapper;


/**
	@file MKTCalendarService.java
	@date 2015. 11. 13.
	@author 안형욱
*/
@Service
public class MktCalendarService {
	@Autowired
	private MktCalendarMapper MKTCalendarDAO;


	/**
	 * @name : getCampaignType
	 * @date : 2015. 11. 16.
	 * @author : 안형욱
	 * @return : MKTgetCampaignTypeResponseDTO
	 * @description : 캠페인 유형 조회 
	 */
	
	public GridPagingResDto<MktgetCampaignResDto> getCampaignType(MktgetCampaignReqDto dto) {
		LogUtil.param(MktCalendarService.class, dto);		     		
		return new GridPagingResHelper<MktgetCampaignResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				MKTCalendarDAO.getCampaignType(dto));
				
				
	}
	/**
	 * @name : getCampaign
	 * @date : 2015. 11. 16.
	 * @author : 안형욱
	 * @return : MKTgetCampaignResponseDTO
	 * @description : 캠페인 조회 
	 */
	
	public GridPagingResDto<MktgetCampaignResDto> getCampaign(MktgetCampaignReqDto dto) {
		LogUtil.param(MktCalendarService.class, dto);	
		dto.setSVCAlias("mcm");
		dto.setAuthAlias("mcm");
		return new GridPagingResHelper<MktgetCampaignResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				MKTCalendarDAO.getCampaign(dto));
	}
}
