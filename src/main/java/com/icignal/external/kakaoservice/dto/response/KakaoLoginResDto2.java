/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: KakaoLoginResDto2.java
 * 2. Package	: com.icignal.external.kakaoservice.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 12. 오후 3:37:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 12.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.kakaoservice.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KakaoLoginResDto2
 * 2. 파일명	: KakaoLoginResDto2.java
 * 3. 패키지명	: com.icignal.external.kakaoservice.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class KakaoLoginResDto2 extends StatusResDto{
	private String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
