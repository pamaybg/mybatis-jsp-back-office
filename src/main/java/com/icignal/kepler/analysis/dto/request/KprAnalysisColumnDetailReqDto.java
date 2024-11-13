package com.icignal.kepler.analysis.dto.request;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;

/*
 * 1. 클래스명	: KPRAnalysisColumnDetailRequestDTO
 * 2. 파일명	: KPRAnalysisColumnDetailRequestDTO.java
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
public class KprAnalysisColumnDetailReqDto extends KprAnalysisCommonReqDto {
	
	private String columnDisplayName;
	private String columnTypeCode;
	private String combColumnTypeCode;
	private String likeFlag;
	private String changeColumnUseTypeCode;
	private String columnAlias;
	private String tableColumnAlias;
	private String rightGroupFuncTypeCode;
	private String rightTableColumnAlias;
	private String rightAtribGroupColumnId;
	private String operationTypeCode;
	private String calcFieldTypeCode;
	private List<KprAnalysisColumnDetailReqDto> columnList;
	private List<String> columnIdList;
	/**  **/
	private String orderAtribGroupColumnId;
	private String orderDetail;
	private String orderTypeCode;
	private Integer orderIndex;
	private String orderValue;
	private List<KprAnalysisColumnDetailReqDto> orderDetailList;
	private String negativeFlag;
	private Integer decimalPlaces;
	private String subTotalFlag;
	private String hideYn;

	public String getColumnDisplayName() {
		return this.columnDisplayName;
	}

	public void setColumnDisplayName(String columnDisplayName) {
		this.columnDisplayName = columnDisplayName;
	}

	public String getColumnTypeCode() {
		return this.columnTypeCode;
	}

	public void setColumnTypeCode(String columnTypeCode) {
		this.columnTypeCode = columnTypeCode;
	}

	public String getCombColumnTypeCode() {
		return this.combColumnTypeCode;
	}

	public void setCombColumnTypeCode(String combColumnTypeCode) {
		this.combColumnTypeCode = combColumnTypeCode;
	}

	public String getLikeFlag() {
		return this.likeFlag;
	}

	public void setLikeFlag(String likeFlag) {
		this.likeFlag = likeFlag;
	}

	public String getChangeColumnUseTypeCode() {
		return this.changeColumnUseTypeCode;
	}

	public void setChangeColumnUseTypeCode(String changeColumnUseTypeCode) {
		this.changeColumnUseTypeCode = changeColumnUseTypeCode;
	}

	public String getColumnAlias() {
		return this.columnAlias;
	}

	public void setColumnAlias(String columnAlias) {
		this.columnAlias = columnAlias;
	}

	public String getTableColumnAlias() {
		return this.tableColumnAlias;
	}

	public void setTableColumnAlias(String tableColumnAlias) {
		this.tableColumnAlias = tableColumnAlias;
	}

	public String getRightGroupFuncTypeCode() {
		return this.rightGroupFuncTypeCode;
	}

	public void setRightGroupFuncTypeCode(String rightGroupFuncTypeCode) {
		this.rightGroupFuncTypeCode = rightGroupFuncTypeCode;
	}

	public String getRightTableColumnAlias() {
		return this.rightTableColumnAlias;
	}

	public void setRightTableColumnAlias(String rightTableColumnAlias) {
		this.rightTableColumnAlias = rightTableColumnAlias;
	}

	public String getRightAtribGroupColumnId() {
		return this.rightAtribGroupColumnId;
	}

	public void setRightAtribGroupColumnId(String rightAtribGroupColumnId) {
		this.rightAtribGroupColumnId = rightAtribGroupColumnId;
	}

	public String getOperationTypeCode() {
		return this.operationTypeCode;
	}

	public void setOperationTypeCode(String operationTypeCode) {
		this.operationTypeCode = operationTypeCode;
	}

	public String getCalcFieldTypeCode() {
		return this.calcFieldTypeCode;
	}

	public void setCalcFieldTypeCode(String calcFieldTypeCode) {
		this.calcFieldTypeCode = calcFieldTypeCode;
	}

	public List<KprAnalysisColumnDetailReqDto> getColumnList() {
		return this.columnList;
	}

	public void setColumnList(List<KprAnalysisColumnDetailReqDto> columnList) {
		this.columnList = columnList;
	}

	public List<String> getColumnIdList() {
		return this.columnIdList;
	}

	public void setColumnIdList(List<String> columnIdList) {
		this.columnIdList = columnIdList;
	}

	public String getOrderAtribGroupColumnId() {
		return orderAtribGroupColumnId;
	}

	public void setOrderAtribGroupColumnId(String orderAtribGroupColumnId) {
		this.orderAtribGroupColumnId = orderAtribGroupColumnId;
	}

	public String getOrderDetail() {
		return orderDetail;
	}

	public void setOrderDetail(String orderDetail) {
		this.orderDetail = orderDetail;
	}

	public String getOrderTypeCode() {
		return orderTypeCode;
	}

	public void setOrderTypeCode(String orderTypeCode) {
		this.orderTypeCode = orderTypeCode;
	}

	public Integer getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(Integer orderIndex) {
		this.orderIndex = orderIndex;
	}

	public String getOrderValue() {
		return orderValue;
	}

	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}

	public List<KprAnalysisColumnDetailReqDto> getOrderDetailList() {
		return orderDetailList;
	}

	public void setOrderDetailList(List<KprAnalysisColumnDetailReqDto> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}

	public String getNegativeFlag() {
		return negativeFlag;
	}

	public void setNegativeFlag(String negativeFlag) {
		this.negativeFlag = negativeFlag;
	}

	public Integer getDecimalPlaces() {
		return decimalPlaces;
	}

	public void setDecimalPlaces(Integer decimalPlaces) {
		this.decimalPlaces = decimalPlaces;
	}

	public String getSubTotalFlag() {
		return subTotalFlag;
	}

	public void setSubTotalFlag(String subTotalFlag) {
		this.subTotalFlag = subTotalFlag;
	}

	public String getHideYn() {
		return hideYn;
	}

	public void setHideYn(String hideYn) {
		this.hideYn = hideYn;
	}
}