package com.icignal.kepler.common.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRCommonDateFunctionResponseDTO
 * 2. 파일명	: KPRCommonDateFunctionResponseDTO.java
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
public class KprCommonDateFunctionResDto extends GridPagingItemResDto {
	
	private String markName;
	private String codeName;
	private String dateFunc;
	private String funcValue;

	public String getMarkName() {
		return markName;
	}

	public void setMarkName(String markName) {
		this.markName = markName;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getDateFunc() {
		return dateFunc;
	}

	public void setDateFunc(String dateFunc) {
		this.dateFunc = dateFunc;
	}

	public String getFuncValue() {
		return funcValue;
	}

	public void setFuncValue(String funcValue) {
		this.funcValue = funcValue;
	}
}