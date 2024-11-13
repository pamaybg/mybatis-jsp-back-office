package com.icignal.kepler.analysis.dto.request;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;

/*
 * 1. 클래스명	: KPRAnalysisPromptDetailRequestDTO
 * 2. 파일명	: KPRAnalysisPromptDetailRequestDTO.java
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
public class KprAnalysisPromptDetailReqDto extends KprAnalysisCommonReqDto {
	
	private String promptId;
	private String promptValue1;
	private String promptValue2;
	private String promptValue3;

	private String promptValue1Text;
	private String promptValue2Text;
	private String promptValue3Text;

	private String promptTypeCodeGroup;
	private List<KprAnalysisPromptDetailReqDto> promptList;
	private List<String> promptIdList;

	public String getPromptId() {
		return this.promptId;
	}

	
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


	public void setPromptId(String promptId) {
		this.promptId = promptId;
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

	public String getPromptTypeCodeGroup() {
		return this.promptTypeCodeGroup;
	}

	public void setPromptTypeCodeGroup(String promptTypeCodeGroup) {
		this.promptTypeCodeGroup = promptTypeCodeGroup;
	}

	public List<KprAnalysisPromptDetailReqDto> getPromptList() {
		return this.promptList;
	}

	public void setPromptList(List<KprAnalysisPromptDetailReqDto> promptList) {
		this.promptList = promptList;
	}

	public List<String> getPromptIdList() {
		return this.promptIdList;
	}

	public void setPromptIdList(List<String> promptIdList) {
		this.promptIdList = promptIdList;
	}
}