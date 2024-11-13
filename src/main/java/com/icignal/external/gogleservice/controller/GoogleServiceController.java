/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: GoogleServiceController.java
 * 2. Package	: com.icignal.external.gogleservice.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 6. 오후 5:50:32
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.gogleservice.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.external.gogleservice.dto.response.GogleLoginResDto;
import com.icignal.external.gogleservice.service.GogleService;
import com.icignal.systemmanagement.auth.service.SystemAuthService;

/*
 * 1. 클래스명	: GoogleServiceController
 * 2. 파일명	: GoogleServiceController.java
 * 3. 패키지명	: com.icignal.external.gogleservice.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
public class GoogleServiceController {
	
	@Autowired SystemAuthService systemAuthService;
	
	@Autowired GogleService gogleService;
	
	@Autowired AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: googleCallback
	  * 2. 클래스명: GoogleServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param code
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @throws IOException	
	 * @throws ParseException 
	 */
	@RequestMapping(value="/googleCallback.do", method = RequestMethod.GET)
	public void googleCallback(@RequestParam String code, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) throws IOException, ParseException {
		LogUtil.param(this.getClass(), code);
		
		StatusResDto statusRes = new StatusResDto();
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		String access_Token = gogleService.getAccessToken(code,userId);

		
		
		
		
		statusRes = systemAuthService.getCheckGoogleToken(access_Token);
		if(statusRes.getSuccess()) {
			systemAuthService.modifyGogleToken(access_Token,userId);
			JavaScriptStringUtil.homeUrl(response,"구글 인증키 등록이 완료되었습니다.");
		} else JavaScriptStringUtil.homeFaileUrl(response);
	}
	
	 /*
	  * 1. 메소드명: googleLogin
	  * 2. 클래스명: GoogleServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/googleLogin.do", method = RequestMethod.POST)
	public @ResponseBody GogleLoginResDto googleLogin(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		GogleLoginResDto resDto = new GogleLoginResDto();
		resDto.setSuccess(false);
		return resDto;
		//return gogleService.getAuthorizationUrl(userId);
	}
	
	 /*
	  * 1. 메소드명: googleLoginAuth
	  * 2. 클래스명: GoogleServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/googleLoginAuth.do", method = RequestMethod.POST)
	public @ResponseBody GogleLoginResDto googleLoginAuth(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
//		GogleLoginResDto resDto = new GogleLoginResDto();
//		resDto.setSuccess(false);
//		return resDto;
		return gogleService.getAuthorizationUrl(userId);
	}
	
	 /*
	  * 1. 메소드명: googleLoginConfirm
	  * 2. 클래스명: GoogleServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param code
	 *   @param state
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @throws IOException	
	 */
	@RequestMapping(value="/googleLoginConfirm.do", method = RequestMethod.GET)
	public void googleLoginConfirm(@RequestParam String code, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), code);
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
			
		String access_Token = gogleService.getAccessToken(code,userId);
		String url = authHelper.snsGoogleLoginConfirm(access_Token,request,response);
			
		JavaScriptStringUtil.homeFirstUrl(response,url);
	}
}
