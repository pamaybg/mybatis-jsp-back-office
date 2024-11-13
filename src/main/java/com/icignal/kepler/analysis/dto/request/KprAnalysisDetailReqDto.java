package com.icignal.kepler.analysis.dto.request;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;


/*
 * 1. 클래스명	: KPRAnalysisDetailRequestDTO
 * 2. 파일명	: KPRAnalysisDetailRequestDTO.java
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
public class KprAnalysisDetailReqDto extends KprAnalysisCommonReqDto {
	
	private String analysisName;
	private String folderId;

	public String getAnalysisName() {
		return this.analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}

	public String getFolderId() {
		return this.folderId;
	}

	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}
}