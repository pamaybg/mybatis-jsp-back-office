package com.icignal.kepler.dashboard.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptCheckReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptCheckResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptResDto;
import com.icignal.kepler.dashboard.service.KprDashboardPromptService;


/*
 * 1. 클래스명	: KPRDashboardPromptController
 * 2. 파일명	: KPRDashboardPromptController.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.controller
 * 4. 작성자명	: KioLee
 * 5. 작성일자	: 2017. 12. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/dashboardPrompt" )
public class KprDashboardPromptController extends CommonController {
	
	@Autowired
	private KprDashboardPromptService kprDashboardPromptService;
	
	@Autowired
	AuthHelper authHelper;

	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
			HttpServletResponse response,Model model) {
		LogUtil.info("NavigatePopMenu start.....");
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}

	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}

	 /*
	  * 1. 메소드명: getDashboardCommonColumnList
	  * 2. 클래스명: KPRDashboardPromptController
	  * 3. 작성자명: KioLee 
	  * 4. 작성일자: 2017. 12. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 공통 컬럼 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getDashboardCommonColumnList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<KprDashboardPromptResDto> getDashboardCommonColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return kprDashboardPromptService.getDashboardCommonColumnList(reqDto);
	}

	 /*
	  * 1. 메소드명: getDashboardPromptList
	  * 2. 클래스명: KPRDashboardPromptController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2017. 12. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 프롬프트 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getDashboardPromptList.do", method = RequestMethod.POST)
	@ResponseBody
	public List<KprDashboardPromptResDto> getDashboardPromptList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());
		
		return kprDashboardPromptService.getDashboardPromptList(reqDto);
	}

	 /*
	  * 1. 메소드명: saveDashboardPrompt
	  * 2. 클래스명: KPRDashboardPromptController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2017. 12. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 프롬프트 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/saveDashboardPrompt.do", method = RequestMethod.POST)
	@ResponseBody
	public StatusResDto saveDashboardPrompt(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());
		
		return kprDashboardPromptService.saveDashboardPrompt(reqDto);
	}
	
	 /*
	  * 1. 메소드명: selectDashBoardPromptCheck
	  * 2. 클래스명: KPRDashboardPromptController
	  * 3. 작성자명: GYEONG YOUNG LEE
	  * 4. 작성일자: 2020. 07. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 프롬프트 값 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/selectDashBoardPromptCheck.do", method = RequestMethod.POST)
	public @ResponseBody 
	List<KprDashboardPromptCheckResDto> selectDashBoardPromptCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardPromptCheckReqDto param) {
		LogUtil.param(this.getClass(), param);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		param.setCreateBy(userInfo.getId());
		param.setModifyBy(userInfo.getId());
		
		return kprDashboardPromptService.selectDashBoardPromptCheck(param);
	}
}
