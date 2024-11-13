/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyNoticeController.java
 * 2. Package	: com.icignal.loyalty.notice.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 9. 오후 4:44:30
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 9.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.notice.controller;

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
import com.icignal.loyalty.notice.dto.request.LoyNoticeDetailReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeInsertReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeListReqDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeDetailResDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeListResDto;
import com.icignal.loyalty.notice.service.LoyNoticeService;

/*
 * 1. 클래스명	: LoyNoticeController
 * 2. 파일명	: LoyNoticeController.java
 * 3. 패키지명	: com.icignal.loyalty.notice.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/custChnl/notice")
public class LoyNoticeController extends BaseController{
	
	@Autowired
	private LoyNoticeService loyNoticeService;
	
	@Autowired
	private AuthHelper authHelper;
	
	/**
	 * @name : getNoticeList
	 * @date : 2017. 03. 20
	 * @author : mjpyo
	 * @description : 공지사항 리스트
	 */
	@RequestMapping(value = "/getNoticeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyNoticeListResDto> getNoticeList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.getNoticeList(reqDTO);
	}
	
	/**
	 * @name : insertNotice
	 * @date : 2017. 03. 20
	 * @author : mjpyo
	 * @description : 공지사항 신규등록 & 수정
	 */
	@RequestMapping(value = "/insertNotice.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertNotice(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		HttpSession session = request.getSession(true);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.insertNotice(reqDTO, session);
	}
	
	/**
	 * @name : detailNotice
	 * @date : 2017. 03. 23
	 * @author : mjpyo
	 * @description : 공지사항 상세
	 */
	@RequestMapping(value = "/getNoticeDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyNoticeDetailResDto getNoticeDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.getNoticeDetail(reqDTO);
	}
	
	
	/**
	 * @name : increaseNoticeCount
	 * @date : 2017. 03. 23
	 * @author : mjpyo
	 * @description : 공지사항 조회수 증가
	 */
	@RequestMapping(value = "/increaseNoticeCount.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto increaseNoticeCount(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.increaseNoticeCount(reqDTO);
	}
	
	
	/**
	 * @name : insertNoticeMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : 공지사항 조회수 증가
	 */
	@RequestMapping(value = "/insertNoticeMaster.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertNoticeMaster(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.insertNoticeMaster(reqDTO);
	}
	
	
	
	/**
	 * @name : getNoticeMasterDetail
	 * @date : 2017. 03. 23
	 * @author : mjpyo
	 * @description : 공지사항 마스터 상세
	 */
	@RequestMapping(value = "/getNoticeMasterDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyNoticeDetailResDto getNoticeMasterDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.getNoticeMasterDetail(reqDTO);
	}
	
	/**
	* @programId :
	* @name : removeNotice
	* @date : 2019. 7. 24.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value = "/removeNotice.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeNotice(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		HttpSession session = request.getSession(true);
		
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyNoticeService.removeNotice(reqDTO, session);
	}
}
