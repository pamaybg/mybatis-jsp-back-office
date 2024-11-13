package com.icignal.kepler.analysis.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/*
 * 1. 클래스명	: KPRAnalysisListResponseDTO
 * 2. 파일명	: KPRAnalysisListResponseDTO.java
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
public class KprAnalysisListResDto extends GridPagingItemResDto {
	
	private String analysisId;
	private String analysisName;
	private String createDate;
	private String createName;
	private String modifyDate;
	private String modifyName;
	private String typeCode;
	private String typeName;

	public String getAnalysisId() {
		return this.analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisName() {
		return this.analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}

	public String getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateName() {
		return this.createName;
	}

	public void setCreateName(String createName) {
		this.createName = createName;
	}

	public String getModifyDate() {
		return this.modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyName() {
		return this.modifyName;
	}

	public void setModifyName(String modifyName) {
		this.modifyName = modifyName;
	}

	public String getTypeCode() {
		return this.typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
}