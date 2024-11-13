package com.icignal.kepler.analysis.dto.response;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;

/*
 * 1. 클래스명	: KPRAnalysisExternalResponseDTO
 * 2. 파일명	: KPRAnalysisExternalResponseDTO.java
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
public class KprAnalysisExternalResDto extends KprAnalysisCommonResDto {
	
	private List<KprCommonCodeResDto> langTypeCodeList;
	private List<KprCommonCodeResDto> analysisEmbedTypeCodeList;

	public List<KprCommonCodeResDto> getLangTypeCodeList() {
		return this.langTypeCodeList;
	}

	public void setLangTypeCodeList(List<KprCommonCodeResDto> langTypeCodeList) {
		this.langTypeCodeList = langTypeCodeList;
	}

	public List<KprCommonCodeResDto> getAnalysisEmbedTypeCodeList() {
		return this.analysisEmbedTypeCodeList;
	}

	public void setAnalysisEmbedTypeCodeList(List<KprCommonCodeResDto> analysisEmbedTypeCodeList) {
		this.analysisEmbedTypeCodeList = analysisEmbedTypeCodeList;
	}
}