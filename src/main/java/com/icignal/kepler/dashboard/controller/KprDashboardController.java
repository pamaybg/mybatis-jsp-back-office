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
import com.icignal.kepler.dashboard.dto.request.KprDashboardDetailReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPublishDataReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardDetailResDto;
import com.icignal.kepler.dashboard.service.KprDashboardService;

/*
 * 1. 클래스명	: KPRDashboardController
 * 2. 파일명	: KPRDashboardController.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.controller
 * 4. 작성자명	: kj.kang
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		Dashboard controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/dashboard")
public class KprDashboardController extends CommonController {
	
	@Autowired
	private KprDashboardService iKPRDashboardService;
	
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

	@RequestMapping(value = "/tab/{name:.+}")
	public String NavigateTabMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return authHelper.checkUserInfoInclude(request, response, "kepler/dashboard/" + name);
	}
	
	 /*
	  * 1. 메소드명: getDashboardLayoutList
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/getDashboardLayoutList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDashboardDetailResDto> getDashboardLayoutList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.getDashboardLayoutList(reqDto);
	}

	 /*
	  * 1. 메소드명: getDashboardDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/getDashboardDetail.do", method = RequestMethod.POST)
	public @ResponseBody KprDashboardDetailResDto getDashboardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.getDashboardDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getDashboardNameCheck
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/getDashboardNameCheck.do", method = RequestMethod.POST)
	public @ResponseBody KprDashboardDetailResDto getDashboardNameCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.getDashboardNameCheck(reqDto);
	}

	 /*
	  * 1. 메소드명: addDashboardDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/addDashboardDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addDashboardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.addDashboardDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editDashboardDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/editDashboardDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editDashboardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.editDashboardDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editDashboardDetailSave
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/editDashboardDetailSave.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editDashboardDetailSave(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.editDashboardDetailSave(reqDto);
	}

	 /*
	  * 1. 메소드명: editDashboardDetailSaveAs
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/editDashboardDetailSaveAs.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editDashboardDetailSaveAs(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.editDashboardDetailSaveAs(reqDto);
	}

	 /*
	  * 1. 메소드명: removeDashboardDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/removeDashboardDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDashboardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.removeDashboardDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: addDashboardAnalysisDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/addDashboardAnalysisDetail.do", method = RequestMethod.POST)
	public @ResponseBody KprDashboardDetailResDto addDashboardAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.addDashboardAnalysisDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: removeDashboardAnalysisDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/removeDashboardAnalysisDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDashboardAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.removeDashboardAnalysisDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: removeDashboardAnalysisList
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 6. 30.
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
	@RequestMapping(value = "/removeDashboardAnalysisList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDashboardAnalysisList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(userInfo.getId());
		reqDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.removeDashboardAnalysisList(reqDto);
	}

	 /*
	  * 1. 메소드명: getPublishDashboardDetail
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: KioLee 
	  * 4. 작성일자: 2016. 10. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		Publish 및 External 용 대시보드 요청
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param paramDto
	 *   @return	
	 */
	@RequestMapping(value = "/getPublishDashboardDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getPublishDashboardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardPublishDataReqDto paramDto) {
		LogUtil.param(KprDashboardController.class, paramDto);

		return iKPRDashboardService.getPublishDashboardDetail(paramDto);
	}

	 /*
	  * 1. 메소드명: editDashboardDetailCopy
	  * 2. 클래스명: KPRDashboardController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 10. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 인스턴스 복사 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param paramDto
	 *   @return	
	 */
	@RequestMapping(value = "/editDashboardDetailCopy.do", method = RequestMethod.POST)
	public @ResponseBody KprDashboardDetailResDto editDashboardDetailCopy(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDashboardDetailReqDto paramDto) {
		LogUtil.param(KprDashboardController.class, paramDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		paramDto.setLoginInfo(userInfo);
		paramDto.setCreateBy(userInfo.getId());
		paramDto.setModifyBy(userInfo.getId());

		return iKPRDashboardService.editDashboardDetailCopy(paramDto);
	}
}
