package com.icignal.kepler.analysis.common.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisEngineResDto;
import com.icignal.kepler.analysis.common.mapper.KprAnalysisEngineMapper;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants.ANALYSIS_TYPE;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants.COL_USE_TYPE_CD;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants.TOTAL_DP_TYPE_CD;
import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisChartLabelDetailResDto;
import com.icignal.kepler.analysis.mapper.KprAnalysisChartSettingMapper;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.common.mapper.KprCommonMapper;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;

/*
 * 1. 클래스명	: KPRAnalysisEngineService
 * 2. 파일명	: KPRAnalysisEngineService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprAnalysisEngineService")
public class KprAnalysisEngineService {

	@Autowired
	private MKTCallQueryDao mktCallQuery;

	@Autowired
	private KprAnalysisChartSettingMapper kprAnalysisChartSettingMapper;

	@Autowired
	private KprCommonMapper kprCommonMapper;
	
	@Autowired
	private KprAnalysisEngineMapper kprAnalysisEngineaMapper;


	 /*
	  * 1. 메소드명: getAnalysisDataDetail
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @param analysisType
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	public KprAnalysisEngineResDto getAnalysisDataDetail(KprAnalysisEngineReqDto aer, KprAnalysisConstants.ANALYSIS_TYPE analysisType) {
		KprAnalysisEngineResDto resDto = new KprAnalysisEngineResDto();

		// 분석 기본 정보 조회
		KprAnalysisEngineResDto analysisDetail = kprAnalysisEngineaMapper.selectAnalysisDetail(aer);
		aer.setDatabaseTypeCode(analysisDetail.getDatabaseTypeCode());
		aer.setLogicalComponentId(analysisDetail.getLogicalComponentId());
		aer.setLogicalComponentFromSql(analysisDetail.getLogicalComponentFromSql());
		aer.setColTotalTypeCode(analysisDetail.getColTotalTypeCode());
		aer.setColTotalTypeCodeName(analysisDetail.getColTotalTypeCodeName());
		aer.setRowTotalTypeCode(analysisDetail.getRowTotalTypeCode());
		aer.setRowTotalTypeCodeName(analysisDetail.getRowTotalTypeCodeName());

		
		
		if(ObjectUtil.isNotEmpty(analysisDetail.getSecretNm())) {
				
		//	BeansUtil.getAWSCredentials()
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(analysisDetail.getSecretNm());					
				
			//	dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
				analysisDetail.setConUrl(map.get("url").toString());
				analysisDetail.setConId(map.get("username").toString());
				analysisDetail.setConPw(map.get("password").toString());
				analysisDetail.setConIp(map.get("ip").toString());
				analysisDetail.setConPort(map.get("port").toString());
			
		}
		
		
		
		
		// 베이스 쿼리 생성
		KprAnalysisEngineResDto baseReqDto = this.makeAnalysisBase(aer);
		boolean generateFlag = baseReqDto.getGenerateFlag();

		if (generateFlag) {
			// 분석과 연결된 테이블들이 존재하는 데이터베이스 정보 조회
			MKTDBInfoDTO databaseInfo = new MKTDBInfoDTO();
			databaseInfo.setDriverClassName(analysisDetail.getDatabaseClass());
			databaseInfo.setConIp(analysisDetail.getConIp());
			databaseInfo.setConPort(analysisDetail.getConPort());
			databaseInfo.setUserName(analysisDetail.getConId());
			//databaseInfo.setPassword(this.encrypor.decrypt(analysisDetail.getDatabaseConnectPw()));
			databaseInfo.setPassword(analysisDetail.getConPw());
			databaseInfo.setUrl(analysisDetail.getConUrl());
			databaseInfo.setConDbType(analysisDetail.getDatabaseTypeCode());
			baseReqDto.setDatabaseInfo(databaseInfo);
			baseReqDto.setDatabaseTypeCode(analysisDetail.getDatabaseTypeCode());

			String baseSQL = baseReqDto.getBaseSQL();
			List<HashMap<String, Object>> martDataList = this.mktCallQuery.callSelectForListMap("getAnalysisMartData", baseSQL, new ArrayList<HashMap<String, Object>>(), databaseInfo);

			boolean colTotalFlag = baseReqDto.getColTotalFlag();
			String colTotalSQL = baseReqDto.getColTotalSQL();
			if (colTotalFlag && KprAnalysisConstants.ANALYSIS_TYPE.TABLE.equals(analysisType)) {
				List<HashMap<String, Object>> totalDataList = this.mktCallQuery.callSelectForListMap("getAnalysisColMartTotalData", colTotalSQL, new ArrayList<HashMap<String, Object>>(), databaseInfo);
				martDataList.addAll(totalDataList);
			}

			boolean rowTotalFlag = baseReqDto.getRowTotalFlag();
			String rowTotalSQL = baseReqDto.getRowTotalSQL();
			if (rowTotalFlag && KprAnalysisConstants.ANALYSIS_TYPE.TABLE.equals(analysisType)) {
				List<HashMap<String, Object>> totalDataList = this.mktCallQuery.callSelectForListMap("getAnalysisRowMartTotalData", rowTotalSQL, new ArrayList<HashMap<String, Object>>(), databaseInfo);
				martDataList.addAll(totalDataList);
			}

			baseReqDto.setMartDataList(martDataList);
			baseReqDto.setAnalysisType(analysisType.name());
			baseReqDto.setColTotalTypeCode(analysisDetail.getColTotalTypeCode());
			baseReqDto.setColTotalTypeCodeName(analysisDetail.getColTotalTypeCodeName());
			baseReqDto.setRowTotalTypeCode(analysisDetail.getRowTotalTypeCode());
			baseReqDto.setRowTotalTypeCodeName(analysisDetail.getRowTotalTypeCodeName());
			StringBuilder leftVerticalAxisName;
			if (KprAnalysisConstants.ANALYSIS_TYPE.TABLE.equals(analysisType)) {
				// 요청된게 테이블이면 테이블 데이터 셋 생성
				resDto = getAnalysisTableDataSet(baseReqDto);
			} else {
				// 요청된게 차트면 차트 데이터 셋 생성
				resDto = getAnalysisChartDataSet(baseReqDto);

				// 차트 정보 조회
				// X축명, Y축명, etc..
				KprAnalysisEngineReqDto chartInformaionReqDto = new KprAnalysisEngineReqDto();
				chartInformaionReqDto.setAnalysisId(aer.getAnalysisId());
				chartInformaionReqDto.setAnalysisMasterFlag(aer.getAnalysisMasterFlag());
				HashMap<String, Object> chartInformationResMap = kprAnalysisEngineaMapper.selectAnalysisChartInformation(chartInformaionReqDto);
				String chartLeftVerticalName = (String) chartInformationResMap.get("chartLeftVerticalName");
				String chartRightVerticalName = (String) chartInformationResMap.get("chartRightVerticalName");

				// 컬럼 리스트 중 타입이 MEASURE인 것들만 체크해서, 좌우 Y축명을 설정함.
				List<KprAnalysisEngineResDto> columnList = resDto.getColumnList();
				leftVerticalAxisName = new StringBuilder();
				StringBuilder rightVerticalAxisName = new StringBuilder();
				if (columnList.size() > 0) {
					boolean leftVerticalAxisNameFlag = false;
					boolean rightVerticalAxisNameFlag = false;

					for (KprAnalysisEngineResDto columnDto : columnList) {
						String columnTypeCode = columnDto.getColumnTypeCode();

						if (KprAnalysisConstants.COL_TYPE_CD.MEASURE.name().equals(columnTypeCode)) {
							String combColumnTypeCode = columnDto.getCombColumnTypeCode();

							// 컴비네이션 차트 타입이 없거나, COLUMN 타입일 경우에는 좌측 Y축명 설정
							if (ObjectUtil.isEmpty(combColumnTypeCode) || KprAnalysisConstants.COMB_COL_TYPE_CODE.COLUMN.name().equals(combColumnTypeCode)) {
								if (leftVerticalAxisNameFlag)
									leftVerticalAxisName.append(", ");
								else {
									leftVerticalAxisNameFlag = true;
								}

								leftVerticalAxisName.append(columnDto.getColumnDisplayName());

								// 그 외에는 우측 Y축명 설정
							} else {
								if (rightVerticalAxisNameFlag)
									rightVerticalAxisName.append(", ");
								else {
									rightVerticalAxisNameFlag = true;
								}

								rightVerticalAxisName.append(columnDto.getColumnDisplayName());
							}
						}
					}
				}

				if (ObjectUtil.isEmpty(chartLeftVerticalName) && leftVerticalAxisName.length() > 0) {
					chartInformationResMap.put("chartLeftVerticalName", leftVerticalAxisName.toString());
				}

				if (ObjectUtil.isEmpty(chartRightVerticalName) && rightVerticalAxisName.length() > 0) {
					chartInformationResMap.put("chartRightVerticalName", rightVerticalAxisName.toString());
				}

				// Chart Label Font
				KprAnalysisChartLabelDetailReqDto charLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				charLabelDetailReqDto.setAnalysisId(aer.getAnalysisId());
				charLabelDetailReqDto.setAnalysisMasterFlag(aer.getAnalysisMasterFlag());
				charLabelDetailReqDto.setLang(aer.getLang());

				List<KprAnalysisChartLabelDetailResDto> analysisChartLabelFontDetailList = this.kprAnalysisChartSettingMapper.selectAnalysisChartLabelDetailList(charLabelDetailReqDto);
				HashMap<String, Object> analysisChartLabelFontDetailMap = new HashMap<String, Object>();
				if (ObjectUtil.isNotEmpty(analysisChartLabelFontDetailList)) {
					for (KprAnalysisChartLabelDetailResDto analysisChartLabelFontDetail : analysisChartLabelFontDetailList) {
						analysisChartLabelFontDetailMap.put(analysisChartLabelFontDetail.getChartLabelTypeCode(), analysisChartLabelFontDetail);
					}
				}

				chartInformationResMap.put("chartLabelFontInfo", analysisChartLabelFontDetailMap);
				resDto.setChartInformation(chartInformationResMap);
			}

			resDto.getAnalysisDataMap().put("valueNameList", resDto.getValueNameList());
		}

		// Drill Down Group 리스트 조회
		List<KprAnalysisEngineResDto> metaDrillDownGroupList = kprAnalysisEngineaMapper.selectAnalysisDrillDownGroupList(aer);

		resDto.setSuccess(true);
		resDto.setAnalysisId(analysisDetail.getAnalysisId());
		resDto.setFieldGroupFlag(analysisDetail.getFieldGroupFlag());
		resDto.setPromptFlag(baseReqDto.getPromptFlag());
		resDto.setMetaDrillDownGroupList(metaDrillDownGroupList);
		resDto.setCurrentDrillDownGroupList(aer.getCurrentDrillDownGroupList());
		resDto.setMeasureLoc(baseReqDto.getMeasureLoc());
		resDto.setColTotalTypeCode(analysisDetail.getColTotalTypeCode());
		resDto.setColTotalTypeCodeName(analysisDetail.getColTotalTypeCodeName());
		resDto.setRowTotalTypeCode(analysisDetail.getRowTotalTypeCode());
		resDto.setRowTotalTypeCodeName(analysisDetail.getRowTotalTypeCodeName());
		
		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: makeAnalysisBase
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	private KprAnalysisEngineResDto makeAnalysisBase(KprAnalysisEngineReqDto aer) {
		LogUtil.param(this.getClass(), aer);

		// Return Dto 설정
		KprAnalysisEngineResDto resDto = new KprAnalysisEngineResDto();
		resDto.setGenerateFlag(true);
		resDto.setAnalysisMasterFlag(aer.getAnalysisMasterFlag());

		// DB 타입에 따라 NVL 함수 설정
		String databaseTypeCode = aer.getDatabaseTypeCode();
		String nullCheckType = this.getNvlType(databaseTypeCode);

		// 베이스 쿼리 생성하기 위한 데이터 설정
		StringBuilder mainSelect = new StringBuilder("select ");
		StringBuilder mainWhere = new StringBuilder("where 1 = 1\n");
		StringBuilder mainGroupBy = new StringBuilder();

		// 베이스 쿼리 내에 ","를 추가해야되는 지에 대한 여부
		boolean mainSelectCommaFlag = false;
		boolean mainGroupByCommaFlag = false;

		String fieldGroupColumnId = aer.getFieldGroupColumnId();
		boolean fieldGroupColumFlag = ObjectUtil.isNotEmpty(fieldGroupColumnId);

		// Where 조건 LinkedMap
		LinkedHashMap<String, KprAnalysisEngineResDto> mainWhereMap = new LinkedHashMap<String, KprAnalysisEngineResDto>();

		// Dimension 및 measure List
		List<KprAnalysisEngineResDto> dimensionColumnList = new ArrayList<KprAnalysisEngineResDto>();
		List<KprAnalysisEngineResDto> dimensionRowList = new ArrayList<KprAnalysisEngineResDto>();
		List<KprAnalysisEngineResDto> measureList = new ArrayList<KprAnalysisEngineResDto>();
		// Measure 위치
		String measureLoc = null;

		// 마지막 Dimension
		KprAnalysisEngineResDto lastDimension = null;

		// Name List
		List<HashMap<String, Object>> columnNameList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> rowNameList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> valueNameList = new ArrayList<HashMap<String, Object>>();

		// Total SQL 관련 변수들
		boolean colTotalFlag = false;
		boolean rowTotalFlag = false;

		KprAnalysisEngineResDto colTotalDimension = null;
		KprAnalysisEngineResDto rowTotalDimension = null;

		StringBuilder colTotalSelect = new StringBuilder("SELECT ");
		StringBuilder colTotalGroupBy = new StringBuilder();

		StringBuilder rowTotalSelect = new StringBuilder("SELECT ");
		StringBuilder rowTotalGroupBy = new StringBuilder();

		StringBuilder mainTotalSelect = new StringBuilder("SELECT ");

		int totalAliasCnt = 1;

		// DrillDown Group 설정.
		// 베이스 쿼리 생성 시 마지막 DrillDown 값을 치환해야하므로 따로 설정
		List<KprAnalysisEngineReqDto> currentDrillDownGroupList = aer.getCurrentDrillDownGroupList();
		KprAnalysisEngineReqDto currentDrillDownGroup = null;
		if (ObjectUtil.isNotEmpty(currentDrillDownGroupList) && currentDrillDownGroupList.size() > 0) {
			currentDrillDownGroup = currentDrillDownGroupList.get(currentDrillDownGroupList.size() - 1);

			for (KprAnalysisEngineReqDto currentDrillDownGroupDto : currentDrillDownGroupList) {
				String filterValue = currentDrillDownGroupDto.getFilterValue();

				if (ObjectUtil.isNotEmpty(filterValue)) {
					KprAnalysisEngineResDto tempWhereDto = new KprAnalysisEngineResDto();
					tempWhereDto.setTableColumnAlias(currentDrillDownGroupDto.getUpperTableColumnAlias());
					tempWhereDto.setFilterValue(filterValue);

					mainWhereMap.put(currentDrillDownGroupDto.getTableColumnAlias(), tempWhereDto);
				}
			}
		}

		// anl_rpt_column / anl_rpt_column_inst 에 등록된 columnList 조회
		List<KprAnalysisEngineResDto> columnList = kprAnalysisEngineaMapper.selectAnalysisColumnList(aer);
		if (columnList.size() > 0) {
			boolean currentDrillDownGroupFlag = ObjectUtil.isNotEmpty(currentDrillDownGroup);
			boolean measureLocFlag = false;

			// Measure 및 Dimension 에 대한 기본 설정체크
			for (KprAnalysisEngineResDto columnDto : columnList) {
				String columnTypeCode = columnDto.getColumnTypeCode();
				String columnUseTypeCode = columnDto.getColumnUseTypeCode();

				if (KprAnalysisConstants.COL_TYPE_CD.DIMENSION.name().equals(columnTypeCode)) {
					// DrillDownGroup 이 설정되어 있다면, 필요한 값들을 변경
					if (currentDrillDownGroupFlag && columnDto.getColumnAlias().equals(currentDrillDownGroup.getColumnAlias())) {
						columnDto.setTableAlias(currentDrillDownGroup.getTableAlias());
						columnDto.setTableColumnAlias(currentDrillDownGroup.getTableAlias() + "." + currentDrillDownGroup.getColumnName());
						columnDto.setColumnDisplayName(currentDrillDownGroup.getColumnDisplayName());
					}

					// COLUMN 일 경우, 필드 그룹 플래그를 체크하여, 동일한 컬럼이라면 컬럼을 Dimension
					// 리스트에 추가
					if (KprAnalysisConstants.COL_USE_TYPE_CD.COLUMN.name().equals(columnUseTypeCode)) {
						if (fieldGroupColumFlag) {
							if (fieldGroupColumnId.equals(columnDto.getColumnId())) {
								dimensionColumnList.add(columnDto);
							}
						} else {
							dimensionColumnList.add(columnDto);
						}
					}
					// ROW 일 경우, 무조건 추가
					else {
						dimensionRowList.add(columnDto);
					}
				} else {
					if (!measureLocFlag) {
						measureLoc = columnUseTypeCode;
						measureLocFlag = true;
					}

					measureList.add(columnDto);
				
				}
			}

			int dimensionColumnListSize = dimensionColumnList.size();
			int measureListSize = measureList.size();
			int firstDimensionColumnSeq = Integer.MAX_VALUE;
			int lastMeasureSeq = -1;
			int lastDimensionColumnSeq = -1;

			// 마지막 Dimension 과 전체 Total 쿼리를 생성해야되는지에 대한 여부 체크
			if (measureListSize > 0) {
				lastMeasureSeq = measureList.get(measureListSize - 1).getSeq();

				if (KprAnalysisConstants.COL_USE_TYPE_CD.COLUMN.name().equals(measureLoc)) {
					if (dimensionColumnListSize > 0) {
						firstDimensionColumnSeq = dimensionColumnList.get(0).getSeq();
						lastDimensionColumnSeq = dimensionColumnList.get(dimensionColumnListSize - 1).getSeq();

						if (lastMeasureSeq > firstDimensionColumnSeq) {
							String colTotalTypeCode = aer.getColTotalTypeCode();

							if (ObjectUtil.isNotEmpty(colTotalTypeCode)) {
								colTotalFlag = true;
								colTotalDimension = dimensionColumnList.get(0);
							}
						}

						if (lastMeasureSeq < lastDimensionColumnSeq) {
							lastDimension = dimensionColumnList.get(dimensionColumnListSize - 1);
						}
					}

					if (dimensionRowList.size() > 0) {
						String rowTotalTypeCode = aer.getRowTotalTypeCode();

						if (ObjectUtil.isNotEmpty(rowTotalTypeCode)) {
							rowTotalFlag = true;
						}
					}
				}

				if (KprAnalysisConstants.COL_USE_TYPE_CD.ROW.name().equals(measureLoc)) {
					if (dimensionColumnListSize > 0) {
						String colTotalTypeCode = aer.getColTotalTypeCode();

						if (ObjectUtil.isNotEmpty(colTotalTypeCode)) {
							colTotalFlag = true;
						}

						lastDimension = dimensionColumnList.get(dimensionColumnListSize - 1);
					}

					if (dimensionRowList.size() > 0) {
						firstDimensionColumnSeq = dimensionRowList.get(0).getSeq();

						if (lastMeasureSeq > firstDimensionColumnSeq) {
							String rowTotalTypeCode = aer.getRowTotalTypeCode();

							if (ObjectUtil.isNotEmpty(rowTotalTypeCode)) {
								rowTotalFlag = true;
								rowTotalDimension = dimensionRowList.get(0);
							}
						}
					}
				}
			}

			boolean measureNameMapAddFlag = false;
			int columnIdx = 1;
			for (KprAnalysisEngineResDto columnDto : columnList) {
				String columnTypeCode = columnDto.getColumnTypeCode();
				String columnUseTypeCode = columnDto.getColumnUseTypeCode();

				// Dimension 과 Measure 분리 처리
				if (KprAnalysisConstants.COL_TYPE_CD.DIMENSION.name().equals(columnTypeCode)) {
					// DrillDownGroup 이 설정되어 있다면, 필요한 값들을 변경
					if (currentDrillDownGroupFlag && columnDto.getColumnAlias().equals(currentDrillDownGroup.getColumnAlias())) {
						columnDto.setTableAlias(currentDrillDownGroup.getTableAlias());
						columnDto.setTableColumnAlias(currentDrillDownGroup.getTableAlias() + "." + currentDrillDownGroup.getColumnName());
						columnDto.setColumnDisplayName(currentDrillDownGroup.getColumnDisplayName());
					}

					// Column 과 Row 쪽 분리 처리
					if (KprAnalysisConstants.COL_USE_TYPE_CD.COLUMN.name().equals(columnUseTypeCode)) {
						if (fieldGroupColumFlag) {
							if (columnDto.getColumnId().equals(fieldGroupColumnId)) {
								// comma 추가
								if (mainSelectCommaFlag) {
									mainSelect.append(", ");
									mainTotalSelect.append(", ");

									if (colTotalFlag) {
										colTotalSelect.append(", ");
									}

									if (rowTotalFlag) {
										rowTotalSelect.append(", ");
									}
								} else {
									mainSelectCommaFlag = true;
								}

								if (mainGroupBy.length() == 0) {
									mainGroupBy.append(" group by ");
									mainGroupByCommaFlag = false;

									if (colTotalFlag) {
										colTotalGroupBy.append(" group by ");
									}

									if (rowTotalFlag) {
										rowTotalGroupBy.append(" group by ");
									}
								}

								if (mainGroupByCommaFlag) {
									mainGroupBy.append(", ");

									if (colTotalFlag) {
										colTotalGroupBy.append(", ");
									}

									if (rowTotalFlag) {
										rowTotalGroupBy.append(", ");
									}
								} else {
									mainGroupByCommaFlag = true;
								}

								// select 및 group by 문에 컬럼 추가
								mainSelect.append(columnDto.getTableColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
								mainTotalSelect.append(columnDto.getTableColumnAlias() + " as " + columnDto.getColumnAlias() + "\n");
								mainGroupBy.append(columnDto.getTableColumnAlias() + "\n");

								if (colTotalFlag) {
									if (ObjectUtil.isNotEmpty(colTotalDimension)) {
										if (columnDto.getColumnId().equals(colTotalDimension.getColumnId())) {
											colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
											colTotalGroupBy.append(columnIdx + "\n");
										} else if (columnDto.getSeq() < lastMeasureSeq) {
											colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
											colTotalGroupBy.append(columnIdx + "\n");
										} else {
											colTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
											colTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
										}
									} else {
										colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
										colTotalGroupBy.append(columnIdx + "\n");
									}
								}

								if (rowTotalFlag) {
									rowTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
									rowTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
								}

								columnNameList.add(this.getNameMap(columnDto.getColumnDisplayName(), columnDto.getColumnAlias(), "Y".equals(columnDto.getSubTotalFlag())));
							}
						} else {
							// comma 추가
							if (mainSelectCommaFlag) {
								mainSelect.append(", ");
								mainTotalSelect.append(", ");

								if (colTotalFlag) {
									colTotalSelect.append(", ");
								}

								if (rowTotalFlag) {
									rowTotalSelect.append(", ");
								}
							} else {
								mainSelectCommaFlag = true;
							}

							if (mainGroupBy.length() == 0) {
								mainGroupBy.append(" group by ");
								mainGroupByCommaFlag = false;

								if (colTotalFlag) {
									colTotalGroupBy.append(" group by ");
								}

								if (rowTotalFlag) {
									rowTotalGroupBy.append(" group by ");
								}
							}

							if (mainGroupByCommaFlag) {
								mainGroupBy.append(", ");

								if (colTotalFlag) {
									colTotalGroupBy.append(", ");
								}

								if (rowTotalFlag) {
									rowTotalGroupBy.append(", ");
								}
							} else {
								mainGroupByCommaFlag = true;
							}

							// select 및 group by 문에 컬럼 추가
							mainSelect.append(columnDto.getTableColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
							mainTotalSelect.append(columnDto.getTableColumnAlias() + " as " + columnDto.getColumnAlias() + "\n");
							mainGroupBy.append(columnDto.getTableColumnAlias() + "\n");

							if (colTotalFlag) {
								if (ObjectUtil.isNotEmpty(colTotalDimension)) {
									if (columnDto.getColumnId().equals(colTotalDimension.getColumnId())) {
										colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
										colTotalGroupBy.append(columnIdx + "\n");
									} else if (columnDto.getSeq() < lastMeasureSeq) {
										colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
										colTotalGroupBy.append(columnIdx + "\n");
									} else {
										colTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
										colTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
									}
								} else {
									colTotalSelect.append("'" + this.getTotalDisplayName(aer.getColTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
									colTotalGroupBy.append(columnIdx + "\n");
								}
							}

							if (rowTotalFlag) {
								rowTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
								rowTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
							}

							columnNameList.add(this.getNameMap(columnDto.getColumnDisplayName(), columnDto.getColumnAlias(), "Y".equals(columnDto.getSubTotalFlag())));
						}
					} else {
						// comma 추가
						if (mainSelectCommaFlag) {
							mainSelect.append(", ");
							mainTotalSelect.append(", ");

							if (colTotalFlag) {
								colTotalSelect.append(", ");
							}

							if (rowTotalFlag) {
								rowTotalSelect.append(", ");
							}
						} else {
							mainSelectCommaFlag = true;
						}

						if (mainGroupBy.length() == 0) {
							mainGroupBy.append(" group by ");
							mainGroupByCommaFlag = false;

							if (colTotalFlag) {
								colTotalGroupBy.append(" group by ");
							}

							if (rowTotalFlag) {
								rowTotalGroupBy.append(" group by ");
							}
						}

						if (mainGroupByCommaFlag) {
							mainGroupBy.append(", ");

							if (colTotalFlag) {
								colTotalGroupBy.append(", ");
							}

							if (rowTotalFlag) {
								rowTotalGroupBy.append(", ");
							}
						} else {
							mainGroupByCommaFlag = true;
						}

						// select 및 group by 문에 컬럼 추가
						mainSelect.append(columnDto.getTableColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
						mainTotalSelect.append(columnDto.getTableColumnAlias() + " as " + columnDto.getColumnAlias() + "\n");
						mainGroupBy.append(columnDto.getTableColumnAlias() + "\n");

						if (colTotalFlag) {
							colTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
							colTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
						}

						if (rowTotalFlag) {
							if (ObjectUtil.isNotEmpty(rowTotalDimension)) {
								if (columnDto.getColumnId().equals(rowTotalDimension.getColumnId())) {
									rowTotalSelect.append("'" + this.getTotalDisplayName(aer.getRowTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
									rowTotalGroupBy.append(columnIdx + "\n");
								} else if (columnDto.getSeq() < lastMeasureSeq) {
									rowTotalSelect.append("'" + this.getTotalDisplayName(aer.getRowTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
									rowTotalGroupBy.append(columnIdx + "\n");
								} else {
									rowTotalSelect.append(columnDto.getColumnAlias() + " as \"" + columnDto.getColumnAlias() + "\"\n");
									rowTotalGroupBy.append(columnDto.getColumnAlias() + "\n");
								}
							} else {
								rowTotalSelect.append("'" + this.getTotalDisplayName(aer.getRowTotalTypeCodeName()) + "' as \"" + columnDto.getColumnAlias() + "\"\n");
								rowTotalGroupBy.append(columnIdx + "\n");
							}
						}

						rowNameList.add(this.getNameMap(columnDto.getColumnDisplayName(), columnDto.getColumnAlias(), "Y".equals(columnDto.getSubTotalFlag())));
					}
				} else {
					if (mainSelectCommaFlag) {
						mainSelect.append(", ");
						mainTotalSelect.append(", ");

						if (colTotalFlag) {
							colTotalSelect.append(", ");
						}

						if (rowTotalFlag) {
							rowTotalSelect.append(", ");
						}
					} else {
						mainSelectCommaFlag = true;
					}

					boolean negativeFlag = ObjectUtil.isNotEmpty(columnDto.getNegativeFlag()) && "Y".equals(columnDto.getNegativeFlag()) ? true : false;
					int decimalPlaces = columnDto.getDecimalPlaces();

					// 계산 필드 사용 이라면 분기 처리
					String calcFieldTypeCode = columnDto.getCalcFieldTypeCode();
					if ("Y".equals(calcFieldTypeCode)) {
						StringBuilder pureForwardMeasure = new StringBuilder();
						StringBuilder pureBackwardMeasure = new StringBuilder();
						pureForwardMeasure.append(nullCheckType + "(")
										  .append(KprAnalysisConstants.convertGroupFunction(columnDto.getGroupFuncTypeCode(), columnDto.getTableColumnAlias()) + ", 0)");

						if (negativeFlag) {
							pureForwardMeasure.append(" * -1");
						}

						pureBackwardMeasure.append(nullCheckType + "(")
										   .append(KprAnalysisConstants.convertGroupFunction(columnDto.getRightGroupFuncTypeCode(), columnDto.getRightTableColumnAlias()) + ", 0)");

						if (negativeFlag) {
							pureBackwardMeasure.append(" * -1");
						}

						StringBuilder pureMeasure = new StringBuilder();
						pureMeasure.append(pureForwardMeasure.toString())
								   .append(this.convertCalcFieldOperationCode(columnDto.getOperationTypeCode()))
								   .append(pureBackwardMeasure.toString());

						pureMeasure = this.getConvertDecimalPlaces(decimalPlaces, pureMeasure);

						mainSelect.append(pureMeasure.toString());
						mainSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");

						// mainTotalSelect.append(pureMeasure.toString());
						// mainTotalSelect.append(" as " +
						// columnDto.getColumnAlias() + "\n");

						StringBuilder pureTotalForwardMeasure = new StringBuilder();
						StringBuilder pureTotalBackwardMeasure = new StringBuilder();

						String totalTempAlias = "t" + StringUtils.leftPad(String.valueOf(totalAliasCnt++), 5, "0");

						pureTotalForwardMeasure.append(nullCheckType + "(")
											   .append(KprAnalysisConstants.convertGroupFunction(columnDto.getGroupFuncTypeCode(), columnDto.getTableColumnAlias()) + ", 0)");

						pureTotalBackwardMeasure.append(nullCheckType + "(")
												.append(KprAnalysisConstants.convertGroupFunction(columnDto.getGroupFuncTypeCode(), columnDto.getRightTableColumnAlias()) + ", 0)");

						mainTotalSelect.append(pureTotalForwardMeasure.toString())
									   .append(" as " + columnDto.getColumnAlias() + "\n");

						mainTotalSelect.append(", " + pureTotalBackwardMeasure.toString())
									   .append(" as " + totalTempAlias + "\n");

						if (colTotalFlag) {
							String colTotalTypeCode = aer.getColTotalTypeCode();
							StringBuilder colMeasure = new StringBuilder();

							colMeasure.append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(colTotalTypeCode, columnDto.getColumnAlias()) + ", 0)")
									  .append(this.convertCalcFieldOperationCode(columnDto.getOperationTypeCode()))
									  .append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(colTotalTypeCode, totalTempAlias) + ", 0)");

							if (TOTAL_DP_TYPE_CD.AVG.name().equals(colTotalTypeCode)) {
								if (decimalPlaces != 0) {
									colMeasure = this.getConvertDecimalPlaces(decimalPlaces, colMeasure);
								} else {
									colMeasure = this.getConvertDecimalPlaces(1, colMeasure);
								}
							} else {
								if (decimalPlaces != 0) {
									colMeasure = this.getConvertDecimalPlaces(decimalPlaces, colMeasure);
								} else {
									colMeasure = this.getConvertDecimalPlaces(0, colMeasure);
								}
							}

							colTotalSelect.append(colMeasure.toString());
							colTotalSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");
						}

						if (rowTotalFlag) {
							String rowTotalTypeCode = aer.getRowTotalTypeCode();
							StringBuilder rowMeasure = new StringBuilder();

							rowMeasure.append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(rowTotalTypeCode, columnDto.getColumnAlias()) + ", 0)")
									  .append(this.convertCalcFieldOperationCode(columnDto.getOperationTypeCode()))
									  .append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(rowTotalTypeCode, totalTempAlias) + ", 0)");

							if (TOTAL_DP_TYPE_CD.AVG.name().equals(rowTotalTypeCode)) {
								if (decimalPlaces != 0) {
									rowMeasure = this.getConvertDecimalPlaces(decimalPlaces, rowMeasure);
								} else {
									rowMeasure = this.getConvertDecimalPlaces(1, rowMeasure);
								}
							} else {
								if (decimalPlaces != 0) {
									rowMeasure = this.getConvertDecimalPlaces(decimalPlaces, rowMeasure);
								} else {
									rowMeasure = this.getConvertDecimalPlaces(0, rowMeasure);
								}
							}

							if (negativeFlag) {
								rowMeasure.append(" * -1");
							}

							rowTotalSelect.append(rowMeasure.toString());
							rowTotalSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");
						}
					} else {
						StringBuilder pureMeasure = new StringBuilder();
						pureMeasure.append(nullCheckType + "(")
								   .append(KprAnalysisConstants.convertGroupFunction(columnDto.getGroupFuncTypeCode(), columnDto.getTableColumnAlias()) + ", 0)");

						if (negativeFlag) {
							pureMeasure.append(" * -1");
						}

						mainTotalSelect.append(pureMeasure.toString());
						mainTotalSelect.append(" as " + columnDto.getColumnAlias() + "\n");

						pureMeasure = this.getConvertDecimalPlaces(decimalPlaces, pureMeasure);

						mainSelect.append(pureMeasure.toString());
						mainSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");

						if (colTotalFlag) {
							String colTotalTypeCode = aer.getColTotalTypeCode();
							StringBuilder colMeasure = new StringBuilder();
							colMeasure.append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(colTotalTypeCode, columnDto.getColumnAlias()) + ", 0)");

							if (TOTAL_DP_TYPE_CD.AVG.name().equals(colTotalTypeCode)) {
								if (decimalPlaces != 0) {
									colMeasure = this.getConvertDecimalPlaces(decimalPlaces, colMeasure);
								} else {
									colMeasure = this.getConvertDecimalPlaces(1, colMeasure);
								}
							} else {
								if (decimalPlaces != 0) {
									colMeasure = this.getConvertDecimalPlaces(decimalPlaces, colMeasure);
								} else {
									colMeasure = this.getConvertDecimalPlaces(0, colMeasure);
								}
							}

							colTotalSelect.append(colMeasure.toString());
							colTotalSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");
						}

						if (rowTotalFlag) {
							String rowTotalTypeCode = aer.getRowTotalTypeCode();
							StringBuilder rowMeasure = new StringBuilder();
							rowMeasure.append(nullCheckType + "(")
									  .append(KprAnalysisConstants.convertGroupFunction(rowTotalTypeCode, columnDto.getColumnAlias()) + ", 0)");

							if (TOTAL_DP_TYPE_CD.AVG.name().equals(rowTotalTypeCode)) {
								if (decimalPlaces != 0) {
									rowMeasure = this.getConvertDecimalPlaces(decimalPlaces, rowMeasure);
								} else {
									rowMeasure = this.getConvertDecimalPlaces(1, rowMeasure);
								}
							} else {
								if (decimalPlaces != 0) {
									rowMeasure = this.getConvertDecimalPlaces(decimalPlaces, rowMeasure);
								} else {
									rowMeasure = this.getConvertDecimalPlaces(0, rowMeasure);
								}
							}

							rowTotalSelect.append(rowMeasure.toString());
							rowTotalSelect.append(" as \"" + columnDto.getColumnAlias() + "\"\n");
						}
					}

					if (KprAnalysisConstants.COL_USE_TYPE_CD.COLUMN.name().equals(columnUseTypeCode)) {
						if (ObjectUtil.isNotEmpty(lastDimension)) {
							if (!measureNameMapAddFlag) {
								columnNameList.add(this.getNameMap(KprAnalysisConstants.COL_TYPE_CD.MEASURE.name(), KprAnalysisConstants.COL_TYPE_CD.MEASURE.name(), "Y".equals(columnDto.getSubTotalFlag())));
								measureNameMapAddFlag = true;
							}
						} else {
							valueNameList.add(this.getNameMap(columnDto.getColumnDisplayName(), columnDto.getColumnAlias(), "Y".equals(columnDto.getSubTotalFlag())));
						}
					} else {
						// Measure 가 Row 에 위치해 있다면, Measure 라는 Name Map 하나만 추가
						if (!measureNameMapAddFlag) {
							rowNameList.add(this.getNameMap(KprAnalysisConstants.COL_TYPE_CD.MEASURE.name(), KprAnalysisConstants.COL_TYPE_CD.MEASURE.name(), "Y".equals(columnDto.getSubTotalFlag())));
							measureNameMapAddFlag = true;
						}
					}
				}

				columnIdx++;
			}
		} else {
			resDto.setGenerateFlag(false);
		}

		// 외부에서 들어온 값과 DrillDown Group 의 값을 filter/prompt와 중복으로 사용해야 하므로
		// filter/prompt는 임시 where list 에 설정
		// Filter 설정
		LinkedHashMap<String, KprAnalysisEngineResDto> tempWhereMap = new LinkedHashMap<String, KprAnalysisEngineResDto>();
		List<KprAnalysisEngineResDto> filterList = kprAnalysisEngineaMapper.selectAnalysisFilterList(aer);
		if (filterList.size() > 0) {
			for (KprAnalysisEngineResDto filterDto : filterList) {
				tempWhereMap.put(filterDto.getTableColumnAlias(), filterDto);
			}
		}

		// 대시보드 / 미리보기에서 요청이 들어왔을 시에만, Prompt 값을 조회하여 처리
		boolean publishFlag = aer.getPublishFlag();
		if (publishFlag) {
			// Prompt 설정
			List<KprAnalysisEngineResDto> promptList = kprAnalysisEngineaMapper.selectAnalysisPromptList(aer);
			if (promptList.size() > 0) {
				resDto.setPromptFlag(true);

				for (KprAnalysisEngineResDto promptDto : promptList) {
					String promptTypeCode = promptDto.getPromptTypeCode();

					if (!KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode)) {
						String operationTypeCode = this.convertPromptTypeCode(promptTypeCode);

						if (tempWhereMap.containsKey(promptDto.getTableColumnAlias())) {
							KprAnalysisEngineResDto tempWhereDto = tempWhereMap.get(promptDto.getTableColumnAlias());
							tempWhereDto.setPromptFlag(true);
							tempWhereDto.setOperationTypeCode(operationTypeCode);
							tempWhereDto.setFilterValue(promptDto.getPromptValue());

							if (ObjectUtil.isNotEmpty(tempWhereDto.getGroupFuncTypeCode())) {
								tempWhereDto.setGroupFuncTypeCode(null);
							}

							tempWhereMap.put(promptDto.getTableColumnAlias(), tempWhereDto);
						} else {
							promptDto.setPromptFlag(true);
							promptDto.setOperationTypeCode(operationTypeCode);
							promptDto.setFilterValue(promptDto.getPromptValue());

							tempWhereMap.put(promptDto.getTableColumnAlias(), promptDto);
						}
					}
				}
			}

			// 미리보기 / 대시보드에서 설정한 Prompt 값이 존재한다면 처리
			HashMap<String, Object> promptDataMap = aer.getPromptDataMap();
			if (ObjectUtil.isNotEmpty(promptDataMap)) {
				resDto.setPromptFlag(true);
				resDto.setPromptDataMap(promptDataMap);

				for (String promptDataMapKey : promptDataMap.keySet()) {
					HashMap<String, Object> promptData = (HashMap<String, Object>) promptDataMap.get(promptDataMapKey);

					String promptTypeCode = (String) promptData.get("promptTypeCode");
					String operationTypeCode = this.convertPromptTypeCode(promptTypeCode);

					String tableColumnAlias = (String) promptData.get("tableColumnAlias");
					String promptValue = (String) promptData.get("promptValue");

					if (tempWhereMap.containsKey(tableColumnAlias)) {
						KprAnalysisEngineResDto tempWhereDto = tempWhereMap.get(tableColumnAlias);
						tempWhereDto.setPromptFlag(true);
						tempWhereDto.setOperationTypeCode(operationTypeCode);
						tempWhereDto.setFilterValue(promptValue);

						if (ObjectUtil.isNotEmpty(tempWhereDto.getGroupFuncTypeCode())) {
							tempWhereDto.setGroupFuncTypeCode(null);
						}

						tempWhereMap.put(tableColumnAlias, tempWhereDto);
					} else {
						KprAnalysisEngineResDto tempPromptDto = new KprAnalysisEngineResDto();
						tempPromptDto.setPromptFlag(true);
						tempPromptDto.setTableColumnAlias(tableColumnAlias);
						tempPromptDto.setOperationTypeCode(operationTypeCode);
						tempPromptDto.setFilterValue(promptValue);

						tempWhereMap.put(tableColumnAlias, tempPromptDto);
					}
				}
			}
		}

		// 외부에서 들어오는 조건 값을 조회 후 처리
		List<KprDashboardPromptReqDto> dashboardPromptDataMap = aer.getDashboardPromptDataMap();
		if (ObjectUtil.isNotEmpty(dashboardPromptDataMap)) {
			List<KprAnalysisEngineResDto> dashboardPromptDataList = kprAnalysisEngineaMapper.selectDashboardPromptDataList(aer);

			if (ObjectUtil.isNotEmpty(dashboardPromptDataList)) {
				for (KprAnalysisEngineResDto dashboardPromptDataResDto : dashboardPromptDataList) {
					String columnId = dashboardPromptDataResDto.getColumnId();

					KprDashboardPromptReqDto tempDashboardPromptDto = null;
					for (KprDashboardPromptReqDto dashboardPromptDataReqDto : dashboardPromptDataMap) {
						String dashboardColumnId = dashboardPromptDataReqDto.getColumnId();
						if (dashboardColumnId.equals(columnId)) {
							tempDashboardPromptDto = dashboardPromptDataReqDto;
							break;
						}
					}

					if (ObjectUtil.isNotEmpty(tempDashboardPromptDto)) {
						String tableColumnAlias = dashboardPromptDataResDto.getTableColumnAlias();

						String promptTypeCode = tempDashboardPromptDto.getPromptTypeCode();
						String operationTypeCode = this.convertPromptTypeCode(promptTypeCode);

						if (tempWhereMap.containsKey(tableColumnAlias)) {
							KprAnalysisEngineResDto tempWhereDto = tempWhereMap.get(tableColumnAlias);
							tempWhereDto.setPromptFlag(true);
							tempWhereDto.setOperationTypeCode(operationTypeCode);
							tempWhereDto.setFilterValue(tempDashboardPromptDto.getPromptValue());

							if (ObjectUtil.isNotEmpty(tempWhereDto.getGroupFuncTypeCode())) {
								tempWhereDto.setGroupFuncTypeCode(null);
							}

							tempWhereMap.put(tableColumnAlias, tempWhereDto);
						} else {
							KprAnalysisEngineResDto tempPromptDto = new KprAnalysisEngineResDto();
							tempPromptDto.setPromptFlag(true);
							tempPromptDto.setTableColumnAlias(tableColumnAlias);
							tempPromptDto.setOperationTypeCode(operationTypeCode);
							tempPromptDto.setFilterValue(tempDashboardPromptDto.getPromptValue());

							tempWhereMap.put(tableColumnAlias, tempPromptDto);
						}
					}
				}
			}
		}

		// 그룹함수를 사용하는 조건이 있을 시 사용하는 임시 테이블 Alias
		String leftJoinTableAlias = "Z" + StringUtils.leftPad("1", 5, "0");
		boolean groupFuncFlag = false;

		StringBuilder subSelect = new StringBuilder("select ");
		StringBuilder subJoin = new StringBuilder();
		StringBuilder subGroupBy = new StringBuilder("group by ");

		boolean subSelectCommaFlag = false;
		boolean subGroupByCommaFlag = false;

		// 우선 순위 //
		// 1. Dashboard Prompt 설정 값
		// 2. Prompt 설정 값에서 설정하는 조건 값
		// 3. Defatul Prompt 설정 값
		// 4. Filter 설정 값
		KprCommonDateFunctionReqDto dateFunctionReqDto = new KprCommonDateFunctionReqDto();
		dateFunctionReqDto.setDatabaseType(databaseTypeCode);

		// 드릴다운 그룹 where 문 설정
		if (ObjectUtil.isNotEmpty(mainWhereMap)) {
			for (String mainWhereMapKey : mainWhereMap.keySet()) {
				KprAnalysisEngineResDto mainWhereDto = mainWhereMap.get(mainWhereMapKey);
				mainWhere.append(this.getAnalysisWhereCondition(mainWhereDto));
			}
		}

		// filter / prompt / Dashboard Prompt where 문 설정
		if (ObjectUtil.isNotEmpty(tempWhereMap)) {
			for (String tempWhereMapKey : tempWhereMap.keySet()) {
				KprAnalysisEngineResDto tempWhereDto = tempWhereMap.get(tempWhereMapKey);

				String operationTypeCode = tempWhereDto.getOperationTypeCode();
				if (KprAnalysisConstants.SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
					operationTypeCode = " = ";

					String filterValue = tempWhereDto.getFilterValue();
					filterValue = filterValue.replace("'", "");

					dateFunctionReqDto.setCodeName(filterValue);
					KprCommonDateFunctionResDto dateFunctionResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

					tempWhereDto.setOperationTypeCode(operationTypeCode);
					tempWhereDto.setFilterValue(dateFunctionResDto.getDateFunc());
				}

				boolean promptFlag = ObjectUtil.isNotEmpty(tempWhereDto.getPromptFlag()) ? tempWhereDto.getPromptFlag() : false;
				if (promptFlag) {
					String promptValue = tempWhereDto.getFilterValue();
					String[] splitList = promptValue.split(" AND ");

					String promptValue1 = null;
					String promptValue2 = null;

					int idx = 0;
					for (String splitValue : splitList) {
						if (idx == 0) {
							promptValue1 = splitValue.replace("'", "");
							idx++;
						} else {
							promptValue2 = splitValue.replace("'", "");
						}
					}

					String filterValue = "";
					if (ObjectUtil.isNotEmpty(promptValue1)) {
						dateFunctionReqDto.setCodeName(promptValue1);
						KprCommonDateFunctionResDto dateFunctionResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

						if (ObjectUtil.isNotEmpty(dateFunctionResDto)) {
							filterValue = filterValue + dateFunctionResDto.getDateFunc();
						} else {
							filterValue = filterValue + "'" + promptValue1 + "'";
						}
					}

					if (ObjectUtil.isNotEmpty(promptValue2)) {
						filterValue = filterValue + " AND ";

						dateFunctionReqDto.setCodeName(promptValue2);
						KprCommonDateFunctionResDto dateFunctionResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

						if (ObjectUtil.isNotEmpty(dateFunctionResDto)) {
							filterValue = filterValue + dateFunctionResDto.getDateFunc();
						} else {
							filterValue = filterValue + "'" + promptValue2 + "'";
						}
					}

					tempWhereDto.setFilterValue(filterValue);
				}

				String groupFuncTypeCode = tempWhereDto.getGroupFuncTypeCode();
				if (ObjectUtil.isNotEmpty(groupFuncTypeCode)) {
					groupFuncFlag = true;

					if (subSelectCommaFlag) {
						subSelect.append(", ");
					} else {
						subSelectCommaFlag = true;
					}

					subSelect.append(nullCheckType + "(");
					subSelect.append(KprAnalysisConstants.convertGroupFunction(groupFuncTypeCode, tempWhereDto.getTableColumnAlias()) + ", 0");
					subSelect.append(") as " + tempWhereDto.getColumnName() + "\n");

					tempWhereDto.setTableColumnAlias(leftJoinTableAlias + "." + tempWhereDto.getColumnName());
				}

				mainWhere.append(this.getAnalysisWhereCondition(tempWhereDto));
			}
		}

			if (groupFuncFlag &&columnList.size() > 0) {
				for (KprAnalysisEngineResDto columnDto : columnList) {
					String columnTypeCode = columnDto.getColumnTypeCode();
					if (KprAnalysisConstants.COL_TYPE_CD.DIMENSION.name().equals(columnTypeCode)) {
						if (subSelectCommaFlag) {
							subSelect.append(", ");
						} else {
							subSelectCommaFlag = true;
						}

						if (subGroupByCommaFlag) {
							subGroupBy.append(", ");
						} else {
							subGroupByCommaFlag = true;
						}

						if (subJoin.length() == 0) {
							subJoin.append(leftJoinTableAlias + " on ");
						} else {
							subJoin.append(" and ");
						}

						subSelect.append(columnDto.getTableColumnAlias() + " as " + columnDto.getColumnName() + "\n");
						subGroupBy.append(columnDto.getTableColumnAlias() + "\n");
						subJoin.append(columnDto.getTableColumnAlias() + " = " + leftJoinTableAlias + "." + columnDto.getColumnName());
					}
				}
			}
		

		StringBuilder lgcCompSQL = new StringBuilder();
		//lgcCompSQL.append(aer.getLogicalComponentFromSql() + "\n");
		int idx = aer.getLogicalComponentFromSql().indexOf("FROM");
		lgcCompSQL.append(aer.getLogicalComponentFromSql().substring(idx) + "\n");

		if (groupFuncFlag) {
			lgcCompSQL.append(" left join (\n");
			lgcCompSQL.append(subSelect.toString());
			lgcCompSQL.append(aer.getLogicalComponentFromSql() + "\n");
			lgcCompSQL.append(subGroupBy.toString());
			lgcCompSQL.append(" )" + subJoin.toString() + "\n");
		}

		StringBuilder baseSQL = new StringBuilder();
		baseSQL.append(mainSelect.toString())
			   .append(lgcCompSQL.toString())
			   .append(mainWhere.toString())
			   .append(mainGroupBy.toString());

		StringBuilder colTotalSQL = new StringBuilder();
		if (colTotalFlag) {
			colTotalSQL.append(colTotalSelect.toString());
			colTotalSQL.append("  from (\n");

			colTotalSQL.append(mainTotalSelect.toString());
			colTotalSQL.append(lgcCompSQL.toString());

			colTotalSQL.append(mainWhere.toString());
			colTotalSQL.append(mainGroupBy.toString());

			colTotalSQL.append(") t\n");
			colTotalSQL.append(colTotalGroupBy.toString());
		}

		StringBuilder rowTotalSQL = new StringBuilder();
		if (rowTotalFlag) {
			rowTotalSQL.append(rowTotalSelect.toString());
			rowTotalSQL.append("  from (\n");

			rowTotalSQL.append(mainTotalSelect.toString());
			rowTotalSQL.append(lgcCompSQL.toString());

			rowTotalSQL.append(mainWhere.toString());
			rowTotalSQL.append(mainGroupBy.toString());

			rowTotalSQL.append(") t\n");
			rowTotalSQL.append(rowTotalGroupBy.toString());
		}

		if (ObjectUtil.isNotEmpty(lastDimension)) {
			valueNameList.add(this.getNameMap("VALUE", "VALUE", "Y".equals(lastDimension.getSubTotalFlag())));
		}

		resDto.setColumnList(columnList);
		resDto.setFieldGroupColumnId(fieldGroupColumnId);
		resDto.setBaseSQL(baseSQL.toString());
		resDto.setLogicalComponentFromSql(lgcCompSQL.toString());

		resDto.setLastDimension(lastDimension);
		resDto.setMeasureLoc(measureLoc);

		resDto.setColumnNameList(columnNameList);
		resDto.setRowNameList(rowNameList);
		resDto.setValueNameList(valueNameList);

		resDto.setDimensionColumnList(dimensionColumnList);
		resDto.setDimensionRowList(dimensionRowList);
		resDto.setMeasureList(measureList);

		resDto.setStrAnlWhere(mainWhere.toString());

		resDto.setColTotalFlag(colTotalFlag);
		resDto.setColTotalSQL(colTotalSQL.toString());
		resDto.setColTotalDimension(colTotalDimension);

		resDto.setRowTotalFlag(rowTotalFlag);
		resDto.setRowTotalSQL(rowTotalSQL.toString());
		resDto.setRowTotalDimension(rowTotalDimension);
		return resDto;
	}

	 /*
	  * 1. 메소드명: getAnalysisWhereCondition
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param whereDto
	 *   @return	
	 */
	private String getAnalysisWhereCondition(KprAnalysisEngineResDto whereDto) {
		String andOrFlag = whereDto.getAndOrFlag();
		String operationTypeCode = whereDto.getOperationTypeCode();
		String leftBrktFlag = whereDto.getLeftBrktFlag();
		String rightBrktFlag = whereDto.getRightBrktFlag();

		// Prompt의 경우 AND/OR 값이 없으므로 무조건 AND를 추가
		if (ObjectUtil.isEmpty(andOrFlag)) {
			andOrFlag = " and ";
		}

		if (KprAnalysisConstants.SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
			operationTypeCode = " = ";
		}

		if ("1".equals(leftBrktFlag))
			leftBrktFlag = "( ";
		else {
			leftBrktFlag = " ";
		}

		if ("1".equals(rightBrktFlag))
			rightBrktFlag = " )";
		else {
			rightBrktFlag = " ";
		}

		return andOrFlag + " " + leftBrktFlag + whereDto.getTableColumnAlias() + " " + operationTypeCode + " " + whereDto.getFilterValue() + rightBrktFlag + "\n";
	}

	 /*
	  * 1. 메소드명: makeAnalyticsDefaultDataMap
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	private List<HashMap<String, Object>> makeAnalyticsDefaultDataMap(KprAnalysisEngineResDto aer) {
		KprAnalysisEngineResDto lastDimension = aer.getLastDimension();
		boolean lstDimFlag = ObjectUtil.isEmpty(lastDimension);

		List<KprAnalysisEngineResDto> dimensionColumnList = aer.getDimensionColumnList();
		List<KprAnalysisEngineResDto> dimensionRowList = aer.getDimensionRowList();
		List<KprAnalysisEngineResDto> measureList = aer.getMeasureList();

		List<HashMap<String, Object>> martDataList = aer.getMartDataList();
		if (martDataList.size() > 0) {
			List<HashMap<String, Object>> resMartDataList = new ArrayList<HashMap<String, Object>>();

			List<HashMap<String, Object>> dimensionColumnDataMapList = this.getDimensionDataList(COL_USE_TYPE_CD.COLUMN, aer);
			List<HashMap<String, Object>> dimensionRowDataMapList = this.getDimensionDataList(COL_USE_TYPE_CD.ROW, aer);

			if (ObjectUtil.isNotEmpty(dimensionColumnDataMapList) && ObjectUtil.isNotEmpty(dimensionRowDataMapList)) {
				for (HashMap<String, Object> dimensionColumnDataMap : dimensionColumnDataMapList) {
					for (HashMap<String, Object> dimensionRowDataMap : dimensionRowDataMapList) {
						HashMap<String, Object> cpyColumnDataMap = (HashMap<String, Object>) this.getDeepCopyDataObject(dimensionColumnDataMap);
						cpyColumnDataMap.putAll(dimensionRowDataMap);

						resMartDataList.add(cpyColumnDataMap);
					}
				}
			} else if (ObjectUtil.isNotEmpty(dimensionColumnDataMapList)) {
				resMartDataList = dimensionColumnDataMapList;
			} else {
				resMartDataList = dimensionRowDataMapList;
			}

			List<KprAnalysisEngineResDto> columnDimensionList = new ArrayList<KprAnalysisEngineResDto>();
			columnDimensionList.addAll(dimensionColumnList);
			columnDimensionList.addAll(dimensionRowList);

			if (resMartDataList.size() > 0 && measureList.size() > 0) {
				for (HashMap<String, Object> resMartData : resMartDataList) {
					for (HashMap<String, Object> martData : martDataList) {
						boolean dataCheckFlag = false;

						for (KprAnalysisEngineResDto columnDimensionDto : columnDimensionList) {
							String dataKey = columnDimensionDto.getColumnAlias();

							if (martData.get(dataKey).equals(resMartData.get(dataKey))) {
								dataCheckFlag = true;
							} else {
								dataCheckFlag = false;
								break;
							}
						}

						if (dataCheckFlag) {
							for (KprAnalysisEngineResDto measureDto : measureList) {
								String dataKey = measureDto.getColumnDisplayName();
								String dataValue = measureDto.getColumnAlias();

								if (lstDimFlag) {
									resMartData.put(dataKey, martData.get(dataValue));
									resMartData.remove(dataValue);
								} else {
									if (resMartData.get("MEASURE").equals(dataKey)) {
										resMartData.put("VALUE", martData.get(dataValue));

										break;
									}
								}
							}
						}
					}
				}
			}

			return resMartDataList;
		} else {
			return martDataList;
		}
	}

	 /*
	  * 1. 메소드명: makeAnalyticsDataSet
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	private KprAnalysisEngineResDto makeAnalyticsDataSet(KprAnalysisEngineResDto aer) {
		List<HashMap<String, Object>> martDataList = this.makeAnalyticsDefaultDataMap(aer);

		// 정보 저장용 데이터 세팅
		List<HashMap<String, Object>> svMartDataList = new ArrayList<HashMap<String, Object>>();
		List<KprAnalysisEngineResDto> dimensionColumnList = aer.getDimensionColumnList();
		List<KprAnalysisEngineResDto> dimensionRowList = aer.getDimensionRowList();
		List<KprAnalysisEngineResDto> columnDimensionList = new ArrayList<KprAnalysisEngineResDto>();
		columnDimensionList.addAll(dimensionColumnList);
		columnDimensionList.addAll(dimensionRowList);

		for (HashMap<String, Object> martData : martDataList) {
			svMartDataList.add((HashMap<String, Object>) this.getDeepCopyDataObject(martData));

			for (KprAnalysisEngineResDto columnDimDtl : columnDimensionList) {
				String dataKey = columnDimDtl.getColumnDisplayName();
				String dataValue = columnDimDtl.getColumnAlias();

				if (martData.containsKey(dataValue)) {
					martData.put(dataKey, martData.get(dataValue));
					martData.remove(dataValue);
				}
			}
		}

		HashMap<String, Object> analysisDataMap = new HashMap<String, Object>();
		analysisDataMap.put("columnNameList", aer.getColumnNameList());
		analysisDataMap.put("rowNameList", aer.getRowNameList());
		analysisDataMap.put("martDataList", svMartDataList);
		aer.setAnalysisDataMap(analysisDataMap);
		aer.setMartDataList(martDataList);
		return aer;
	}

	 /*
	  * 1. 메소드명: getAnalysisTableDataSet
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		테이블 데이터셋 설정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @return	
	 */
	private KprAnalysisEngineResDto getAnalysisTableDataSet(KprAnalysisEngineResDto aer) {
		KprAnalysisEngineResDto baseDto = this.makeAnalyticsDataSet(aer);
		return baseDto;
	}

	 /*
	  * 1. 메소드명: getAnalysisChartDataSet
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		차트 데이터셋 설정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param aer
	 *   @return	
	 */
	private KprAnalysisEngineResDto getAnalysisChartDataSet(KprAnalysisEngineResDto aer) {
		KprAnalysisEngineResDto baseDto = this.makeAnalyticsDataSet(aer);
		List<HashMap<String, Object>> martDataList = baseDto.getMartDataList();

		if (martDataList.size() > 0) {
			List<HashMap<String, Object>> columnNameList = baseDto.getColumnNameList();
			List<HashMap<String, Object>> rowNameList = baseDto.getRowNameList();

			boolean columnNameListFlag = ObjectUtil.isNotEmpty(columnNameList);
			boolean rowNameListFlag = ObjectUtil.isNotEmpty(rowNameList);

			// 차트 데이터는 테이블 데이터와 다르게
			// Columns 에는 columnValue 라는 이름의 값과
			// Rows 에는 rowValue 라는 이름의 값만 들어감.
			// 하여 마트데이터를 루프 돌면서 Dimension에 해당 하는 값은
			// "-"를 붙여 연결하고, 항목은 삭제처리함.
			for (HashMap<String, Object> martData : martDataList) {
				if (columnNameListFlag) {
					StringBuilder columnValue = new StringBuilder();
					for (HashMap<String, Object> columnName : columnNameList) {
						if (columnValue.length() != 0) {
							columnValue.append(" - ");
						}

						String martValue = (String) martData.get((String) columnName.get("fieldName"));
						martData.remove((String) columnName.get("fieldName"));
						columnValue.append(martValue);
					}

					martData.put("columnValue", columnValue.toString());
				}

				if (rowNameListFlag) {
					StringBuilder rowValue = new StringBuilder();
					for (HashMap<String, Object> rowName : rowNameList) {
						if (rowValue.length() != 0) {
							rowValue.append(" - ");
						}

						String martValue = (String) martData.get((String) rowName.get("fieldName"));
						martData.remove((String) rowName.get("fieldName"));
						rowValue.append(martValue);
					}

					martData.put("rowValue", rowValue.toString());
				}
			}

			// colmunNameList 및 rowNameList에도 마찮가지로 columnValue, rowValue 추가
			if (columnNameListFlag) {
				columnNameList = new ArrayList<HashMap<String, Object>>();

				HashMap<String, Object> columnNameMap = getNameMap("columnValue", "columnValue", false);
				columnNameList.add(columnNameMap);

				baseDto.setColumnNameList(columnNameList);
			}

			if (rowNameListFlag) {
				rowNameList = new ArrayList<HashMap<String, Object>>();

				HashMap<String, Object> rowNameMap = getNameMap("rowValue", "rowValue", false);
				rowNameList.add(rowNameMap);

				baseDto.setRowNameList(rowNameList);
			}

			baseDto.setMartDataList(martDataList);
		}

		return baseDto;
	}

	 /*
	  * 1. 메소드명: getNvlType
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param databaseTypeCode
	 *   @return	
	 */
	private String getNvlType(String databaseTypeCode) {
		if (KprAnalysisConstants.DATABASE_TYPE.ORACLE.name().equals(databaseTypeCode)) {
			return "NVL";
		}
		return "COALESCE";
	}

	 /*
	  * 1. 메소드명: convertCalcFieldOperationCode
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param oprtTypeCode
	 *   @return	
	 */
	private String convertCalcFieldOperationCode(String oprtTypeCode) {
		String returnCode = null;

		switch (oprtTypeCode) {
		case "PLUS":
			returnCode = "+";
			break;

		case "MINUS":
			returnCode = "-";
			break;

		case "MULTIPLY":
			returnCode = "*";
			break;

		case "DIVI":
			returnCode = "/";
			break;
		default :
			returnCode = "";
			break;
		}

		return returnCode;
	}

	 /*
	  * 1. 메소드명: convertPromptTypeCode
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param promptTypeCode
	 *   @return	
	 */
	private String convertPromptTypeCode(String promptTypeCode) {
		if (KprAnalysisConstants.PROMPT_TYPE_CD.DATE_BETWEEN.name().equals(promptTypeCode)) {
			return " BETWEEN ";
		}
		return " = ";
	}

	 /*
	  * 1. 메소드명: getNameMap
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param displayName
	 *   @param aliasName
	 *   @param flagSubTotal
	 *   @param measureLoc
	 *   @return	
	 */
	private HashMap<String, Object> getNameMap(String displayName, String aliasName, boolean flagSubTotal) {
		HashMap<String, Object> nameMap = new HashMap<String, Object>();
		nameMap.put("fieldName", displayName);
		nameMap.put("fieldCaption", aliasName);
		nameMap.put("sortOrder", "none");
		nameMap.put("showSubTotal", flagSubTotal);

		return nameMap;
	}

	 /*
	  * 1. 메소드명: getDeepCopyDataObject
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dataObject
	 *   @return	
	 */
	private Object getDeepCopyDataObject(Object dataObject) {
		Object rstDataObject = new Object();
		ByteArrayOutputStream baos = null;
		ObjectOutputStream oos = null;
		ByteArrayInputStream bais = null;
		ObjectInputStream ios = null;

		try {
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(dataObject);

			bais = new ByteArrayInputStream(baos.toByteArray());
			ios = new ObjectInputStream(bais);
			rstDataObject = ios.readObject();
		} catch (ClassNotFoundException e) {
			LogUtil.error(e);
		} catch (IOException e) {
			LogUtil.error(e);
		} finally {
			if (baos != null) {
				try {
					baos.close();
				} catch (Exception e2) {
					
					baos = null;
				}
			}

			if (oos != null) {
				try {
					oos.close();
				} catch (Exception e2) {
					oos = null;
				}
			}

			if (bais != null) {
				try {
					bais.close();
				} catch (Exception e2) {
					bais = null;
				}
			}

			if (ios != null) {
				try {
					ios.close();
				} catch (Exception e2) {
					ios = null;
				}
			}

		}
		return rstDataObject;
	}

	 /*
	  * 1. 메소드명: getDimensionDataList
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dataMapType
	 *   @param aer
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	private List<HashMap<String, Object>> getDimensionDataList(COL_USE_TYPE_CD dataMapType, KprAnalysisEngineResDto aer) {
		boolean executeFlag = false;
		String measureLoc = aer.getMeasureLoc();
		KprAnalysisEngineResDto lstDim = aer.getLastDimension();
		boolean lstDimFlag = ObjectUtil.isEmpty(lstDim);

		KprAnalysisEngineResDto totalDim = dataMapType.equals(COL_USE_TYPE_CD.COLUMN) ? aer.getColTotalDimension() : aer.getRowTotalDimension();
		boolean totalFlag = dataMapType.equals(COL_USE_TYPE_CD.COLUMN) ? aer.getColTotalFlag() : aer.getRowTotalFlag();
		String suffixTotalDisplayName = dataMapType.equals(COL_USE_TYPE_CD.COLUMN) ? aer.getColTotalTypeCodeName() : aer.getRowTotalTypeCodeName();

		StringBuilder sbQueryMeasure = new StringBuilder();
		int measureSeq = -1;
		boolean apdMeasureFlag = false;

		String databaseTypeCode = aer.getDatabaseTypeCode();
		String dummyTable = this.getDummyTableName(databaseTypeCode);

		List<KprAnalysisEngineResDto> measureList = aer.getMeasureList();
		if (dataMapType.name().equals(measureLoc)) {
			boolean measureCommaFlag = false;

			if (ObjectUtil.isNotEmpty(measureList)) {
				executeFlag = true;

				if (lstDimFlag) {
					for (KprAnalysisEngineResDto measureDtl : measureList) {
						measureSeq = measureDtl.getSeq();

						if (!measureCommaFlag) {
							sbQueryMeasure.append("SELECT ");

							measureCommaFlag = true;
						} else {
							sbQueryMeasure.append("\n     , ");
						}

						sbQueryMeasure.append("'" + measureDtl.getColumnDisplayName() + "' AS " + measureDtl.getColumnAlias());
					}

					sbQueryMeasure.append("\n     , " + measureSeq + " AS MSEQ " + dummyTable + "\n");
				} else {
					for (KprAnalysisEngineResDto measureDtl : measureList) {
						measureSeq = measureDtl.getSeq();

						if (measureCommaFlag) {
							sbQueryMeasure.append(" UNION ALL\n");
						} else {
							measureCommaFlag = true;
						}

						sbQueryMeasure.append("SELECT '" + measureDtl.getColumnDisplayName() + "' AS MEASURE, " + measureSeq + " AS MSEQ " + dummyTable + "\n");
					}
				}
			}
		}

		List<KprAnalysisEngineResDto> columnList = new ArrayList<KprAnalysisEngineResDto>();
		if (COL_USE_TYPE_CD.COLUMN.equals(dataMapType)) {
			columnList = aer.getDimensionColumnList();
		} else {
			columnList = aer.getDimensionRowList();
		}

		StringBuilder sbInnerTotalSelect = new StringBuilder("    SELECT ");
		StringBuilder sbInnerTotalGroupBy = new StringBuilder("     GROUP BY ");

		StringBuilder sbInnerSelect = new StringBuilder("    SELECT ");
		StringBuilder sbInnerFrom = new StringBuilder("      ");
		sbInnerFrom.append(aer.getLogicalComponentFromSql())
				   .append("\n");
		StringBuilder sbInnerWhere = new StringBuilder("     ");
		sbInnerWhere.append(aer.getStrAnlWhere())
		            .append("\n");
		StringBuilder sbInnerGroupBy = new StringBuilder("     GROUP BY ");

		StringBuilder sbOuterSelect = new StringBuilder("SELECT ");
		StringBuilder sbOuterOrderBy = new StringBuilder();

		int orderSequence = 1;
		boolean commaFlag = false;
		boolean innerSelectCommaFlag = false;
		boolean outerOrderByCommaFlag = false;
		String tmpDimensionTblAlias = "T";
		String tmpMeasureTblAlias = "Z";

		int columnIdx = 1;
		for (KprAnalysisEngineResDto columnDtl : columnList) {
			String orderAtribGroupColumnId = columnDtl.getOrderAtribGroupColumnId();
			String orderColumnAliasName = "O" + StringUtils.leftPad(String.valueOf(orderSequence++), 4, "0");
			String tableColumnName = columnDtl.getTableAlias() + "." + columnDtl.getColumnName();

			if (commaFlag) {
				sbInnerGroupBy.append("\n            , ");
				sbOuterSelect.append("\n     , ");

				sbInnerTotalGroupBy.append("\n            , ");
			} else {
				commaFlag = true;
			}

			if (innerSelectCommaFlag) {
				sbInnerSelect.append("\n         , ");

				sbInnerTotalSelect.append("\n         , ");
			}

			if (sbQueryMeasure.length() > 0 && measureSeq != -1 && measureSeq < columnDtl.getSeq() && !apdMeasureFlag) {
				apdMeasureFlag = true;

				if (lstDimFlag) {
					for (KprAnalysisEngineResDto measureDtl : measureList) {
						sbOuterSelect.append(tmpMeasureTblAlias + "." + measureDtl.getColumnAlias() + " AS \"" + measureDtl.getColumnAlias() + "\"\n");

						sbOuterSelect.append("     , ");
					}
				} else {
					sbOuterSelect.append(tmpMeasureTblAlias + ".MEASURE AS \"MEASURE\"\n");

					sbOuterSelect.append("     , ");
				}

				if (sbOuterOrderBy.length() == 0) {
					sbOuterOrderBy.append(" ORDER BY ");
				}

				if (outerOrderByCommaFlag) {
					sbOuterOrderBy.append("\n        , ");
				}

				sbOuterOrderBy.append(tmpMeasureTblAlias + ".MSEQ ASC");

				outerOrderByCommaFlag = true;
			}

			sbOuterSelect.append(tmpDimensionTblAlias + "." + columnDtl.getColumnAlias() + " AS \"" + columnDtl.getColumnAlias() + "\"\n");

			sbInnerSelect.append(tableColumnName + " AS " + columnDtl.getColumnAlias());
			sbInnerGroupBy.append(tableColumnName + "\n");

			if (totalFlag) {
				if (ObjectUtil.isNotEmpty(totalDim)) {
					if (columnDtl.getColumnId().equals(totalDim.getColumnId())) {
						sbInnerTotalSelect.append("'" + this.getTotalDisplayName(suffixTotalDisplayName) + "' AS " + columnDtl.getColumnAlias());
						sbInnerTotalGroupBy.append(columnIdx + "\n");
					} else if (columnDtl.getSeq() < measureSeq) {
						sbInnerTotalSelect.append("'" + this.getTotalDisplayName(suffixTotalDisplayName) + "' AS " + columnDtl.getColumnAlias());
						sbInnerTotalGroupBy.append(columnIdx + "\n");
					} else {
						sbInnerTotalSelect.append(tableColumnName + " AS " + columnDtl.getColumnAlias());
						sbInnerTotalGroupBy.append(tableColumnName + "\n");
					}
				} else {
					sbInnerTotalSelect.append("'" + this.getTotalDisplayName(suffixTotalDisplayName) + "' AS " + columnDtl.getColumnAlias());
					sbInnerTotalGroupBy.append(columnIdx + "\n");
				}
			}

			if (ObjectUtil.isNotEmpty(orderAtribGroupColumnId)) {
				if (sbOuterOrderBy.length() == 0) {
					sbOuterOrderBy.append(" ORDER BY ");
				}

				if (outerOrderByCommaFlag) {
					sbOuterOrderBy.append("        , ");
				}

				sbInnerSelect.append("\n         , ");

				// sbInnerTotalSelect.append("\n , ");s

				String orderTableAliasColumnName = null;
				if (columnDtl.getTableColumnAlias().equals(columnDtl.getOriginTableColumnAlias())) {
					orderTableAliasColumnName = columnDtl.getTableAlias() + "." + columnDtl.getOrderColumnName();

					if (ObjectUtil.isNotEmpty(columnDtl.getOrderDetail())) {
						sbOuterOrderBy.append("CASE " + orderColumnAliasName + columnDtl.getOrderDetail() + " END " + columnDtl.getOrderType() + "\n");
					} else {
						sbOuterOrderBy.append(orderColumnAliasName + " " + columnDtl.getOrderType() + "\n");
					}
				} else {
					orderTableAliasColumnName = tableColumnName;

					sbOuterOrderBy.append(orderColumnAliasName + " " + columnDtl.getOrderType() + "\n");
				}

				String orderType = columnDtl.getOrderType();
				if (KprAnalysisConstants.ORDER_TYPE.DESC.name().equalsIgnoreCase(orderType)) {
					sbInnerSelect.append("MAX(" + orderTableAliasColumnName + ") AS " + orderColumnAliasName);

					// sbInnerTotalSelect.append("MAX(" +
					// orderTableAliasColumnName + ") AS " +
					// orderColumnAliasName);
				} else {
					sbInnerSelect.append("MIN(" + orderTableAliasColumnName + ") AS " + orderColumnAliasName);

					// sbInnerTotalSelect.append("MIN(" +
					// orderTableAliasColumnName + ") AS " +
					// orderColumnAliasName);
				}

				outerOrderByCommaFlag = true;
			} else {
				if (sbOuterOrderBy.length() == 0) {
					sbOuterOrderBy.append(" ORDER BY ");
				}

				if (outerOrderByCommaFlag) {
					sbOuterOrderBy.append("        , ");
				}

				sbOuterOrderBy.append(tmpDimensionTblAlias + "." + columnDtl.getColumnAlias() + " ASC");
				outerOrderByCommaFlag = true;
			}

			innerSelectCommaFlag = true;
			columnIdx++;
		}

		if (sbQueryMeasure.length() > 0 && measureSeq != -1 && !apdMeasureFlag) {
			apdMeasureFlag = true;

			if (lstDimFlag) {
				for (KprAnalysisEngineResDto measureDtl : measureList) {
					if (commaFlag) {
						sbOuterSelect.append("\n     , ");
					} else {
						commaFlag = true;
					}

					sbOuterSelect.append(tmpMeasureTblAlias + "." + measureDtl.getColumnAlias() + " AS \"" + measureDtl.getColumnAlias() + "\"\n");
				}
			} else {
				if (commaFlag) {
					sbOuterSelect.append("\n     , ");
				} else {
					commaFlag = true;
				}

				sbOuterSelect.append(tmpMeasureTblAlias + ".MEASURE AS \"MEASURE\"\n");
			}

			if (sbOuterOrderBy.length() == 0) {
				sbOuterOrderBy.append(" ORDER BY ");
			}

			if (outerOrderByCommaFlag) {
				sbOuterOrderBy.append("\n        , ");
			}

			sbOuterOrderBy.append(tmpMeasureTblAlias + ".MSEQ ASC");
		}

		List<HashMap<String, Object>> resDimensionDataList = new ArrayList<HashMap<String, Object>>();
		StringBuilder dimensionSQL = new StringBuilder();
		StringBuilder dimensionTotalSQL = new StringBuilder();

		dimensionSQL.append(sbOuterSelect.toString())
					.append("  FROM ");

		dimensionTotalSQL.append(sbOuterSelect.toString())
						 .append("  FROM ");

		if (columnList.size() > 0) {
			executeFlag = true;

			dimensionSQL.append("(\n");
			dimensionSQL.append(sbInnerSelect.toString());
			dimensionSQL.append(sbInnerFrom.toString());
			dimensionSQL.append(sbInnerWhere.toString());
			dimensionSQL.append(sbInnerGroupBy.toString());
			dimensionSQL.append(") " + tmpDimensionTblAlias + "\n");

			dimensionTotalSQL.append("(\n");
			dimensionTotalSQL.append(sbInnerTotalSelect.toString());
			dimensionTotalSQL.append(sbInnerFrom.toString());
			dimensionTotalSQL.append(sbInnerWhere.toString());
			dimensionTotalSQL.append(sbInnerTotalGroupBy.toString());
			dimensionTotalSQL.append(") " + tmpDimensionTblAlias + "\n");
		}

		if (sbQueryMeasure.length() > 0) {
			if (columnList.size() > 0) {
				dimensionSQL.append(", ");

				dimensionTotalSQL.append(", ");
			}

			dimensionSQL.append("(\n");
			dimensionSQL.append(sbQueryMeasure.toString());
			dimensionSQL.append(") " + tmpMeasureTblAlias + "\n");

			dimensionTotalSQL.append("(\n");
			dimensionTotalSQL.append(sbQueryMeasure.toString());
			dimensionTotalSQL.append(") " + tmpMeasureTblAlias + "\n");
		}

		dimensionSQL.append(sbOuterOrderBy.toString());

		// dimensionTotalSQL.append(sbOuterOrderBy.toString());

		if (executeFlag) {
			resDimensionDataList = this.mktCallQuery.callSelectForListMap("selectDimensionDataList", dimensionSQL.toString(), new ArrayList<HashMap<String, Object>>(), aer.getDatabaseInfo());

			if (totalFlag && ANALYSIS_TYPE.TABLE.name().equals(aer.getAnalysisType())) {
				List<HashMap<String, Object>> dimensionTotalDataList = this.mktCallQuery.callSelectForListMap("selectDimensionTotalDataList", dimensionTotalSQL.toString(), new ArrayList<HashMap<String, Object>>(), aer.getDatabaseInfo());

				resDimensionDataList.addAll(dimensionTotalDataList);
			}
		}

		return resDimensionDataList;
	}

	private String getDummyTableName(String databaseTypeCode) {
		if (KprAnalysisConstants.DATABASE_TYPE.POSTGRESQL.name().equals(databaseTypeCode)) {
			return "";
		}
		return "FROM DUAL";
	}

	 /*
	  * 1. 메소드명: getConvertDecimalPlaces
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param databaseTypeCode
	 *   @param decimalPlaces
	 *   @param sbMeasure
	 *   @return	
	 */
	private StringBuilder getConvertDecimalPlaces(int decimalPlaces, StringBuilder sbMeasure) {
		int tempDecimalPlaces = decimalPlaces;
		tempDecimalPlaces = ObjectUtil.isEmpty(tempDecimalPlaces) ? 0 : tempDecimalPlaces;

		StringBuilder sbTempBuilder = new StringBuilder();
		sbTempBuilder.append("ROUND(")
					 .append(sbMeasure.toString())
					 .append(", " + tempDecimalPlaces + ")");

		return sbTempBuilder;
	}

	 /*
	  * 1. 메소드명: getTotalDisplayName
	  * 2. 클래스명: KPRAnalysisEngineService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param columnDisplayName
	 *   @param totalTypeCodeName
	 *   @return	
	 */
	private String getTotalDisplayName(String totalTypeCodeName) {
		return totalTypeCodeName;
	}
}