package com.icignal.kepler.analysis.dto.request;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;

/*
 * 1. 클래스명	: KPRAnalysisFilterDetailRequestDTO
 * 2. 파일명	: KPRAnalysisFilterDetailRequestDTO.java
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
public class KprAnalysisFilterDetailReqDto extends KprAnalysisCommonReqDto {
	
	private String operationGroupCode;
	private String groupFuncCode;
	private String sercOperatorCode;
	private String filterId;
	private String andOrFlag;
	private String leftBrktFlag;
	private String rightBrktFlag;
	private String operationTypeCode;
	private String filterValue;
	private String andValue;
	private String codeValue;
	private String groupFuncDetail;
	private String atribGroupColumnAlias;
	private String strWhere;
	private String strGroupBy;
	private String singleQuoteFlag;
	private List<KprAnalysisFilterDetailReqDto> filterList;
	private List<String> filterIdList;

	public String getOperationGroupCode() {
		return this.operationGroupCode;
	}

	public void setOperationGroupCode(String operationGroupCode) {
		this.operationGroupCode = operationGroupCode;
	}

	public String getGroupFuncCode() {
		return this.groupFuncCode;
	}

	public void setGroupFuncCode(String groupFuncCode) {
		this.groupFuncCode = groupFuncCode;
	}

	public String getSercOperatorCode() {
		return this.sercOperatorCode;
	}

	public void setSercOperatorCode(String sercOperatorCode) {
		this.sercOperatorCode = sercOperatorCode;
	}

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

	public String getOperationTypeCode() {
		return this.operationTypeCode;
	}

	public void setOperationTypeCode(String operationTypeCode) {
		this.operationTypeCode = operationTypeCode;
	}

	public String getFilterValue() {
		return this.filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public String getAndValue() {
		return this.andValue;
	}

	public void setAndValue(String andValue) {
		this.andValue = andValue;
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

	public String getAtribGroupColumnAlias() {
		return this.atribGroupColumnAlias;
	}

	public void setAtribGroupColumnAlias(String atribGroupColumnAlias) {
		this.atribGroupColumnAlias = atribGroupColumnAlias;
	}

	public String getStrWhere() {
		return this.strWhere;
	}

	public void setStrWhere(String strWhere) {
		this.strWhere = strWhere;
	}

	public String getStrGroupBy() {
		return this.strGroupBy;
	}

	public void setStrGroupBy(String strGroupBy) {
		this.strGroupBy = strGroupBy;
	}

	public String getSingleQuoteFlag() {
		return this.singleQuoteFlag;
	}

	public void setSingleQuoteFlag(String singleQuoteFlag) {
		this.singleQuoteFlag = singleQuoteFlag;
	}

	public List<KprAnalysisFilterDetailReqDto> getFilterList() {
		return this.filterList;
	}

	public void setFilterList(List<KprAnalysisFilterDetailReqDto> filterList) {
		this.filterList = filterList;
	}

	public List<String> getFilterIdList() {
		return this.filterIdList;
	}

	public void setFilterIdList(List<String> filterIdList) {
		this.filterIdList = filterIdList;
	}
}