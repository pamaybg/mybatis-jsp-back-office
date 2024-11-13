/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: FackbookService.java
 * 2. Package	: com.icignal.external.facebookservice.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 6. 오전 10:19:52
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.facebookservice.service;

import javax.servlet.http.HttpSession;

import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Service;

import com.icignal.external.facebookservice.dto.response.FacebookLoginInfoResDto;

/*
 * 1. 클래스명	: FackbookService
 * 2. 파일명	: FackbookService.java
 * 3. 패키지명	: com.icignal.external.facebookservice.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class FacebookService {
	
	private final static String CLIENT_ID = "717825050803-c1ffglfdt785brce2m6ah1uqj4ttauce.apps.googleusercontent.com";
	private final static String CLIENT_SECRET = "DEV4h1Wg3J_N5ZjRut_E_biY";
	private final static String REDIRECT_URI = "http://localhost:9090/googleCallback.do";

	public FacebookLoginInfoResDto getAuthorizationUrl(HttpSession session) {
		
		FacebookLoginInfoResDto facebookResDto = new FacebookLoginInfoResDto();
		FacebookConnectionFactory facebookFactory = new FacebookConnectionFactory(CLIENT_ID,CLIENT_SECRET);
		OAuth2Parameters parameters = new OAuth2Parameters();
		parameters.setRedirectUri(REDIRECT_URI);
		OAuth2Operations oauthOperations = facebookFactory.getOAuthOperations();
		String facebook_url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, parameters);
		
		facebookResDto.setFacebookAuthUrl(facebook_url);
		facebookResDto.setSuccess(true);
		
		return facebookResDto;
	}
	
	public String getAccessToken(String code) {
		FacebookConnectionFactory facebookFactory = new FacebookConnectionFactory(CLIENT_ID,CLIENT_SECRET);
		OAuth2Operations oauthOperations = facebookFactory.getOAuthOperations();
        AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, REDIRECT_URI, null);
        return accessGrant.getAccessToken();
	}
	
	
}
