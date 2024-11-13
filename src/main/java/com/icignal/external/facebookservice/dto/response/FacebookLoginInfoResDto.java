/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: FackbookResDto.java
 * 2. Package	: com.icignal.external.facebookservice.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 6. 오전 10:34:37
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.facebookservice.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: FackbookResDto
 * 2. 파일명	: FackbookResDto.java
 * 3. 패키지명	: com.icignal.external.facebookservice.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class FacebookLoginInfoResDto extends StatusResDto{
	
	private String facebookAuthUrl;

	public String getFacebookAuthUrl() {
		return facebookAuthUrl;
	}

	public void setFacebookAuthUrl(String facebookAuthUrl) {
		this.facebookAuthUrl = facebookAuthUrl;
	}
	
	
}
