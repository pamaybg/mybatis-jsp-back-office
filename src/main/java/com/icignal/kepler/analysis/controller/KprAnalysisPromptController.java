package com.icignal.kepler.analysis.controller;

import java.util.List;

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
import com.icignal.kepler.analysis.dto.request.KprAnalysisPromptDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisPromptDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisPromptController
 * 2. 파일명	: KPRAnalysisPromptController.java
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
@RequestMapping({ "/kepler/analysisPrompt" })
public class KprAnalysisPromptController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getAnalysisPromptList
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisPromptList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisPromptDetailResDto> getAnalysisPromptList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.getAnalysisPromptList(apr);
	}

	 /*
	  * 1. 메소드명: getAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisPromptDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisPromptDetailResDto getAnalysisPromptDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.getAnalysisPromptDetail(apr);
	}

	 /*
	  * 1. 메소드명: addAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/addAnalysisPromptDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto addAnalysisPromptDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.addAnalysisPromptDetail(apr);
	}

	 /*
	  * 1. 메소드명: editAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisPromptDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisPromptDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.editAnalysisPromptDetail(apr);
	}

	 /*
	  * 1. 메소드명: editAnalysisPromptAllSequence
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisPromptAllSequence.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisPromptAllSequence(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.editAnalysisPromptAllSequence(apr);
	}

	 /*
	  * 1. 메소드명: removeAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value = { "/removeAnalysisPromptDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto removeAnalysisPromptDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisController.class, apr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		apr.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.removeAnalysisPromptDetail(apr);
	}
	
	 /*
	  * 1. 메소드명: removeAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptController
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
	 *   @param apr
	 *   @return	
	 */
	@RequestMapping(value ="/selectAnalysisPromptCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public List<KprAnalysisPromptDetailResDto> selectAnalysisPromptCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisPromptDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(userInfo.getId());

		return this.kprAnalysisPromptService.selectAnalysisPromptCheck(param);
	}
}