/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: FacebookServiceController.java
 * 2. Package	: com.icignal.external.facebookservice.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 6. 오후 5:53:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.facebookservice.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.external.facebookservice.dto.response.FacebookLoginInfoResDto;
import com.icignal.external.facebookservice.service.FacebookService;
import com.icignal.systemmanagement.auth.service.SystemAuthService;

/*
 * 1. 클래스명	: FacebookServiceController
 * 2. 파일명	: FacebookServiceController.java
 * 3. 패키지명	: com.icignal.external.facebookservice.controller
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
public class FacebookServiceController {

	@Autowired SystemAuthService systemAuthService;
	
	@Autowired FacebookService facebookService;
	
	@RequestMapping(value = "/facebookLogin.do", method = RequestMethod.POST)
	public @ResponseBody FacebookLoginInfoResDto facebookLogin(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		FacebookLoginInfoResDto resDto = new FacebookLoginInfoResDto();
		resDto.setSuccess(false);
		return resDto;
		//return facebookService.getAuthorizationUrl(session);
	}
	
	@RequestMapping(value = "/facebookLoginAuth.do", method = RequestMethod.POST)
	public @ResponseBody FacebookLoginInfoResDto facebookLoginAuth(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		FacebookLoginInfoResDto resDto = new FacebookLoginInfoResDto();
		resDto.setSuccess(false);
		return resDto;
		//return facebookService.getAuthorizationUrl(session);
	}
	
	@RequestMapping(value="/facebookCallback.do", method = RequestMethod.GET)
	public void facebookCallback(@RequestParam String code, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
		LogUtil.param(this.getClass(), code);
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		String access_Token = facebookService.getAccessToken(code);
		systemAuthService.modifyFacebookToken(access_Token,userId);
		JavaScriptStringUtil.homeUrl(response,"페이스북 인증키 등록이 완료되었습니다.");
	}
}
