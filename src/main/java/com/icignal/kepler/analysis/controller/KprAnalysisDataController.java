package com.icignal.kepler.analysis.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.controller.KprAnalysisCommonController;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDataReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDataResDto;

/*
 * 1. 클래스명	: KPRAnalysisDataController
 * 2. 파일명	: KPRAnalysisDataController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/analysisData" })
public class KprAnalysisDataController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getAnalysisDateFilterCheck
	  * 2. 클래스명: KPRAnalysisDataController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisDateFilterCheck.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDataResDto getAnalysisDateFilterCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDataReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisDataService.getAnalysisDateFilterCheck(adr);
	}

	 /*
	  * 1. 메소드명: getAnalysisPublishReport
	  * 2. 클래스명: KPRAnalysisDataController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisPublishReport.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDataResDto getAnalysisPublishReport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDataReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisDataService.getAnalysisPublishReport(adr);
	}
}