/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: NaverServiceController.java
 * 2. Package	: com.icignal.external.naverservice.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 1. 오후 6:04:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 1.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.naverservice.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.external.kakaoservice.dto.request.KakaoLoginReqDto;
import com.icignal.external.kakaoservice.dto.response.KakaoLoginResDto2;
import com.icignal.external.naverservice.dto.response.NaverLoginInfoResDto;
import com.icignal.external.naverservice.service.NaverService;
import com.icignal.systemmanagement.auth.service.SystemAuthService;

/*
 * 1. 클래스명	: NaverServiceController
 * 2. 파일명	: NaverServiceController.java
 * 3. 패키지명	: com.icignal.external.naverservice.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/callback")
public class NaverServiceController extends BaseController{
	
	@Autowired NaverService naverService;
	
	@Autowired SystemAuthService systemAuthService;
	
	@Autowired AuthHelper authHelper;
	
	@RequestMapping(value = "/naverAuthCallback", method = RequestMethod.GET)
	public String naverAuthCallback(HttpServletRequest request, HttpServletResponse response,Model model) throws NoSuchMethodException, SecurityException {
		// LogUtil.debug(this.getClass().getName() + " NavigateMenu Method start...");
		
		 return "loyalty/callback/naverAuthCallback";
	
	}
	
	@RequestMapping(value = "/naverLoginCallback", method = RequestMethod.GET)
	public String naverLoginCallback(HttpServletRequest request, HttpServletResponse response,Model model) throws NoSuchMethodException, SecurityException {
		// LogUtil.debug(this.getClass().getName() + " NavigateMenu Method start...");
		
		 return "loyalty/callback/naverLoginCallback";
	
	}
		
	 /*
	  * 1. 메소드명: naverCallback
	  * 2. 클래스명: NaverServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 인증키등록 팝업에서 인증키등록을 누르고 
	 * 로그인 및 동의하기 버튼을 눌렀을때 AccessKey및 사용자정보를 받기위한 URL 요청
	 * (네이버 개발자 어플리케이션에 등록된 Redirect URL)	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param code
	 *   @param state
	 *   @param session
	 *   @param request
	 *   @param response
	 * @throws IOException 
	 */
	@RequestMapping(value="/naverCallback.do", method = RequestMethod.GET)
	public void naverCallback(@RequestParam(value="code", required=false) String code, @RequestParam String state, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) {
		LogUtil.param(this.getClass(), code);
		
		try {
		//정보제공동의 취소버튼 체크
		if(code==null) {
			JavaScriptStringUtil.homeLocation(response); 
			return;
		}
		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		
			//네이버 고유 ID값 조회
			String id = naverService.getAccessToken(session, code, state, userId);
				
			StatusResDto statusRes = systemAuthService.modifyNaverToken(id,userId);
			
			if(statusRes.getSuccess()) {
				JavaScriptStringUtil.homeUrl(response,"네이버 인증키 등록이 안료되었습니다.");
			} else JavaScriptStringUtil.homeFaileUrl(response); 
		} catch (IOException e) {
        	LogUtil.error(e);
        }
	}
	
	 /*
	  * 1. 메소드명: naverLogin
	  * 2. 클래스명: NaverServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 로그인화면 로그인인증 요청		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/naverLogin.do", method = RequestMethod.POST)
	public @ResponseBody NaverLoginInfoResDto naverLogin(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		return naverService.getAuthorizationUrl(session,userId);
	}
	
	 /*
	  * 1. 메소드명: naverLoginAuth
	  * 2. 클래스명: NaverServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 로그인한 사용자 네이버 로그인 인증키 등록		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param request
	 *   @param response
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/naverLoginAuth.do", method = RequestMethod.POST)
	public @ResponseBody NaverLoginInfoResDto naverLoginAuth(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		return naverService.getAuthorizationUrl(session,userId);
	}
	
	 /*
	  * 1. 메소드명: naverLoginConfirm
	  * 2. 클래스명: NaverServiceController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 로그인화면 로그인요청후 Callback함수 처리 메소드		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param code
	 *   @param state
	 *   @param session
	 *   @param request
	 *   @param response 
	 * @throws IOException 
	 */
	@RequestMapping(value="/ConfirmNaverLogin.do", method = RequestMethod.POST)
	public @ResponseBody KakaoLoginResDto2 ConfirmNaverLogin(@RequestBody KakaoLoginReqDto reqDto, @RequestParam String state, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
			LogUtil.param(this.getClass(), reqDto);
			String url = null;
			KakaoLoginResDto2 resDto = new KakaoLoginResDto2();

	try {
			url = authHelper.snsNaverLoginConfirm(reqDto.getId(),request,response);
			if(url != null) {
			resDto.setUrl(url);
			resDto.setSuccess(true);
			} else resDto.setSuccess(false);		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		String code="";
		try {
			//네이버 로그인 사용자 고유ID값 조회 및 로그인체크
			String id = naverService.getAccessToken(session, code, state,userId);
			String url2 = authHelper.snsNaverLoginConfirm(id,request,response);

			
			//인증값에 일치하는 사용자 체크
			/*if(url == null) {
				JavaScriptStringUtil.homeFailLogin(response,"등록된 네이버 인증키가 없습니다.");
				return;
			} else JavaScriptStringUtil.homeFirstUrl(response,url);*/
			
		} catch (IOException e) {
			LogUtil.error(e);
		}
	} catch (IOException e) {
		LogUtil.error(e);
	}
			return resDto;

	}
}