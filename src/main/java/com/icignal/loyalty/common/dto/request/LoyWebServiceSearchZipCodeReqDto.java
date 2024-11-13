package com.icignal.loyalty.common.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyWebServiceSearchZipCodeReqDto extends CommonDataAuthReqDto {
	
	private String currentPage;
	private String keyword;
	public String getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
  
	
	

	
	
	
}
