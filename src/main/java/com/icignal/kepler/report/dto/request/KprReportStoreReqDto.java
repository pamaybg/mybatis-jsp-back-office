package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRReportStoreRequestDTO
 * 2. 파일명	: KPRReportStoreRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportStoreReqDto extends CommonDataAuthReqDto {
	private String storeCd;

	public String getStoreCd() {
		return storeCd;
	}

	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}

}
