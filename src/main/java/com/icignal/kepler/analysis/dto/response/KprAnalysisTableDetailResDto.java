package com.icignal.kepler.analysis.dto.response;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;


/*
 * 1. 클래스명	: KPRAnalysisTableDetailResponseDTO
 * 2. 파일명	: KPRAnalysisTableDetailResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.response
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 6. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisTableDetailResDto extends KprAnalysisCommonResDto {
	
	private String colTotalTypeCode;
	private String rowTotalTypeCode;

	public String getColTotalTypeCode() {
		return colTotalTypeCode;
	}

	public void setColTotalTypeCode(String colTotalTypeCode) {
		this.colTotalTypeCode = colTotalTypeCode;
	}

	public String getRowTotalTypeCode() {
		return rowTotalTypeCode;
	}

	public void setRowTotalTypeCode(String rowTotalTypeCode) {
		this.rowTotalTypeCode = rowTotalTypeCode;
	}
}