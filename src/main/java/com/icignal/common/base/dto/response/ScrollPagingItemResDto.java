package com.icignal.common.base.dto.response;



/**
 * 스크롤 페이징 항목 클래스
 * 
 * @author jskim
 *
 */
public class ScrollPagingItemResDto {
	private String baseCreateDate;
	private String baseFilterValue;

	public String getBaseCreateDate() {
		return baseCreateDate;
	}

	public void setBaseCreateDate(String baseCreateDate) {
		this.baseCreateDate = baseCreateDate;
	}

	public String getBaseFilterValue() {
		return baseFilterValue;
	}

	public void setBaseFilterValue(String baseFilterValue) {
		this.baseFilterValue = baseFilterValue;
	}

}


