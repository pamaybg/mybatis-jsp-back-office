/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: KakaoSnsServiceController.java
 * 2. Package	: com.icignal.external.kakaoservice.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 7. 오전 10:21:35
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 7.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.kakaoservice.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.external.kakaoservice.dto.request.KakaoLoginReqDto;
import com.icignal.external.kakaoservice.dto.response.KakaoLoginResDto;
import com.icignal.external.kakaoservice.dto.response.KakaoLoginResDto2;
import com.icignal.external.kakaoservice.service.KakaoService;
import com.icignal.systemmanagement.auth.service.SystemAuthService;

/*
 * 1. 클래스명	: KakaoSnsServiceController
 * 2. 파일명	: KakaoSnsServiceController.java
 * 3. 패키지명	: com.icignal.external.kakaoservice.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
public class KakaoSnsServiceController {
	
	@Autowired KakaoService kakaoService;
	
	@Autowired SystemAuthService systemAuthService;
	
	@Autowired AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: facebookLogin
	  * 2. 클래스명: KakaoSnsServiceController
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
	 *   @return	
	 */
	@RequestMapping(value = "/kakaoLogin.do", method = RequestMethod.POST)
	public @ResponseBody KakaoLoginResDto facebookLogin(HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {	
		
			String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
			return kakaoService.getAuthorizationUrl(userId);
	}
	
	 /*
	  * 1. 메소드명: kakaoLoginAuth
	  * 2. 클래스명: KakaoSnsServiceController
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
	 *   @return	
	 */
	@RequestMapping(value = "/kakaoLoginAuth.do", method = RequestMethod.POST)
	public @ResponseBody KakaoLoginResDto kakaoLoginAuth(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) {	
    	
			String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
			return kakaoService.getAuthorizationUrl(userId);
	}
    
     /*
      * 1. 메소드명: kakaoCallback
      * 2. 클래스명: KakaoSnsServiceController
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
     */
	@RequestMapping(value="/kakaoCallback.do", method = RequestMethod.GET)
	public void kakaoCallback(@RequestParam(value="code", required=false) String code, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) {
		LogUtil.param(this.getClass(), code);
		
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		
		try {
			//카카오 로그인 사용자 고유ID값 조회
			String access_Token = kakaoService.getAccessToken(code);
			JsonNode userInfo = kakaoService.getKakaoUserInfo(access_Token);
			//카카오 고유 ID값 조회
			String id = userInfo.path("id").asText();
		
			StatusResDto statusRes = systemAuthService.modifyKaKaoToken(id,userId);
		
			if(statusRes.getSuccess()) {
				JavaScriptStringUtil.homeUrl(response,"카카오 인증키 등록이 완료되었습니다.");
			} else JavaScriptStringUtil.homeFaileUrl(response);
			
		} catch (IOException e) {
			LogUtil.error(e);
		}
		
	}
    
     /*
      * 1. 메소드명: kakaoLoginConfirm
      * 2. 클래스명: KakaoSnsServiceController
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
	@RequestMapping(value="/ConfirmKakaoLogin.do", method = RequestMethod.POST)
	public @ResponseBody KakaoLoginResDto2 ConfirmKakaoLogin(@RequestBody KakaoLoginReqDto reqDto, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response)  {
    	String url = null;
		//String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
    	KakaoLoginResDto2 resDto = new KakaoLoginResDto2();
    	LogUtil.param(this.getClass(), reqDto);
    	
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		try {
			//네이버 로그인 사용자 고유ID값 조회 및 로그인체크
			/*String access_Token = kakaoService.getAccessToken(code);
			JsonNode userInfo = kakaoService.getKakaoUserInfo(access_Token);
			String id = userInfo.path("id").asText();*/
			url = authHelper.snsKakaoLoginConfirm(reqDto.getId(),request,response);
			if(url != null) {
			resDto.setUrl(url);
			resDto.setSuccess(true);
			} else resDto.setSuccess(false);
			//인증값에 일치하는 사용자 체크
			/*if(url == null) {
				JavaScriptStringUtil.homeFailLogin(response,"등록된 카카오 인증키가 없습니다.");
			} else return url;*/
			
		} catch(IOException e) {
			LogUtil.error(e);
		}
		return resDto;
	}
	
	@RequestMapping(value = "/kakaoAlterTalk.do", method = RequestMethod.POST)
	public @ResponseBody KakaoLoginResDto kakaoAlterTalk(HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) {	
    	
			/*String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
			return kakaoService.getAuthorizationUrl(userId);*/
		kakaoService.getPushAlterTalk();
		KakaoLoginResDto resDto = new KakaoLoginResDto();
		resDto.setSuccess(true);
		return resDto;
	}
}
