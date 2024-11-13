package com.icignal.kepler.externalRequest.controlller;

import java.util.Arrays;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CookieUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonGridReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDataReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDataResDto;
import com.icignal.kepler.analysis.service.KprAnalysisDataService;
import com.icignal.kepler.analysis.service.KprAnalysisService;
import com.icignal.kepler.externalRequest.dto.response.KprExternalRequestDashboardResDto;
import com.icignal.kepler.externalRequest.service.KprExternalRequestService;

/*
 * 1. 클래스명	: KPRExternalRequestController
 * 2. 파일명	: KPRExternalRequestController.java
 * 3. 패키지명	: com.icignal.kepler.externalRequest.controlller
 * 4. 작성자명	: KioLee
 * 5. 작성일자	: 2016. 10. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/externalRequest" })
public class KprExternalRequestController extends CommonController {

	@Autowired
	private KprExternalRequestService kprExternalRequestService;

	@Autowired
	private KprAnalysisService kprAnalysisService;

	@Autowired
	private KprAnalysisDataService kprAanlysisDataService;
	
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

	 /*
	  * 1. 메소드명: ExternalRequestAnalysis
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param analysisId
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = { "/analysis/{analysisId:.+}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String ExternalRequestAnalysis(@PathVariable("analysisId") String analysisId, HttpServletRequest request, HttpServletResponse response) {
		String lang = ObjectUtil.isNotEmpty(request.getParameter("lang")) ? request.getParameter("lang") : CommonUtil.getInstance().getServletProp("context.server.lang");
		KprExternalRequestDashboardResDto externalRequestAnalysisRes = kprExternalRequestService.getExternalAnalysisDetail(analysisId);

		if (ObjectUtil.isNotEmpty(externalRequestAnalysisRes)) {
			LoginResDto externalUserInfo = new LoginResDto();
			externalUserInfo.setEmpId(externalRequestAnalysisRes.getEmpId());
			externalUserInfo.setLang(lang);

			HttpSession session = request.getSession(true);
			session.setAttribute("EXTERNAL_USER_INFO", externalUserInfo);

			CookieUtil.createCookie(request, response, externalRequestAnalysisRes.getEmpId(), externalRequestAnalysisRes.getAppServiceId(), externalRequestAnalysisRes.getCountry(), lang);

			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			Locale locale = new Locale(lang);
			localeResolver.setLocale(request, response, locale);

			request.setAttribute("analysisId", analysisId);
			request.setAttribute("analysisName", externalRequestAnalysisRes.getAnalysisName());

			return "/kepler/externalRequest/externalAnalysis.external-tiles";
		}
		return null;
	}

	 /*
	  * 1. 메소드명: ExternalRequestAnalysisInclude
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param analysisId
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = { "/include/analysis/{analysisId:.+}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String ExternalRequestAnalysisInclude(@PathVariable("analysisId") String analysisId, HttpServletRequest request, HttpServletResponse response) {
		String lang = ObjectUtil.isNotEmpty(request.getParameter("lang")) ? request.getParameter("lang") : CommonUtil.getInstance().getServletProp("context.server.lang");
		KprExternalRequestDashboardResDto externalRequestAnalysisRes = kprExternalRequestService.getExternalAnalysisDetail(analysisId);

		if (ObjectUtil.isNotEmpty(externalRequestAnalysisRes)) {
			LoginResDto externalUserInfo = new LoginResDto();
			externalUserInfo.setEmpId(externalRequestAnalysisRes.getEmpId());
			externalUserInfo.setLang(lang);

			HttpSession session = request.getSession(true);
			session.setAttribute("EXTERNAL_USER_INFO", externalUserInfo);

			CookieUtil.createCookie(request, response, externalRequestAnalysisRes.getEmpId(), externalRequestAnalysisRes.getAppServiceId(), externalRequestAnalysisRes.getCountry(), lang);

			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			Locale locale = new Locale(lang);
			localeResolver.setLocale(request, response, locale);

			request.setAttribute("analysisId", analysisId);
			request.setAttribute("analysisName", externalRequestAnalysisRes.getAnalysisName());

			return "/kepler/externalRequest/externalAnalysis";
		}
		return null;
	}
	
	 /*
	  * 1. 메소드명: ExternalRequestDashboard
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dashboardId
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = { "/dashboard/{dashboardId:.+}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String ExternalRequestDashboard(@PathVariable("dashboardId") String dashboardId, HttpServletRequest request, HttpServletResponse response) {
		String lang = ObjectUtil.isNotEmpty(request.getParameter("lang")) ? request.getParameter("lang") : CommonUtil.getInstance().getServletProp("context.server.lang");
		KprExternalRequestDashboardResDto externalRequestDashboardRes = kprExternalRequestService.getExternalDashboardDetail(dashboardId);

		if (ObjectUtil.isNotEmpty(externalRequestDashboardRes)) {
			LoginResDto externalUserInfo = new LoginResDto();
			externalUserInfo.setEmpId(externalRequestDashboardRes.getEmpId());
			externalUserInfo.setLang(lang);

			HttpSession session = request.getSession(true);
			session.setAttribute("EXTERNAL_USER_INFO", externalUserInfo);

			CookieUtil.createCookie(request, response, externalRequestDashboardRes.getEmpId(), externalRequestDashboardRes.getAppServiceId(), externalRequestDashboardRes.getCountry(), lang);

			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			Locale locale = new Locale(lang);
			localeResolver.setLocale(request, response, locale);

			request.setAttribute("dashboardId", dashboardId);

			return "/kepler/externalRequest/externalDashboard.external-tiles";
		}
		return null;
	}
	
	 /*
	  * 1. 메소드명: ExternalRequestDashboardInclude
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dashboardId
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = { "/include/dashboard/{dashboardId:.+}" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET })
	public String ExternalRequestDashboardInclude(@PathVariable("dashboardId") String dashboardId, HttpServletRequest request, HttpServletResponse response) {
		String lang = ObjectUtil.isNotEmpty(request.getParameter("lang")) ? request.getParameter("lang") : CommonUtil.getInstance().getServletProp("context.server.lang");
		KprExternalRequestDashboardResDto externalRequestDashboardRes = kprExternalRequestService.getExternalDashboardDetail(dashboardId);

		if (ObjectUtil.isNotEmpty(externalRequestDashboardRes)) {
			LoginResDto externalUserInfo = new LoginResDto();
			externalUserInfo.setEmpId(externalRequestDashboardRes.getEmpId());
			externalUserInfo.setLang(lang);

			HttpSession session = request.getSession(true);
			session.setAttribute("EXTERNAL_USER_INFO", externalUserInfo);

			CookieUtil.createCookie(request, response, externalRequestDashboardRes.getEmpId(), externalRequestDashboardRes.getAppServiceId(), externalRequestDashboardRes.getCountry(), lang);

			LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
			Locale locale = new Locale(lang);
			localeResolver.setLocale(request, response, locale);

			request.setAttribute("dashboardId", dashboardId);

			return "/kepler/externalRequest/externalDashboard";
		}
		return null;
	}

	 /*
	  * 1. 메소드명: getExternalAttributeGroupColumnValueList
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
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
	 *   @param paramDto
	 *   @return	
	 */
	@RequestMapping(value = { "/getExternalAttributeGroupColumnValueList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public GridPagingResDto<Object> getExternalAttributeGroupColumnValueList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisCommonGridReqDto paramDto) {
		LogUtil.param(KprExternalRequestController.class, paramDto);

		HttpSession session = request.getSession(true);
		LoginResDto externalUserInfo = (LoginResDto) session.getAttribute("EXTERNAL_USER_INFO");


		return kprAnalysisService.getAnalysisAtribGroupColumnValueList(paramDto);
	}

	 /*
	  * 1. 메소드명: getExternalAnalysisPublishReport
	  * 2. 클래스명: KPRExternalRequestController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
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
	 *   @param paramDto
	 *   @return	
	 */
	@RequestMapping(value = { "/getExternalAnalysisPublishReport.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDataResDto getExternalAnalysisPublishReport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDataReqDto paramDto) {
		LogUtil.param(KprExternalRequestController.class, paramDto);

		HttpSession session = request.getSession(true);
		LoginResDto externalUserInfo = (LoginResDto) session.getAttribute("EXTERNAL_USER_INFO");

		paramDto.setEmpId(externalUserInfo.getEmpId());

		return kprAanlysisDataService.getAnalysisPublishReport(paramDto);
	}
}
