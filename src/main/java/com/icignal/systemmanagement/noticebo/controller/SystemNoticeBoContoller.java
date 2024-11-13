package com.icignal.systemmanagement.noticebo.controller;

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
import com.icignal.systemmanagement.menu.controller.SystemMenuController;
import com.icignal.systemmanagement.noticebo.dto.request.SystemNoticeBoListReqDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoListResDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoResDto;
import com.icignal.systemmanagement.noticebo.service.SystemNoticeBoService;

/*
 * 1. 클래스명	: SystemNoticeBoContoller
 * 2. 파일명	: SystemNoticeBoContoller.java
 * 3. 패키지명	: com.icignal.systemmanagement.noticebo.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 9. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 공지사항 (BO) Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/noticebo")
public class SystemNoticeBoContoller extends BaseController{

	@Autowired
	private SystemNoticeBoService systemNoticeBoService;
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getNoticeBoList
	  * 2. 클래스명: SystemNoticeBoContoller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getNoticeBoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemNoticeBoListResDto> getNoticeBoList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(SystemMenuController.class, reqDto);
		authHelper.checkLoginSession(request, response);
		 	
		return systemNoticeBoService.getNoticeBoList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveNoticeBo
	  * 2. 클래스명: SystemNoticeBoContoller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveNoticeBo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveNoticeBo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(SystemMenuController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemNoticeBoService.saveNoticeBo(reqDto);
	}	
	
	 /*
	  * 1. 메소드명: modifyNoticeBo
	  * 2. 클래스명: SystemNoticeBoContoller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyNoticeBo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyNoticeBo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(SystemMenuController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemNoticeBoService.modifyNoticeBo(reqDto);
	}	
	
	 /*
	  * 1. 메소드명: removeNoticeBo
	  * 2. 클래스명: SystemNoticeBoContoller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeNoticeBo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeNoticeBo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(SystemMenuController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemNoticeBoService.removeNoticeBo(reqDto);
	}	
	
	 /*
	  * 1. 메소드명: getNoticeBoDetail
	  * 2. 클래스명: SystemNoticeBoContoller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 상세 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getNoticeBoDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemNoticeBoResDto getNoticeBoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(SystemMenuController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemNoticeBoService.getNoticeBoDetail(reqDto);
	}	
	
	
	
}
