package com.icignal.kepler.analysis.dto.response;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;


/*
 * 1. 클래스명	: KPRAnalysisPromptDetailResponseDTO
 * 2. 파일명	: KPRAnalysisPromptDetailResponseDTO.java
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
public class KprAnalysisPromptDetailResDto extends KprAnalysisCommonResDto {
	
	private String promptId;
	private String promptValue;
	private String promptTypeCode;
	private String columnUseTypeCode;
	private String promptValue1;
	private String promptValue2;
	private String promptValue3;
	private String promptValue1Text;
	private String promptValue2Text;
	private String promptValue3Text;
	private String promptAlias;
	private Boolean promptFlag;

	
	public String getPromptValue3() {
		return promptValue3;
	}

	public void setPromptValue3(String promptValue3) {
		this.promptValue3 = promptValue3;
	}

	public String getPromptValue3Text() {
		return promptValue3Text;
	}

	public void setPromptValue3Text(String promptValue3Text) {
		this.promptValue3Text = promptValue3Text;
	}

	public String getPromptId() {
		return this.promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getPromptValue() {
		return this.promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getPromptTypeCode() {
		return this.promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getColumnUseTypeCode() {
		return this.columnUseTypeCode;
	}

	public void setColumnUseTypeCode(String columnUseTypeCode) {
		this.columnUseTypeCode = columnUseTypeCode;
	}

	public String getPromptValue1() {
		return this.promptValue1;
	}

	public void setPromptValue1(String promptValue1) {
		this.promptValue1 = promptValue1;
	}

	public String getPromptValue2() {
		return this.promptValue2;
	}

	public void setPromptValue2(String promptValue2) {
		this.promptValue2 = promptValue2;
	}

	public String getPromptValue1Text() {
		return this.promptValue1Text;
	}

	public void setPromptValue1Text(String promptValue1Text) {
		this.promptValue1Text = promptValue1Text;
	}

	public String getPromptValue2Text() {
		return this.promptValue2Text;
	}

	public void setPromptValue2Text(String promptValue2Text) {
		this.promptValue2Text = promptValue2Text;
	}

	public String getPromptAlias() {
		return this.promptAlias;
	}

	public void setPromptAlias(String promptAlias) {
		this.promptAlias = promptAlias;
	}

	public Boolean getPromptFlag() {
		return this.promptFlag;
	}

	public void setPromptFlag(Boolean promptFlag) {
		this.promptFlag = promptFlag;
	}
}