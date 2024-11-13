package com.icignal.marketing.calendar.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.calendar.dto.request.MktgetCampaignReqDto;
import com.icignal.marketing.calendar.dto.response.MktgetCampaignResDto;
import com.icignal.marketing.calendar.service.MktCalendarService;






/**
 * @name : 캘린더 Controller
 * @date : 2015. 11. 13.
 * @author 안형욱
 * @description : 캘린더 컨트롤러
 */
@Controller
@RequestMapping("/marketing/calendar")
public class MktCalendarController extends BaseController{
	@Autowired
	private MktCalendarService CalendarService;
	
	
	
	/**
	 * @name : getCampaignType
	 * @date : 2015. 11. 16.
	 * @author : 안형욱
	 * @return : MKTgetCampaignResponseDTO
	 * @description : 캠페인 유형명 조회 
	 */
	@RequestMapping(value="/getCampaignType.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktgetCampaignResDto> getCampaignType(HttpServletRequest request, HttpServletResponse response, @RequestBody MktgetCampaignReqDto dto) {
		LogUtil.param(MktCalendarController.class,dto);	
		dto.setLoginInfo(this.checkLoginSession(request, response));
		return CalendarService.getCampaignType(dto);
	}
	
	/**
	 * @name : getCampaign
	 * @date : 2015. 11. 16.
	 * @author : 안형욱
	 * @return : MKTgetCampaignResponseDTO
	 * @description : 캠페인 조회 
	 */
	@RequestMapping(value="/getCampaign.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktgetCampaignResDto> getCampaign(HttpServletRequest request, HttpServletResponse response, @RequestBody MktgetCampaignReqDto dto) {
		LogUtil.param(MktCalendarController.class,dto);	
		dto.setLoginInfo(this.checkLoginSession(request, response));	
		dto.setStrAuthDataIn(this.getSessionAuthority(request));
		
		return CalendarService.getCampaign(dto);
	}
	
}