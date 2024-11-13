/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProgramController.java
 * 2. Package	: com.icignal.loyalty.loyprogram.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 5. 오후 3:27:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 5.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.loyprogram.controller;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import com.icignal.loyalty.channel.dto.response.LoyChnlResDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubListResDto;
import com.icignal.loyalty.loyprogram.dto.request.*;
import com.icignal.loyalty.loyprogram.dto.response.*;
import com.icignal.loyalty.loyprogram.service.LoyProgramService;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/*
 * 1. 클래스명	: LoyProgramController
 * 2. 파일명	: LoyProgramController.java
 * 3. 패키지명	: com.icignal.loyalty.loyprogram.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/membership/pgm")
public class LoyProgramController extends BaseController {

	@Autowired
	private LoyProgramService LoyProgramService;

	@Autowired
	AuthHelper authHelper;

	/*
	 * 1. 메소드명: getPmgList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 목록 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getPgmList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyPgmResDto> getPmgList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmList(slr);
	}

	/*
	 * 1. 메소드명: getPgmDetail 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 상세 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getPgmDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyPgmResDto getPgmDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmDetail(slr);
	}

	/*
	 * 1. 메소드명: insertPgm 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 입력
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertPgm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.insertPgm(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updatePgm 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updatePgm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.updatePgm(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delPgm 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removePgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delPgm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.delPgm(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmJoinPlcyList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmJoinPlcyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyPgmJoinPlcyResDto> getPgmJoinPlcyList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyPgmJoinPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return LoyProgramService.getPgmJoinPlcyList(slr);
	}

	/*
	 * 1. 메소드명: getPgmJoinPlcyDetail 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 단건 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmJoinPlcyDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyPgmJoinPlcyResDto getPgmJoinPlcyDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmJoinPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmJoinPlcyDetail(slr);
	}

	/*
	 * 1. 메소드명: addPgmJoinPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 추가
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/addPgmJoinPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPgmJoinPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmJoinPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.addPgmJoinPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editPgmJoinPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/editPgmJoinPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updatePgmJoinPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmJoinPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.editPgmJoinPlcy(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: removePgmJoinPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/removePgmJoinPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removePgmJoinPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmJoinPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.removePgmJoinPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmPntPlcyDetail 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmPntPlcyDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyPgmPntPlcyResDto getPgmPntPlcyDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmPntPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmPntPlcyDetail(slr);
	}
	
	/*
	 * 1. 메소드명: addPgmPntPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 추가
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/addPgmPntPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPgmPntPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmPntPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.addPgmPntPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: updatePgmPntPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/editPgmPntPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updatePgmPntPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmPntPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.editPgmPntPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: removePgmPntPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/removePgmPntPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removePgmPntPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmPntPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.removePgmPntPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmFmlyPlcyDetail 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정책 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmFmlyPlcyDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyPgmFmlyPlcyResDto getPgmFmlyPlcyDetail(HttpServletRequest request, HttpServletResponse response,
	        @RequestBody LoyPgmFmlyPlcyReqDto slr) {

	    LogUtil.param(this.getClass(), slr);
	    slr.setLoginInfo(authHelper.checkLoginSession(request, response));

	    return LoyProgramService.getPgmFmlyPlcyDetail(slr);
	}

	/*
	 * 1. 메소드명: addPgmFmlyPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정책 추가
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/addPgmFmlyPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPgmFmlyPlcy(HttpServletRequest request, HttpServletResponse response,
	        @RequestBody LoyPgmFmlyPlcyReqDto slr) {
	    LogUtil.param(this.getClass(), slr);

	    slr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    StatusResDto rtnValue = LoyProgramService.addPgmFmlyPlcy(slr);

	    return rtnValue;
	}

	/*
	 * 1. 메소드명: editPgmFmlyPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정책 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/editPgmFmlyPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updatePgmFmlyPlcy(HttpServletRequest request, HttpServletResponse response,
	        @RequestBody LoyPgmFmlyPlcyReqDto slr) {
	    LogUtil.param(this.getClass(), slr);

	    slr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    StatusResDto rtnValue = LoyProgramService.editPgmFmlyPlcy(slr);

	    return rtnValue;
	}

	/*
	 * 1. 메소드명: removePgmFmlyPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정책 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/removePgmFmlyPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removePgmFmlyPlcy(HttpServletRequest request, HttpServletResponse response,
	        @RequestBody LoyPgmFmlyPlcyReqDto slr) {
	    LogUtil.param(this.getClass(), slr);

	    slr.setLoginInfo(authHelper.checkLoginSession(request, response));
	    StatusResDto rtnValue = LoyProgramService.removePgmFmlyPlcy(slr);

	    return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmMgtPlcyList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmMgtPlcyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyPgmMgtPlcyResDto> getPgmMgtPlcyList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyPgmMgtPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmMgtPlcyList(slr);
	}

	/*
	 * 1. 메소드명: getPgmMgtPlcyDetail 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 단건 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmMgtPlcyDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyPgmMgtPlcyResDto getPgmMgtPlcyDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmMgtPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmMgtPlcyDetail(slr);
	}

	/*
	 * 1. 메소드명: addPgmMgtPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 추가
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/addPgmMgtPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPgmMgtPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmMgtPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.addPgmMgtPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editPgmMgtPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/editPgmMgtPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updatePgmMgtPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmMgtPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.editPgmMgtPlcy(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: removePgmMgtPlcy 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/removePgmMgtPlcy.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removePgmMgtPlcy(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyPgmMgtPlcyReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyProgramService.removePgmMgtPlcy(slr);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmMgtPlcyList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 클럽 정책 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmClubPlcyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubListResDto> getPgmMgtPlcyList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyClubListReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmClubPlcyList(slr);
	}
	
	/*
	 * 1. 메소드명: getPgmChnlList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 채널 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmChnlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlResDto> getPgmChnlList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyChnlReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmChnlList(slr);
	}
	
	/*
	 * 1. 메소드명: getPgmBLPlcyList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 이상거래정책 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmBLPlcyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyPgmBLPlcyResDto> getPgmMgtPlcyList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyPgmBLPlcyReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmBLPlcyList(slr);
	}


	/*
	 * 1. 메소드명: getPgmBLPlcyList 
	 * 2. 클래스명: LoyProgramController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 8
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 변경 이력 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */	
	@RequestMapping(value = "/getPgmHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyPgmHistResDto> getPgmHistList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyPgmHistReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getPgmHistList(slr);
	}
	
	 /*
	  * 1. 메소드명: getCustItemConfList
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustItemConfList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustItemConfListResDto> getCustItemConfList (HttpServletRequest request,HttpServletResponse response, @RequestBody LoyCustItemConfReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return LoyProgramService.getCustItemConfList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustItemConfDetail
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getCustItemConfDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustItemConfResDto getCustItemConfDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyProgramService.getCustItemConfDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveCustItemConfDetail
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/saveCustItemConfDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCustItemConfDetail(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		return LoyProgramService.saveCustItemConfDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyCustItemConfDetail
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/modifyCustItemConfDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyCustItemConfDetail(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return LoyProgramService.modifyCustItemConfDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeCustItemConf
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/removeCustItemConf.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustItemConf(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return LoyProgramService.removeCustItemConf(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getItemCodeList
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		항목 필드 리스트 (공통코드)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getItemCodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MKTCommonCodeResponseDTO> getItemCodeList (HttpServletRequest request,HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return LoyProgramService.getItemCodeList(reqDto);
	}

	/*
	 * 1. 메소드명: addPgmHist
	 * 2. 클래스명: LoyProgramController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로열티 프로그램과 그 하위 엔티티 히스토리 추가
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addPgmHist.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPgmHist(HttpServletRequest request, HttpServletResponse response,
													@RequestBody List<LoyPgmHistReqDto> slr) {
		LogUtil.param(this.getClass(), slr);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return LoyProgramService.addPgmHist(slr, loginInfo);
	}
	
	@RequestMapping(value = "/checkLoyPgmCnt.do", method = RequestMethod.POST)
	public @ResponseBody int checkLoyPgmCnt(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		return LoyProgramService.checkLoyPgmCnt(slr);
	}
	
	 /*
	  * 1. 메소드명: getGroupCodeListPop
	  * 2. 클래스명: LoyProgramController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로열티 프로그램 상세 - 고객수집정보 상세 팝업 - 그룹코드 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getGroupCodeListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemCommCodeExGridResDto> getGroupCodeListPop (HttpServletRequest request,HttpServletResponse response, @RequestBody SystemCommCodeExGridReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return LoyProgramService.getGroupCodeListPop(reqDto);
	}
	
}
