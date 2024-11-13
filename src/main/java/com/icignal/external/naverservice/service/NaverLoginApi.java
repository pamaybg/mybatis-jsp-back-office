/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: NaverLoginApi.java
 * 2. Package	: com.icignal.external.naverservice.api
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 2. 오전 10:40:27
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 2.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.naverservice.service;

import com.github.scribejava.core.builder.api.DefaultApi20;

/*
 * 1. 클래스명	: NaverLoginApi
 * 2. 파일명	: NaverLoginApi.java
 * 3. 패키지명	: com.icignal.external.naverservice.api
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class NaverLoginApi extends DefaultApi20 {
	
	protected NaverLoginApi() {
		
	}
	
	private static class InstanceHolder{
		private static final NaverLoginApi INSTANCE = new NaverLoginApi();
	}
	
	public static NaverLoginApi instance() {
		return InstanceHolder.INSTANCE;
	}
	
	@Override
	public String getAccessTokenEndpoint() {
		return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	}
	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://nid.naver.com/oauth2.0/authorize";
	}
	
}
