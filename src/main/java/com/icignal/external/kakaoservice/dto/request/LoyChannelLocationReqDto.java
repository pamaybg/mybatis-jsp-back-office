/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChannelLocationReqDto.java
 * 2. Package	: com.icignal.external.kakaoservice.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 5. 27. 오전 9:16:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 5. 27.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.kakaoservice.dto.request;

/*
 * 1. 클래스명	: LoyChannelLocationReqDto
 * 2. 파일명	: LoyChannelLocationReqDto.java
 * 3. 패키지명	: com.icignal.external.kakaoservice.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 5. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class LoyChannelLocationReqDto {
	private String latitude;
	private String longitude;
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	
}
