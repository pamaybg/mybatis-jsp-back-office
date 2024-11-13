package com.icignal.external.kakaoservice.dto.response;

/*
 * 1. 클래스명	: LoyChannelKaKaoApiResDto
 * 2. 파일명	: LoyChannelKaKaoApiResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *	 kakao API 
 * </PRE>
 */ 
public class LoyChannelKaKaoApiResDto {
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
