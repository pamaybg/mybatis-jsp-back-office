/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AppVersionController.java
 * 2. Package	: com.icignal.systemmanagement.appversion.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 4:29:15
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.appversion.controller;

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
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerDetailReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerInsertReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerListReqDto;
import com.icignal.systemmanagement.appversion.dto.response.SystemAppVerListResDto;
import com.icignal.systemmanagement.appversion.service.SystemAppVersionService;

/*
 * 1. 클래스명	: AppVersionController
 * 2. 파일명	: AppVersionController.java
 * 3. 패키지명	: com.icignal.systemmanagement.appversion.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/system/appversion")
public class SystemAppVersionController extends BaseController{

	@Autowired
	private SystemAppVersionService appVersionService;
	
	@Autowired
	private AuthHelper authHelper;

	/**
	 * @name : getAppVerList
	 * @date : 2017. 03. 27
	 * @author : mjpyo
	 * @description : appVer 리스트
	 */
	@RequestMapping(value = "/getAppVerList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAppVerListResDto> getAppVerList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppVerListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return appVersionService.getAppVerList(reqDTO);
	}
	
	
	/**
	 * @name : insertAppVer
	 * @date : 2017. 03. 28
	 * @author : mjpyo
	 * @description : appVer 등록
	 */
	@RequestMapping(value = "/insertAppVer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertAppVer(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppVerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return appVersionService.insertAppVer(reqDTO);
	}
	
	/**
	 * @name : getAppDetail
	 * @date : 2017. 03. 28
	 * @author : mjpyo
	 * @description : appVer 상세
	 */
	@RequestMapping(value = "/getAppDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getAppDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppVerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return appVersionService.getAppDetail(reqDTO);
	}
}
