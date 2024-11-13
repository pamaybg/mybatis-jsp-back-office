package com.icignal.external.kakaoservice.dto.request;

/*
 * 1. 클래스명	: LoyChannelAdrSearchReqDto
 * 2. 파일명	: LoyChannelAdrSearchReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChannelAdrSearchReqDto {
	private String query; //검색어
	private int page;
	private int size;
	
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
}
