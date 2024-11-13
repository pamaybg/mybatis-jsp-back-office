package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRAnalysisColumnItemResponseDTO
 * 2. 파일명	: KPRAnalysisColumnItemResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisColumnItemResDto extends StatusResDto {
	
	private String columnId;
	private String columnDisplayName;

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getColumnDisplayName() {
		return columnDisplayName;
	}

	public void setColumnDisplayName(String columnDisplayName) {
		this.columnDisplayName = columnDisplayName;
	}
}