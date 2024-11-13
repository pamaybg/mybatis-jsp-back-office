package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportStoreResponseDTO
 * 2. 파일명	: KPRReportStoreResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportStoreResDto extends GridPagingItemResDto{

	private String storeCd;
	private String storeNm;
	public String getStoreCd() {
		return storeCd;
	}
	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	public String getStoreNm() {
		return storeNm;
	}
	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}
	
	
	
}
