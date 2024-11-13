/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemAppPopupController.java
 * 2. Package	: com.icignal.systemmanagement.apppopup.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 5:20:13
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.apppopup.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopNoticeListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopMasterDetailResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopNoticeListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopSubDetailResDto;
import com.icignal.systemmanagement.apppopup.service.SystemAppPopupService;

/*
 * 1. 클래스명	: SystemAppPopupController
 * 2. 파일명	: SystemAppPopupController.java
 * 3. 패키지명	: com.icignal.systemmanagement.apppopup.controller
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
@RequestMapping("/system/apppopup")
public class SystemAppPopupController extends BaseController{
	
	@Autowired
	private SystemAppPopupService systemAppPopupService;
	
	@Autowired
	private AuthHelper authHelper;
	
	/**
	 * @name : getAppPopList
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 리스트
	 */
	@RequestMapping(value = "/getAppPopList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAppPopListResDto> getAppPopList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemAppPopupService.getAppPopList(reqDTO);
	}
	
	/**
	 * @name : getNoticeSelectList
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 공지사항 리스트
	 */
	@RequestMapping(value = "/getNoticeSelectList.do", method = RequestMethod.POST)
	public @ResponseBody List<SystemAppPopNoticeListResDto> getNoticeSelectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopNoticeListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemAppPopupService.getNoticeSelectList(reqDTO);
	}
	
	
	/**
	 * @name : insertAppPopMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 마스터 등록 / 수정
	 */
	@RequestMapping(value = "/insertAppPopMaster.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertAppPopMaster(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopMasterInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemAppPopupService.insertAppPopMaster(reqDTO);
	}
	
	
	/**
	 * @name : getAppPopMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 마스터 상세
	 */
	@RequestMapping(value = "/getAppPopMaster.do", method = RequestMethod.POST)
	public @ResponseBody SystemAppPopMasterDetailResDto getAppPopMaster(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopMasterDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemAppPopupService.getAppPopMaster(reqDTO);
	}
	
	
	
	
	/**
	 * @name : insertAppPopSub
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 등록 / 수정
	 */
	@RequestMapping(value = "/insertAppPopSub.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertAppPopSub(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopSubInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		HttpSession session = request.getSession(true);
		
		return systemAppPopupService.insertAppPopSub(reqDTO, session);
	}
	
	
	
	/**
	 * @name : getAppPopSubDetail
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop Sub 상세
	 */
	@RequestMapping(value = "/getAppPopSubDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemAppPopSubDetailResDto getAppPopSubDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAppPopSubDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		HttpSession session = request.getSession(true);
		
		return systemAppPopupService.getAppPopSubDetail(reqDTO, session);
	}
}
