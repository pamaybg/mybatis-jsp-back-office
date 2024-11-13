package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRAnalysisModifyCheckResponseDTO
 * 2. 파일명	: KPRAnalysisModifyCheckResponseDTO.java
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
public class KprAnalysisModifyCheckResDto extends StatusResDto {
	
	private Boolean createrFlag;

	public Boolean getCreaterFlag() {
		return createrFlag;
	}

	public void setCreaterFlag(Boolean createrFlag) {
		this.createrFlag = createrFlag;
	}
}