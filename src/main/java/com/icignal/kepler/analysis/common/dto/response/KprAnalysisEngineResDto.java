package com.icignal.kepler.analysis.common.dto.response;

import java.util.HashMap;
import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;

/*
 * 1. 클래스명	: KPRAnalysisEngineResponseDTO
 * 2. 파일명	: KPRAnalysisEngineResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.dto.response
 * 4. 작성자명	:
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisEngineResDto extends StatusResDto {
	
	private String analysisId;
	private String analysisType;
	private String logicalComponentId;
	private String accountId;
	private Boolean generateFlag;

	private String analysisMasterFlag;
	private Boolean promptFlag;
	private Boolean fieldGroupFlag;
	private String fieldGroupColumnId;

	private String databaseTypeCode;
	private String databaseClass;
	private String databaseIp;
	private String databasePort;
	private String databaseConnectId;
	private String databaseConnectPw;
	private String databaseUrl;

	private String atribGroupColumnId;
	private Integer seq;
	private String groupFuncTypeCode;
	private String operationTypeCode;
	private String columnAlias;
	private String tableColumnAlias;

	private String columnId;
	private String columnTypeCode;
	private String originColumnTypeCode;
	private String columnUseTypeCode;
	private String combColumnTypeCode;
	private String columnDisplayName;
	private String calcFieldTypeCode;
	private String rightGroupFuncTypeCode;
	private String rightAtribGroupColumnId;
	private String rightColumnAlias;
	private String rightTableColumnAlias;

	private String filterId;
	private String andOrFlag;
	private String leftBrktFlag;
	private String rightBrktFlag;
	private String filterValue;

	private String promptId;
	private String promptTypeCode;
	private String promptValue;

	private String baseSQL;
	private String logicalComponentFromSql;

	private String measureLoc;
	private Integer maxColumnDimension;
	private Integer minMeasure;

	private KprAnalysisEngineResDto lastDimension;

	private HashMap<String, Object> chartInformation;
	private HashMap<String, Object> promptDataMap;
	private HashMap<String, Object> analysisDataMap;

	private List<KprAnalysisEngineResDto> columnList;
	private List<KprAnalysisEngineResDto> dimensionColumnList;
	private List<KprAnalysisEngineResDto> dimensionRowList;
	private List<KprAnalysisEngineResDto> measureList;

	private List<HashMap<String, Object>> columnNameList;
	private List<HashMap<String, Object>> rowNameList;
	private List<HashMap<String, Object>> valueNameList;
	private List<HashMap<String, Object>> martDataList;

	/*** DrillDown Group 정보 관련 ***/
	private String anlColumnId;
	private String drillDownGroupId;
	private String drillDownGroupName;
	private String levelColumnId;
	private String upperColumnId;
	private String lowerColumnId;
	private String columnName;
	private String upperTableColumnAlias;
	private String tableAlias;
	private List<KprAnalysisEngineResDto> metaDrillDownGroupList;
	private List<KprAnalysisEngineReqDto> currentDrillDownGroupList;

	/*** 분석 정렬 관련 정보 ***/
	private String orderAtribGroupColumnId;
	private String orderColumnAlias;
	private String orderDetail;
	private String orderTableAliasColName;
	private String orderType;
	private String orderColumnName;

	private String originTableColumnAlias;
	private String originColumnDisplayName;
	private String schmaTableName;

	private MKTDBInfoDTO databaseInfo;

	private String strAnlWhere;

	/* 합계 관련 정보 */

	private String negativeFlag;
	private Integer decimalPlaces;
	private String subTotalFlag;

	private Boolean colTotalFlag;
	private String colTotalSQL;
	private KprAnalysisEngineResDto colTotalDimension;

	private Boolean rowTotalFlag;
	private String rowTotalSQL;
	private KprAnalysisEngineResDto rowTotalDimension;

	private String colTotalTypeCode;
	private String colTotalTypeCodeName;
	private String rowTotalTypeCode;
	private String rowTotalTypeCodeName;

	
	//aws db접속정보
	private String dbInformId; // 아이디
	private String createByName; // 생성자명
	private String createDate; // 생성일시
	private String serviceNm; // 서비스명
	private String conDbType; // DB유형
	private String conDbTypeName; // DB유형 Mart Name
	private String conIp; // 접속IP
	private String conPort; // 접속PORT
	private String conId; // 접속ID
	private String conUrl; // 접속URL
	private String conPw; // 접속pw
	private String dbDesc; // 설명
	private String conDbClass; // 설명
	private String secretNm;	//비밀명
	
	
	
	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getCreateByName() {
		return createByName;
	}

	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getServiceNm() {
		return serviceNm;
	}

	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}

	public String getConDbType() {
		return conDbType;
	}

	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
	}

	public String getConDbTypeName() {
		return conDbTypeName;
	}

	public void setConDbTypeName(String conDbTypeName) {
		this.conDbTypeName = conDbTypeName;
	}

	public String getConIp() {
		return conIp;
	}

	public void setConIp(String conIp) {
		this.conIp = conIp;
	}

	public String getConPort() {
		return conPort;
	}

	public void setConPort(String conPort) {
		this.conPort = conPort;
	}

	public String getConId() {
		return conId;
	}

	public void setConId(String conId) {
		this.conId = conId;
	}

	public String getConUrl() {
		return conUrl;
	}

	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}

	public String getConPw() {
		return conPw;
	}

	public void setConPw(String conPw) {
		this.conPw = conPw;
	}

	public String getDbDesc() {
		return dbDesc;
	}

	public void setDbDesc(String dbDesc) {
		this.dbDesc = dbDesc;
	}

	public String getConDbClass() {
		return conDbClass;
	}

	public void setConDbClass(String conDbClass) {
		this.conDbClass = conDbClass;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

	public String getAnalysisId() {
		return analysisId;
	}

	public void setAnalysisId(String analysisId) {
		this.analysisId = analysisId;
	}

	public String getAnalysisType() {
		return analysisType;
	}

	public void setAnalysisType(String analysisType) {
		this.analysisType = analysisType;
	}

	public String getLogicalComponentId() {
		return logicalComponentId;
	}

	public void setLogicalComponentId(String logicalComponentId) {
		this.logicalComponentId = logicalComponentId;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public Boolean getGenerateFlag() {
		return generateFlag;
	}

	public void setGenerateFlag(Boolean generateFlag) {
		this.generateFlag = generateFlag;
	}

	public String getAnalysisMasterFlag() {
		return analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}

	public Boolean getPromptFlag() {
		return promptFlag;
	}

	public void setPromptFlag(Boolean promptFlag) {
		this.promptFlag = promptFlag;
	}

	public Boolean getFieldGroupFlag() {
		return fieldGroupFlag;
	}

	public void setFieldGroupFlag(Boolean fieldGroupFlag) {
		this.fieldGroupFlag = fieldGroupFlag;
	}

	public String getFieldGroupColumnId() {
		return fieldGroupColumnId;
	}

	public void setFieldGroupColumnId(String fieldGroupColumnId) {
		this.fieldGroupColumnId = fieldGroupColumnId;
	}

	public String getDatabaseTypeCode() {
		return databaseTypeCode;
	}

	public void setDatabaseTypeCode(String databaseTypeCode) {
		this.databaseTypeCode = databaseTypeCode;
	}

	public String getDatabaseClass() {
		return databaseClass;
	}

	public void setDatabaseClass(String databaseClass) {
		this.databaseClass = databaseClass;
	}

	public String getDatabaseIp() {
		return databaseIp;
	}

	public void setDatabaseIp(String databaseIp) {
		this.databaseIp = databaseIp;
	}

	public String getDatabasePort() {
		return databasePort;
	}

	public void setDatabasePort(String databasePort) {
		this.databasePort = databasePort;
	}

	public String getDatabaseConnectId() {
		return databaseConnectId;
	}

	public void setDatabaseConnectId(String databaseConnectId) {
		this.databaseConnectId = databaseConnectId;
	}

	public String getDatabaseConnectPw() {
		return databaseConnectPw;
	}

	public void setDatabaseConnectPw(String databaseConnectPw) {
		this.databaseConnectPw = databaseConnectPw;
	}

	public String getDatabaseUrl() {
		return databaseUrl;
	}

	public void setDatabaseUrl(String databaseUrl) {
		this.databaseUrl = databaseUrl;
	}

	public String getAtribGroupColumnId() {
		return atribGroupColumnId;
	}

	public void setAtribGroupColumnId(String atribGroupColumnId) {
		this.atribGroupColumnId = atribGroupColumnId;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getGroupFuncTypeCode() {
		return groupFuncTypeCode;
	}

	public void setGroupFuncTypeCode(String groupFuncTypeCode) {
		this.groupFuncTypeCode = groupFuncTypeCode;
	}

	public String getOperationTypeCode() {
		return operationTypeCode;
	}

	public void setOperationTypeCode(String operationTypeCode) {
		this.operationTypeCode = operationTypeCode;
	}

	public String getColumnAlias() {
		return columnAlias;
	}

	public void setColumnAlias(String columnAlias) {
		this.columnAlias = columnAlias;
	}

	public String getTableColumnAlias() {
		return tableColumnAlias;
	}

	public void setTableColumnAlias(String tableColumnAlias) {
		this.tableColumnAlias = tableColumnAlias;
	}

	public String getColumnId() {
		return columnId;
	}

	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}

	public String getColumnTypeCode() {
		return columnTypeCode;
	}

	public void setColumnTypeCode(String columnTypeCode) {
		this.columnTypeCode = columnTypeCode;
	}

	public String getOriginColumnTypeCode() {
		return originColumnTypeCode;
	}

	public void setOriginColumnTypeCode(String originColumnTypeCode) {
		this.originColumnTypeCode = originColumnTypeCode;
	}

	public String getColumnUseTypeCode() {
		return columnUseTypeCode;
	}

	public void setColumnUseTypeCode(String columnUseTypeCode) {
		this.columnUseTypeCode = columnUseTypeCode;
	}

	public String getCombColumnTypeCode() {
		return combColumnTypeCode;
	}

	public void setCombColumnTypeCode(String combColumnTypeCode) {
		this.combColumnTypeCode = combColumnTypeCode;
	}

	public String getColumnDisplayName() {
		return columnDisplayName;
	}

	public void setColumnDisplayName(String columnDisplayName) {
		this.columnDisplayName = columnDisplayName;
	}

	public String getCalcFieldTypeCode() {
		return calcFieldTypeCode;
	}

	public void setCalcFieldTypeCode(String calcFieldTypeCode) {
		this.calcFieldTypeCode = calcFieldTypeCode;
	}

	public String getRightGroupFuncTypeCode() {
		return rightGroupFuncTypeCode;
	}

	public void setRightGroupFuncTypeCode(String rightGroupFuncTypeCode) {
		this.rightGroupFuncTypeCode = rightGroupFuncTypeCode;
	}

	public String getRightAtribGroupColumnId() {
		return rightAtribGroupColumnId;
	}

	public void setRightAtribGroupColumnId(String rightAtribGroupColumnId) {
		this.rightAtribGroupColumnId = rightAtribGroupColumnId;
	}

	public String getRightColumnAlias() {
		return rightColumnAlias;
	}

	public void setRightColumnAlias(String rightColumnAlias) {
		this.rightColumnAlias = rightColumnAlias;
	}

	public String getRightTableColumnAlias() {
		return rightTableColumnAlias;
	}

	public void setRightTableColumnAlias(String rightTableColumnAlias) {
		this.rightTableColumnAlias = rightTableColumnAlias;
	}

	public String getFilterId() {
		return filterId;
	}

	public void setFilterId(String filterId) {
		this.filterId = filterId;
	}

	public String getAndOrFlag() {
		return andOrFlag;
	}

	public void setAndOrFlag(String andOrFlag) {
		this.andOrFlag = andOrFlag;
	}

	public String getLeftBrktFlag() {
		return leftBrktFlag;
	}

	public void setLeftBrktFlag(String leftBrktFlag) {
		this.leftBrktFlag = leftBrktFlag;
	}

	public String getRightBrktFlag() {
		return rightBrktFlag;
	}

	public void setRightBrktFlag(String rightBrktFlag) {
		this.rightBrktFlag = rightBrktFlag;
	}

	public String getFilterValue() {
		return filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public String getPromptId() {
		return promptId;
	}

	public void setPromptId(String promptId) {
		this.promptId = promptId;
	}

	public String getPromptTypeCode() {
		return promptTypeCode;
	}

	public void setPromptTypeCode(String promptTypeCode) {
		this.promptTypeCode = promptTypeCode;
	}

	public String getPromptValue() {
		return promptValue;
	}

	public void setPromptValue(String promptValue) {
		this.promptValue = promptValue;
	}

	public String getBaseSQL() {
		return baseSQL;
	}

	public void setBaseSQL(String baseSQL) {
		this.baseSQL = baseSQL;
	}

	public String getLogicalComponentFromSql() {
		return logicalComponentFromSql;
	}

	public void setLogicalComponentFromSql(String logicalComponentFromSql) {
		this.logicalComponentFromSql = logicalComponentFromSql;
	}

	public String getMeasureLoc() {
		return measureLoc;
	}

	public void setMeasureLoc(String measureLoc) {
		this.measureLoc = measureLoc;
	}

	public Integer getMaxColumnDimension() {
		return maxColumnDimension;
	}

	public void setMaxColumnDimension(Integer maxColumnDimension) {
		this.maxColumnDimension = maxColumnDimension;
	}

	public Integer getMinMeasure() {
		return minMeasure;
	}

	public void setMinMeasure(Integer minMeasure) {
		this.minMeasure = minMeasure;
	}

	public KprAnalysisEngineResDto getLastDimension() {
		return lastDimension;
	}

	public void setLastDimension(KprAnalysisEngineResDto lastDimension) {
		this.lastDimension = lastDimension;
	}

	public HashMap<String, Object> getChartInformation() {
		return chartInformation;
	}

	public void setChartInformation(HashMap<String, Object> chartInformation) {
		this.chartInformation = chartInformation;
	}

	public HashMap<String, Object> getPromptDataMap() {
		return promptDataMap;
	}

	public void setPromptDataMap(HashMap<String, Object> promptDataMap) {
		this.promptDataMap = promptDataMap;
	}

	public HashMap<String, Object> getAnalysisDataMap() {
		return analysisDataMap;
	}

	public void setAnalysisDataMap(HashMap<String, Object> analysisDataMap) {
		this.analysisDataMap = analysisDataMap;
	}

	public List<KprAnalysisEngineResDto> getColumnList() {
		return columnList;
	}

	public void setColumnList(List<KprAnalysisEngineResDto> columnList) {
		this.columnList = columnList;
	}

	public List<KprAnalysisEngineResDto> getDimensionColumnList() {
		return dimensionColumnList;
	}

	public void setDimensionColumnList(List<KprAnalysisEngineResDto> dimensionColumnList) {
		this.dimensionColumnList = dimensionColumnList;
	}

	public List<KprAnalysisEngineResDto> getDimensionRowList() {
		return dimensionRowList;
	}

	public void setDimensionRowList(List<KprAnalysisEngineResDto> dimensionRowList) {
		this.dimensionRowList = dimensionRowList;
	}

	public List<KprAnalysisEngineResDto> getMeasureList() {
		return measureList;
	}

	public void setMeasureList(List<KprAnalysisEngineResDto> measureList) {
		this.measureList = measureList;
	}

	public List<HashMap<String, Object>> getColumnNameList() {
		return columnNameList;
	}

	public void setColumnNameList(List<HashMap<String, Object>> columnNameList) {
		this.columnNameList = columnNameList;
	}

	public List<HashMap<String, Object>> getRowNameList() {
		return rowNameList;
	}

	public void setRowNameList(List<HashMap<String, Object>> rowNameList) {
		this.rowNameList = rowNameList;
	}

	public List<HashMap<String, Object>> getValueNameList() {
		return valueNameList;
	}

	public void setValueNameList(List<HashMap<String, Object>> valueNameList) {
		this.valueNameList = valueNameList;
	}

	public List<HashMap<String, Object>> getMartDataList() {
		return martDataList;
	}

	public void setMartDataList(List<HashMap<String, Object>> martDataList) {
		this.martDataList = martDataList;
	}

	public String getAnlColumnId() {
		return anlColumnId;
	}

	public void setAnlColumnId(String anlColumnId) {
		this.anlColumnId = anlColumnId;
	}

	public String getDrillDownGroupId() {
		return drillDownGroupId;
	}

	public void setDrillDownGroupId(String drillDownGroupId) {
		this.drillDownGroupId = drillDownGroupId;
	}

	public String getDrillDownGroupName() {
		return drillDownGroupName;
	}

	public void setDrillDownGroupName(String drillDownGroupName) {
		this.drillDownGroupName = drillDownGroupName;
	}

	public String getLevelColumnId() {
		return levelColumnId;
	}

	public void setLevelColumnId(String levelColumnId) {
		this.levelColumnId = levelColumnId;
	}

	public String getUpperColumnId() {
		return upperColumnId;
	}

	public void setUpperColumnId(String upperColumnId) {
		this.upperColumnId = upperColumnId;
	}

	public String getLowerColumnId() {
		return lowerColumnId;
	}

	public void setLowerColumnId(String lowerColumnId) {
		this.lowerColumnId = lowerColumnId;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getUpperTableColumnAlias() {
		return upperTableColumnAlias;
	}

	public void setUpperTableColumnAlias(String upperTableColumnAlias) {
		this.upperTableColumnAlias = upperTableColumnAlias;
	}

	public String getTableAlias() {
		return tableAlias;
	}

	public void setTableAlias(String tableAlias) {
		this.tableAlias = tableAlias;
	}

	public List<KprAnalysisEngineResDto> getMetaDrillDownGroupList() {
		return metaDrillDownGroupList;
	}

	public void setMetaDrillDownGroupList(List<KprAnalysisEngineResDto> metaDrillDownGroupList) {
		this.metaDrillDownGroupList = metaDrillDownGroupList;
	}

	public List<KprAnalysisEngineReqDto> getCurrentDrillDownGroupList() {
		return currentDrillDownGroupList;
	}

	public void setCurrentDrillDownGroupList(List<KprAnalysisEngineReqDto> currentDrillDownGroupList) {
		this.currentDrillDownGroupList = currentDrillDownGroupList;
	}

	public String getOrderAtribGroupColumnId() {
		return orderAtribGroupColumnId;
	}

	public void setOrderAtribGroupColumnId(String orderAtribGroupColumnId) {
		this.orderAtribGroupColumnId = orderAtribGroupColumnId;
	}

	public String getOrderColumnAlias() {
		return orderColumnAlias;
	}

	public void setOrderColumnAlias(String orderColumnAlias) {
		this.orderColumnAlias = orderColumnAlias;
	}

	public String getOrderDetail() {
		return orderDetail;
	}

	public void setOrderDetail(String orderDetail) {
		this.orderDetail = orderDetail;
	}

	public String getOrderTableAliasColName() {
		return orderTableAliasColName;
	}

	public void setOrderTableAliasColName(String orderTableAliasColName) {
		this.orderTableAliasColName = orderTableAliasColName;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getOrderColumnName() {
		return orderColumnName;
	}

	public void setOrderColumnName(String orderColumnName) {
		this.orderColumnName = orderColumnName;
	}

	public String getOriginTableColumnAlias() {
		return originTableColumnAlias;
	}

	public void setOriginTableColumnAlias(String originTableColumnAlias) {
		this.originTableColumnAlias = originTableColumnAlias;
	}

	public String getOriginColumnDisplayName() {
		return originColumnDisplayName;
	}

	public void setOriginColumnDisplayName(String originColumnDisplayName) {
		this.originColumnDisplayName = originColumnDisplayName;
	}

	public String getSchmaTableName() {
		return schmaTableName;
	}

	public void setSchmaTableName(String schmaTableName) {
		this.schmaTableName = schmaTableName;
	}

	public MKTDBInfoDTO getDatabaseInfo() {
		return databaseInfo;
	}

	public void setDatabaseInfo(MKTDBInfoDTO databaseInfo) {
		this.databaseInfo = databaseInfo;
	}

	public String getStrAnlWhere() {
		return strAnlWhere;
	}

	public void setStrAnlWhere(String strAnlWhere) {
		this.strAnlWhere = strAnlWhere;
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

	public Boolean getColTotalFlag() {
		return colTotalFlag;
	}

	public void setColTotalFlag(Boolean colTotalFlag) {
		this.colTotalFlag = colTotalFlag;
	}

	public String getColTotalSQL() {
		return colTotalSQL;
	}

	public void setColTotalSQL(String colTotalSQL) {
		this.colTotalSQL = colTotalSQL;
	}

	public KprAnalysisEngineResDto getColTotalDimension() {
		return colTotalDimension;
	}

	public void setColTotalDimension(KprAnalysisEngineResDto colTotalDimension) {
		this.colTotalDimension = colTotalDimension;
	}

	public Boolean getRowTotalFlag() {
		return rowTotalFlag;
	}

	public void setRowTotalFlag(Boolean rowTotalFlag) {
		this.rowTotalFlag = rowTotalFlag;
	}

	public String getRowTotalSQL() {
		return rowTotalSQL;
	}

	public void setRowTotalSQL(String rowTotalSQL) {
		this.rowTotalSQL = rowTotalSQL;
	}

	public KprAnalysisEngineResDto getRowTotalDimension() {
		return rowTotalDimension;
	}

	public void setRowTotalDimension(KprAnalysisEngineResDto rowTotalDimension) {
		this.rowTotalDimension = rowTotalDimension;
	}

	public String getColTotalTypeCode() {
		return colTotalTypeCode;
	}

	public void setColTotalTypeCode(String colTotalTypeCode) {
		this.colTotalTypeCode = colTotalTypeCode;
	}

	public String getColTotalTypeCodeName() {
		return colTotalTypeCodeName;
	}

	public void setColTotalTypeCodeName(String colTotalTypeCodeName) {
		this.colTotalTypeCodeName = colTotalTypeCodeName;
	}

	public String getRowTotalTypeCode() {
		return rowTotalTypeCode;
	}

	public void setRowTotalTypeCode(String rowTotalTypeCode) {
		this.rowTotalTypeCode = rowTotalTypeCode;
	}

	public String getRowTotalTypeCodeName() {
		return rowTotalTypeCodeName;
	}

	public void setRowTotalTypeCodeName(String rowTotalTypeCodeName) {
		this.rowTotalTypeCodeName = rowTotalTypeCodeName;
	}
}