package com.icignal.kepler.analysis.dto.request;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;


/*
 * 1. 클래스명	: KPRAnalysisExternalRequestDTO
 * 2. 파일명	: KPRAnalysisExternalRequestDTO.java
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
public class KprAnalysisExternalReqDto extends KprAnalysisCommonReqDto {
	
	private String langTypeCode;
	private String analysisEmbedTypeCode;
	private String analysisType;

	public String getLangTypeCode() {
		return this.langTypeCode;
	}

	public void setLangTypeCode(String langTypeCode) {
		this.langTypeCode = langTypeCode;
	}

	public String getAnalysisEmbedTypeCode() {
		return this.analysisEmbedTypeCode;
	}

	public void setAnalysisEmbedTypeCode(String analysisEmbedTypeCode) {
		this.analysisEmbedTypeCode = analysisEmbedTypeCode;
	}

	public String getAnalysisType() {
		return this.analysisType;
	}

	public void setAnalysisType(String analysisType) {
		this.analysisType = analysisType;
	}
}