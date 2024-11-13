package com.icignal.systemmanagement.systemmgt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtDetailReqDto;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtDetailResDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;
import com.icignal.systemmanagement.systemmgt.service.SystemMgtService;


/*
 * 1. 클래스명	: SystemMgtController
 * 2. 파일명	: SystemMgtController.java
 * 3. 패키지명	: com.icignal.systemmanagement.systemmgt.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 9. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 사이트 관리
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/systemmgt")
public class SystemMgtController extends BaseController{

	@Autowired
	private SystemMgtService systemMgtService;
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getSystemMgtList
	  * 2. 클래스명: SystemMgtController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getSystemMgtList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemMgtListResDto>  getSystemMgtList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(),param);	
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemMgtService.getSystemMgtList(param);
		
	}

	 /*
	  * 1. 메소드명: getSystemMgtDetail
	  * 2. 클래스명: SystemMgtController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getSystemMgtDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemMgtDetailResDto getSystemMgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(),param);	
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemMgtService.getSystemMgtDetail(param);
	}	
	
	 /*
	  * 1. 메소드명: removeSystemMgt
	  * 2. 클래스명: SystemMgtController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/removeSystemMgt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeSystemMgt(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(),param);	
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemMgtService.removeSystemMgt(param);
	}	
	
	 /*
	  * 1. 메소드명: saveSystemMgtDetail
	  * 2. 클래스명: SystemMgtController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/saveSystemMgtDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemMgtDetailResDto saveSystemMgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtDetailReqDto param) {
		LogUtil.param(this.getClass(),param);	
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemMgtService.saveSystemMgtDetail(param);
	}	
	
	 /*
	  * 1. 메소드명: modifySystemMgtDetail
	  * 2. 클래스명: SystemMgtController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/modifySystemMgtDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemMgtDetailResDto modifySystemMgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtDetailReqDto param) {
		LogUtil.param(this.getClass(),param);	
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemMgtService.modifySystemMgtDetail(param);
	}	
	
}

