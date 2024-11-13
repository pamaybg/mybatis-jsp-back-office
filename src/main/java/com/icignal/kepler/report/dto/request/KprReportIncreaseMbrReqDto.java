package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: KPRReportIncreaseMbrRequestDTO
 * 2. 파일명	: KPRReportIncreaseMbrRequestDTO.java
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
public class KprReportIncreaseMbrReqDto extends CommonDataAuthReqDto {

	private String yyyymm;

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
}
