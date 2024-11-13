package com.icignal.systemmanagement.event.controller;

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
import com.icignal.systemmanagement.event.dto.request.SystemEventAnnounceUpdateReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventInsertReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventPartiListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventSubInfoInsertReqDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventAnnounceDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventListResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventPartiListResDto;
import com.icignal.systemmanagement.event.service.SystemEventMgtService;

/*
 * 1. 클래스명	: SystemEventMgtController
 * 2. 파일명	: SystemEventMgtController.java
 * 3. 패키지명	: com.icignal.systemmanagement.event.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		Event 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/event")
public class SystemEventMgtController extends BaseController {
	
	@Autowired
	SystemEventMgtService systemEventMgtService;
	
	@Autowired
	AuthHelper authHelper;

	 /*
	  * 1. 메소드명: getEventList
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		event 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getEventList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemEventListResDto> getEventList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemEventMgtService.getEventList(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertEventInfo
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		event 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/insertEventInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertEventInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventInsertReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		HttpSession session = request.getSession(true);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.insertEventInfo(reqDTO, session);
	}

	 /*
	  * 1. 메소드명: getEventInfoDetail
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventInfo 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getEventInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemEventDetailResDto getEventInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.getEventInfoDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: getEventParti
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 이벤트참여자 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getEventParti.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemEventPartiListResDto> getEventParti(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventPartiListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.getEventParti(reqDTO);
	}

	 /*
	  * 1. 메소드명: updateWinnerFlag
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 이벤트참여자 당첨 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/updateWinnerFlag.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateWinnerFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventPartiListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.updateWinnerFlag(reqDTO);
	}

	 /*
	  * 1. 메소드명: updateAnnounce
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 이벤트 당첨자 발표
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/updateAnnounce.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateAnnounce(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventAnnounceUpdateReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.updateAnnounce(reqDTO);
	}

	 /*
	  * 1. 메소드명: getEventSubInfoDetail
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventSubInfo 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getEventSubInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemEventDetailResDto getEventSubInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.getEventSubInfoDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertEventSubInfo
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 이미지 삽입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/insertEventSubInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertEventSubInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventSubInfoInsertReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		HttpSession session = request.getSession(true);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.insertEventSubInfo(reqDTO, session);
	}

	 /*
	  * 1. 메소드명: getAnnounceDetail
	  * 2. 클래스명: SystemEventMgtController
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 04. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		당첨자 발표 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getAnnounceDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemEventAnnounceDetailResDto getAnnounceDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEventListReqDto reqDTO) {
		LogUtil.param(SystemEventMgtController.class, reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemEventMgtService.getAnnounceDetail(reqDTO);
	}


}
