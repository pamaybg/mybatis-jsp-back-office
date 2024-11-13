/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: NaverService.java
 * 2. Package	: com.icignal.external.naverservice.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 1. 오후 6:05:35
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 1.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.naverservice.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.external.naverservice.dto.response.NaverLoginInfoResDto;

/*
 * 1. 클래스명	: NaverService
 * 2. 파일명	: NaverService.java
 * 3. 패키지명	: com.icignal.external.naverservice.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class NaverService {
	
	 /*
	  * 1. 메소드명: getAuthorizationUrl
	  * 2. 클래스명: NaverService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 네이버아이디로그인 인증  URL 생성
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param userId
	 *   @return NaverLoginInfoResDto	
	 */
	public NaverLoginInfoResDto getAuthorizationUrl(HttpSession session,String userId) {
	String dataKey = BeansUtil.getDbEncryptDataKey();
		// 네이버 개발자 어플리케이션에 등록된 ClientID,CilenetSecret값 조회
		String clientId = SecurityUtil.decodeDbAES256(dataKey,BeansUtil.getApplicationProperty("naver.login.client-id",String.class,""));
		String clientSecret = BeansUtil.getApplicationProperty("naver.login.client-secret",String.class,"");
		NaverLoginInfoResDto resDto = new NaverLoginInfoResDto();
		String redirectUrl;
		
		/* 세션 유효성 검증을 위하여 난수를 생성 */
		String state = CommonUtil.newRid();
		
		/* 생성한 난수 값을 session에 저장  후에 일치하는지 비교하기 위해*/
		setSession(session,state);
		
		/* 현재 로그인전인 상태인지 로그인후 상태인지 체크
		   (인증키등록인지, SNS로그인일때 다른 Redierect URL을 타기때문)*/
		if(userId != null)
			redirectUrl = BeansUtil.getApplicationProperty("naver.login.redirect-uri",String.class,"");
		else 
			redirectUrl = BeansUtil.getApplicationProperty("naver.login.login-redirect-uri",String.class,"");
		
		/* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네이버아이디로그인 인증 URL 생성 */
		OAuth20Service oauthService = new ServiceBuilder()
				.apiKey(clientId)
				.apiSecret(clientSecret)
				.callback(redirectUrl)
				.state(state)
				.build(NaverLoginApi.instance());
		resDto.setNaverAuthUrl(oauthService.getAuthorizationUrl());
		resDto.setSuccess(true);
		
		return resDto;
	}
	
	 /*
	  * 1. 메소드명: getAccessToken
	  * 2. 클래스명: NaverService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 네이버아이디로그인 Callback 처리 및  AccessToken 획득		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param code
	 *   @param state
	 *   @param urlName
	 *   @return String
	 */
	public String getAccessToken(HttpSession session, String code, String state, String userId){
		LogUtil.param( this.getClass(), code);
		String dataKey = BeansUtil.getDbEncryptDataKey();
		// 네이버 개발자 어플리케이션에 등록된 ClientID,CilenetSecret값 조회
		String clientId = SecurityUtil.decodeDbAES256(dataKey,BeansUtil.getApplicationProperty("naver.login.client-id",String.class,""));
		String clientSecret = BeansUtil.getApplicationProperty("naver.login.client-secret",String.class,"");
		String profile_api_url = BeansUtil.getApplicationProperty("naver.login.request-user-url",String.class,"");
		String redirectUrl;
		
		String sessionState = getSession(session);
		String id="";
		
		/* 현재 로그인전인 상태인지 로그인후 상태인지 체크
		   (인증키등록인지, SNS로그인일때 다른 Redierect URL을 타기때문)*/
		if(userId != null)
			redirectUrl = BeansUtil.getApplicationProperty("naver.login.redirect-uri",String.class,"");
		else 
			redirectUrl = BeansUtil.getApplicationProperty("naver.login.login-redirect-uri",String.class,"");
		
		try{
		/* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
			if(StringUtils.equals(sessionState, state)){
				OAuth20Service oauthService = new ServiceBuilder()
						.apiKey(clientId)
						.apiSecret(clientSecret)
						.callback(redirectUrl)
						.state(state)
						.build(NaverLoginApi.instance());
					
			/* Scribe에서 제공하는 AccessToken 획득 기능으로 네이버아이디로그인 Access Token을 획득 */
				OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
				OAuthRequest request = new OAuthRequest(Verb.GET,profile_api_url, oauthService);
				oauthService.signRequest(accessToken,request);
				
				Response response = request.send();
				String apiResult = response.getBody();
				
				JSONParser parser = new JSONParser();
				//Object obj = parser.parse(apiResult);
				//JSONObject jsonObj = (JSONObject) obj;
				// 데이터 파싱
				JSONObject response_obj = (JSONObject) parser.parse(apiResult);
			
				response_obj = (JSONObject)response_obj.get("response");
				
				//response의 사용자 고유 ID값 파싱
				id = (String)response_obj.get("id");
			}
		} catch (IOException e) {
        	LogUtil.error(e);
        } catch (ParseException e) {
        	LogUtil.error(e);
        } 
			return id;
	}
	

	
	 /*
	  * 1. 메소드명: setSession
	  * 2. 클래스명: NaverService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * http session에 데이터 저장		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @param state	
	 */
	private void setSession(HttpSession session,String state){
		session.setAttribute("oauth_state", state);		
	}

	 /*
	  * 1. 메소드명: getSession
	  * 2. 클래스명: NaverService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * http session에서 데이터 가져오기		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param session
	 *   @return String	
	 */
	private String getSession(HttpSession session){
		return (String) session.getAttribute("oauth_state");
	}
	
}
