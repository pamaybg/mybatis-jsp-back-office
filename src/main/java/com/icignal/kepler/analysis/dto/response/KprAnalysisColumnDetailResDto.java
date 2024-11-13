package com.icignal.kepler.analysis.dto.response;

import java.util.List;

import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;

/*
 * 1. 클래스명	: KPRAnalysisColumnDetailResponseDTO
 * 2. 파일명	: KPRAnalysisColumnDetailResponseDTO.java
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
public class KprAnalysisColumnDetailResDto extends KprAnalysisCommonResDto {
	
	private String empId;
	private String empName;
	private String combColumnTypeCode;
	private String columnId;
	private String columnDisplayName;
	private String columnUseTypeCode;
	private String columnAlias;
	private String tableColumnAlias;
	private String rightGroupFuncTypeCode;
	private String rightTableColumnAlias;
	private String rightAtribGroupColumnId;
	private String operationTypeCode;
	private String calcFieldTypeCode;
	private String columnDisplayRealName;

	/**
	 * 2017. 10. 25. 이기오 NHIS 프로젝트 추가
	 */
	private String orderAtribGroupColumnId;
	private String orderDisplayName;
	private String orderTableAliasColumnName;
	private String orderDetail;
	private String orderTypeCode;
	private List<String> orderDetailList;
	private String originColumnTypeCode;
	private String negativeFlag;
	private Integer decimalPlaces;
	private String subTotalFlag;

	public String getEmpId() {
		return this.empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return this.empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getCombColumnTypeCode() {
		return this.combColumnTypeCode;
	}

	public void setCombColumnTypeCode(String combColumnTypeCode) {
		this.combColumnTypeCode = combColumnTypeCode;
	}

	public String getColumnId() {
		return this.columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getColumnDisplayName() {
		return this.columnDisplayName;
	}

	public void setColumnDisplayName(String columnDisplayName) {
		this.columnDisplayName = columnDisplayName;
	}

	public String getColumnUseTypeCode() {
		return this.columnUseTypeCode;
	}

	public void setColumnUseTypeCode(String columnUseTypeCode) {
		this.columnUseTypeCode = columnUseTypeCode;
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

	public String getColumnDisplayRealName() {
		return columnDisplayRealName;
	}

	public void setColumnDisplayRealName(String columnDisplayRealName) {
		this.columnDisplayRealName = columnDisplayRealName;
	}

	public String getOrderAtribGroupColumnId() {
		return orderAtribGroupColumnId;
	}

	public void setOrderAtribGroupColumnId(String orderAtribGroupColumnId) {
		this.orderAtribGroupColumnId = orderAtribGroupColumnId;
	}

	public String getOrderDisplayName() {
		return orderDisplayName;
	}

	public void setOrderDisplayName(String orderDisplayName) {
		this.orderDisplayName = orderDisplayName;
	}

	public String getOrderTableAliasColumnName() {
		return orderTableAliasColumnName;
	}

	public void setOrderTableAliasColumnName(String orderTableAliasColumnName) {
		this.orderTableAliasColumnName = orderTableAliasColumnName;
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

	public List<String> getOrderDetailList() {
		return orderDetailList;
	}

	public void setOrderDetailList(List<String> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}

	public String getOriginColumnTypeCode() {
		return originColumnTypeCode;
	}

	public void setOriginColumnTypeCode(String originColumnTypeCode) {
		this.originColumnTypeCode = originColumnTypeCode;
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
}