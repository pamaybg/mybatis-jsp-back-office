package com.icignal.kepler.analysis.dto.response;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;

/*
 * 1. 클래스명	: KPRAnalysisFilterDetailResponseDTO
 * 2. 파일명	: KPRAnalysisFilterDetailResponseDTO.java
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
public class KprAnalysisFilterDetailResDto extends KprAnalysisCommonResDto {
	
	private String filterId;
	private String andOrFlag;
	private String leftBrktFlag;
	private String rightBrktFlag;
	private String filterValue;
	private String codeValue;
	private String groupFuncDetail;
	private String filterColumnAlias;
	private String operationTypeCode;
	private List<KprAnalysisFilterDetailResDto> filterList;
	private List<KprAnalysisAtribGroupColumnDetailResDto> atribGroupColumnIdList;
	private List<KprCommonCodeResDto> operationCodeList;
	private List<KprCommonCodeResDto> groupFuncCodeList;
	private List<KprCommonCodeResDto> sercOperatorCodeList;

	public String getFilterId() {
		return this.filterId;
	}

	public void setFilterId(String filterId) {
		this.filterId = filterId;
	}

	public String getAndOrFlag() {
		return this.andOrFlag;
	}

	public void setAndOrFlag(String andOrFlag) {
		this.andOrFlag = andOrFlag;
	}

	public String getLeftBrktFlag() {
		return this.leftBrktFlag;
	}

	public void setLeftBrktFlag(String leftBrktFlag) {
		this.leftBrktFlag = leftBrktFlag;
	}

	public String getRightBrktFlag() {
		return this.rightBrktFlag;
	}

	public void setRightBrktFlag(String rightBrktFlag) {
		this.rightBrktFlag = rightBrktFlag;
	}

	public String getFilterValue() {
		return this.filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public String getCodeValue() {
		return this.codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	public String getGroupFuncDetail() {
		return this.groupFuncDetail;
	}

	public void setGroupFuncDetail(String groupFuncDetail) {
		this.groupFuncDetail = groupFuncDetail;
	}

	public String getFilterColumnAlias() {
		return this.filterColumnAlias;
	}

	public void setFilterColumnAlias(String filterColumnAlias) {
		this.filterColumnAlias = filterColumnAlias;
	}

	public String getOperationTypeCode() {
		return this.operationTypeCode;
	}

	public void setOperationTypeCode(String operationTypeCode) {
		this.operationTypeCode = operationTypeCode;
	}

	public List<KprAnalysisFilterDetailResDto> getFilterList() {
		return this.filterList;
	}

	public void setFilterList(List<KprAnalysisFilterDetailResDto> filterList) {
		this.filterList = filterList;
	}

	public List<KprAnalysisAtribGroupColumnDetailResDto> getAtribGroupColumnIdList() {
		return this.atribGroupColumnIdList;
	}

	public void setAtribGroupColumnIdList(List<KprAnalysisAtribGroupColumnDetailResDto> atribGroupColumnIdList) {
		this.atribGroupColumnIdList = atribGroupColumnIdList;
	}

	public List<KprCommonCodeResDto> getOperationCodeList() {
		return this.operationCodeList;
	}

	public void setOperationCodeList(List<KprCommonCodeResDto> operationCodeList) {
		this.operationCodeList = operationCodeList;
	}

	public List<KprCommonCodeResDto> getGroupFuncCodeList() {
		return this.groupFuncCodeList;
	}

	public void setGroupFuncCodeList(List<KprCommonCodeResDto> groupFuncCodeList) {
		this.groupFuncCodeList = groupFuncCodeList;
	}

	public List<KprCommonCodeResDto> getSercOperatorCodeList() {
		return this.sercOperatorCodeList;
	}

	public void setSercOperatorCodeList(List<KprCommonCodeResDto> sercOperatorCodeList) {
		this.sercOperatorCodeList = sercOperatorCodeList;
	}
}