package com.icignal.systemmanagement.partner.controller;

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
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerDetailReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerInsertReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerListReqDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerDetailResDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerListResDto;
import com.icignal.systemmanagement.partner.service.SystemPartnerService;

/*
 * 1. 클래스명	: SystemPartnerController
 * 2. 파일명	: SystemPartnerController.java
 * 3. 패키지명	: com.icignal.systemmanagement.partner.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2017. 03. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 제휴 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/partner")
public class SystemPartnerController  extends BaseController{

	@Autowired
	private SystemPartnerService systemPartnerService;
	
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
	  * 1. 메소드명: getPartnerList
	  * 2. 클래스명: SystemPartnerController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 20.
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
	@RequestMapping(value = "/getPartnerList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemPartnerListResDto> getPartnerList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPartnerListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemPartnerService.getPartnerList(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertPartner
	  * 2. 클래스명: SystemPartnerController
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
	@RequestMapping(value = "/insertPartner.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertPartner(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPartnerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		HttpSession session = request.getSession(true);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemPartnerService.insertPartner(reqDTO, session);
	}

	 /*
	  * 1. 메소드명: getPartnerDetail
	  * 2. 클래스명: SystemPartnerController
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
	@RequestMapping(value = "/getPartnerDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemPartnerDetailResDto getPartnerDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPartnerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemPartnerService.getPartnerDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertPartnerMaster
	  * 2. 클래스명: SystemPartnerController
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
	@RequestMapping(value = "/insertPartnerMaster.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertPartnerMaster(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPartnerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemPartnerService.insertPartnerMaster(reqDTO);
	}
	
	

	 /*
	  * 1. 메소드명: getPartnerMasterDetail
	  * 2. 클래스명: SystemPartnerController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2017. 04. 05.
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
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getPartnerMasterDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemPartnerDetailResDto getPartnerMasterDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPartnerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemPartnerService.getPartnerMasterDetail(reqDTO);
	}
	
}
