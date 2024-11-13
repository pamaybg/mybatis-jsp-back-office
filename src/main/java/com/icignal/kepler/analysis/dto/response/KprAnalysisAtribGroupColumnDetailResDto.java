package com.icignal.kepler.analysis.dto.response;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;


/*
 * 1. 클래스명	: KPRAnalysisAtribGroupColumnDetailResponseDTO
 * 2. 파일명	: KPRAnalysisAtribGroupColumnDetailResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisAtribGroupColumnDetailResDto extends KprAnalysisCommonResDto {
	
	private String aliasName;
	private String singleQuoteFlag;
	private String columnDataType;

	public String getAliasName() {
		return this.aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public String getSingleQuoteFlag() {
		return this.singleQuoteFlag;
	}

	public void setSingleQuoteFlag(String singleQuoteFlag) {
		this.singleQuoteFlag = singleQuoteFlag;
	}

	public String getColumnDataType() {
		return this.columnDataType;
	}

	public void setColumnDataType(String columnDataType) {
		this.columnDataType = columnDataType;
	}
}