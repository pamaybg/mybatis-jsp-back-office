package com.icignal.kepler.analysis.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.controller.KprAnalysisCommonController;
import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisChartLabelDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisChartSettingController
 * 2. 파일명	: KPRAnalysisChartSettingController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	:  
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/analysisChartSetting" })
public class KprAnalysisChartSettingController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;

	 /*
	  * 1. 메소드명: getAnalysisChartLabelDetail
	  * 2. 클래스명: KPRAnalysisChartSettingController
	  * 3. 작성자명:   
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getAnalysisChartLabelDetail.do", method = RequestMethod.POST)
	public @ResponseBody KprAnalysisChartLabelDetailResDto getAnalysisChartLabelDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisChartLabelDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		//return this.kprAnalysisChart.getAnalysisChartLabelDetail(reqDto);
		return this.kprAnalysisChartSettingService.getAnalysisChartLabelDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisChartLabelDetail
	  * 2. 클래스명: KPRAnalysisChartSettingController
	  * 3. 작성자명:   
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/editAnalysisChartLabelDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editAnalysisChartLabelDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisChartLabelDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		//return this.kprAnalysisChart.editAnalysisChartLabelDetail(reqDto);
		return this.kprAnalysisChartSettingService.editAnalysisChartLabelDetail(reqDto);
	}
}