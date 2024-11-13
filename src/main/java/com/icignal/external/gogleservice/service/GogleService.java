/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: GogleService.java
 * 2. Package	: com.icignal.external.gogleservice.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 3. 오전 10:54:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 3.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.gogleservice.service;


import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Service;

import com.icignal.common.util.BeansUtil;
import com.icignal.external.gogleservice.dto.response.GogleLoginResDto;

/*
 * 1. 클래스명	: GogleService
 * 2. 파일명	: GogleService.java
 * 3. 패키지명	: com.icignal.external.gogleservice.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class GogleService {


	 /*
	  * 1. 메소드명: getAuthorizationUrl
	  * 2. 클래스명: GogleService
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
	 *   @param userId
	 *   @return	
	 */
	public GogleLoginResDto getAuthorizationUrl(String userId) {
		String clientId = BeansUtil.getApplicationProperty("google.login.client-id");
		String clientSecret = BeansUtil.getApplicationProperty("google.login.client-secret");
		String redirectUrl;
		
		if(userId != null)
			redirectUrl = BeansUtil.getApplicationProperty("google.login.redirect-uri");
		else 
			redirectUrl = BeansUtil.getApplicationProperty("google.login.login-redirect-uri");
		
		GogleLoginResDto gogleResDto = new GogleLoginResDto();
		GoogleConnectionFactory gogleFactory = new GoogleConnectionFactory(clientId,clientSecret);
		OAuth2Parameters parameters = new OAuth2Parameters();
		parameters.setRedirectUri(redirectUrl);
		parameters.setScope("https://www.googleapis.com/auth/plus.login");
		OAuth2Operations oauthOperations = gogleFactory.getOAuthOperations();
		String gogle_url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, parameters);
		
		gogleResDto.setGogleAuthUrl(gogle_url);
		gogleResDto.setSuccess(true);
		
		return gogleResDto;
	}
	
	 /*
	  * 1. 메소드명: getAccessToken
	  * 2. 클래스명: GogleService
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
	 *   @param userId
	 *   @return	
	 */
	public String getAccessToken(String code,String userId) {
		String clientId = BeansUtil.getApplicationProperty("google.login.client-id");
		String clientSecret = BeansUtil.getApplicationProperty("google.login.client-secret");
		String redirectUrl;
		
		if(userId != null)
			redirectUrl = BeansUtil.getApplicationProperty("google.login.redirect-uri");
		else 
			redirectUrl = BeansUtil.getApplicationProperty("google.login.login-redirect-uri");
		
		GoogleConnectionFactory gogleFactory = new GoogleConnectionFactory(clientId,clientSecret);
		OAuth2Operations oauthOperations = gogleFactory.getOAuthOperations();
        AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, redirectUrl, null);
/*        Google api = ((GoogleServiceProvider) getServiceProvider ()). getApi (accessGrant.getAccessToken ());
        UserProfile userProfile = getApiAdapter (). fetchUserProfile (api);*/
        Connection<Google> connection = gogleFactory.createConnection(accessGrant);
		Google google = connection == null ? new GoogleTemplate(accessGrant.getAccessToken()) : connection.getApi();
		PlusOperations plusOperations = google.plusOperations();
		Person person = plusOperations.getGoogleProfile();
        return accessGrant.getAccessToken();
	}
		
	
}
