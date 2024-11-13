package com.icignal.kepler.common.dto.request;

import javax.validation.constraints.NotNull;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: KPRCommonCondListRequestDTO
 * 2. 파일명	: KPRCommonCondListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2015. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		공통 조건 조회
 * </PRE>
 */ 
public class KprCommonCondListReqDto extends MKTGridPagingReqDto {
	
    @NotNull
	private String screenId;
    private String accntId;
    
	public String getScreenId() {
		return screenId;
	}

	public void setScreenId(String screenId) {
		this.screenId = screenId;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
}

	
