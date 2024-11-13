package com.icignal.kepler.analytics.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRAnalyticsExportResponseDTO
 * 2. 파일명	: KPRAnalyticsExportResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analytics.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalyticsExportResDto extends StatusResDto {
	private String fileName;
	private String fileDataStream;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileDataStream() {
		return fileDataStream;
	}

	public void setFileDataStream(String fileDataStream) {
		this.fileDataStream = fileDataStream;
	}
}