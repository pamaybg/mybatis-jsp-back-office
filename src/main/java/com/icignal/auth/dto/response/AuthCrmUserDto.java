/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AuthCrmUserDto.java
 * 2. Package	: com.icignal.auth.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 11. 13. 오전 10:54:30
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 11. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: AuthCrmUserDto
 * 2. 파일명	: AuthCrmUserDto.java
 * 3. 패키지명	: com.icignal.auth.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 11. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class AuthCrmUserDto extends StatusResDto{
	private String ip;
	private String ipDate;
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getIpDate() {
		return ipDate;
	}
	public void setIpDate(String ipDate) {
		this.ipDate = ipDate;
	}
	
	
}
