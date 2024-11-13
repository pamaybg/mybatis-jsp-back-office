package com.icignal.systemmanagement.banner.controller;

import java.util.Arrays;

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

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.banner.dto.request.SystemBannerInsertReqDto;
import com.icignal.systemmanagement.banner.dto.request.SystemBannerReqDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerDetailResDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerListResDto;
import com.icignal.systemmanagement.banner.service.SystemBannerService;

/*
 * 1. 클래스명	: SystemBannerController
 * 2. 파일명	: SystemBannerController.java
 * 3. 패키지명	: com.icignal.systemmanagement.banner.controller
 * 4. 작성자명	: mjpyo
 * 5. 작성일자	: 2017. 03. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 -  배너 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/banner")
public class SystemBannerController extends BaseController{
	
	@Autowired
	private SystemBannerService systemBannerService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".modal-tiles";
		return authHelper.checkUserInfoInclude(request, response, respUrl);
	}

	 /*
	  * 1. 메소드명: getBannerList
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 017. 03. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getBannerList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemBannerListResDto> getBannerList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemBannerService.getBannerList(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertBanner
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 신규등록 & 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/insertBanner.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertBanner(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		HttpSession session = request.getSession(true);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemBannerService.insertBanner(reqDTO, session);
	}

	 /*
	  * 1. 메소드명: getBannerDetail
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getBannerDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemBannerDetailResDto getBannerDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemBannerService.getBannerDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: increaseBannerCount
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 조회수 증가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/increaseBannerCount.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto increaseBannerCount(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemBannerService.increaseBannerCount(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertBannerMaster
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 04. 05.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 조회수 증가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/insertBannerMaster.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertBannerMaster(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemBannerService.insertBannerMaster(reqDTO);
	}

	 /*
	  * 1. 메소드명: getBannerMasterDetail
	  * 2. 클래스명: SystemBannerController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 마스터 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getBannerMasterDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemBannerDetailResDto getBannerMasterDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBannerReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemBannerService.getBannerMasterDetail(reqDTO);
	}


}
