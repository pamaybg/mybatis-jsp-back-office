package com.icignal.kepler.analysis.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/*
 * 1. 클래스명	: KPRAnalysisListByCustTypeRequestDTO
 * 2. 파일명	: KPRAnalysisListByCustTypeRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisListByCustTypeReqDto extends CommonDataAuthReqDto {
	
	private String yearMonth;
	
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	
}