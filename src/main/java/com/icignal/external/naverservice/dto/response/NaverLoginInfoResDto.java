/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: NaverLoginInfoResDto.java
 * 2. Package	: com.icignal.external.naverservice.dto.response
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 3. 오후 1:46:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 3.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.naverservice.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: NaverLoginInfoResDto
 * 2. 파일명	: NaverLoginInfoResDto.java
 * 3. 패키지명	: com.icignal.external.naverservice.dto.response
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class NaverLoginInfoResDto extends StatusResDto{
	private String naverAuthUrl;

	public String getNaverAuthUrl() {
		return naverAuthUrl;
	}

	public void setNaverAuthUrl(String naverAuthUrl) {
		this.naverAuthUrl = naverAuthUrl;
	}
	
	
}
