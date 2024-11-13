package com.icignal.kepler.analysis.common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.service.KprAnalysisChartSettingService;
import com.icignal.kepler.analysis.service.KprAnalysisColumnService;
import com.icignal.kepler.analysis.service.KprAnalysisDataService;
import com.icignal.kepler.analysis.service.KprAnalysisFilterService;
import com.icignal.kepler.analysis.service.KprAnalysisPromptService;
import com.icignal.kepler.analysis.service.KprAnalysisService;
import com.icignal.kepler.analysis.service.KprAnalysisTableSettingService;


/*
 * 1. 클래스명	: KPRAnalysisCommonController
 * 2. 파일명	: KPRAnalysisCommonController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.controller
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
@RequestMapping({ "/kepler/analysisCommon" })
public class KprAnalysisCommonController extends BaseController {

	@Autowired
	public KprAnalysisService kprAnalysisService;

	@Autowired
	public KprAnalysisColumnService kprAnalysisColumnService;

	@Autowired
	public KprAnalysisPromptService kprAnalysisPromptService;

	@Autowired
	public KprAnalysisFilterService kprAnalysisFilterService;

	@Autowired
	public KprAnalysisChartSettingService kprAnalysisChartSettingService;

	@Autowired
	public KprAnalysisDataService kprAnalysisDataService;

	@Autowired
	public KprAnalysisTableSettingService kprAnalysisTableSettingService;

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnList
	  * 2. 클래스명: KPRAnalysisCommonController
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
	 *   @param acr
	 *   @return	
	 */
	@RequestMapping(value = "/getAnalysisAtribGroupColumnList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<KprAnalysisAtribGroupColumnDetailResDto> getAnalysisAtribGroupColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisCommonReqDto acr) {
		LogUtil.param(KprAnalysisCommonController.class, acr);

		return kprAnalysisService.getAnalysisAtribGroupColumnList(acr);
	}
}