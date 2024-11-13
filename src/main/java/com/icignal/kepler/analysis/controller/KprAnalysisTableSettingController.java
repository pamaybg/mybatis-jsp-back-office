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
import com.icignal.kepler.analysis.dto.request.KprAnalysisTableDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisTableDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisTableSettingController
 * 2. 파일명	: KPRAnalysisTableSettingController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 6. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping(value = "/kepler/analysisTableSetting")
public class KprAnalysisTableSettingController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;

	 /*
	  * 1. 메소드명: getAnalysisTableDetail
	  * 2. 클래스명: KPRAnalysisTableSettingController
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 6. 4.
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
	@RequestMapping(value = "/getAnalysisTableDetail.do", method = RequestMethod.POST)
	public @ResponseBody KprAnalysisTableDetailResDto getAnalysisTableDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisTableDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return this.kprAnalysisTableSettingService.getAnalysisTableDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisTableDetail
	  * 2. 클래스명: KPRAnalysisTableSettingController
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 6. 4.
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
	@RequestMapping(value = "/editAnalysisTableDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editAnalysisTableDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisTableDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return this.kprAnalysisTableSettingService.editAnalysisChartLabelDetail(reqDto);
	}
}