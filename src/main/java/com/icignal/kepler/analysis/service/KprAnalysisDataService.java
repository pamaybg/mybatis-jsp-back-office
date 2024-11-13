package com.icignal.kepler.analysis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisEngineResDto;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.service.KprAnalysisEngineService;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDataReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDataResDto;

/*
 * 1. 클래스명	: KPRAnalysisDataService
 * 2. 파일명	: KPRAnalysisDataService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprAnalysisDataService")
public class KprAnalysisDataService extends KprAnalysisCommonSerivce {

	@Autowired
	private KprAnalysisEngineService kprAnalysisEngineService;

	 /*
	  * 1. 메소드명: getAnalysisDateFilterCheck
	  * 2. 클래스명: KPRAnalysisDataService
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
	 *   @param adr
	 *   @return	
	 */
	public KprAnalysisDataResDto getAnalysisDateFilterCheck(KprAnalysisDataReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);

		KprAnalysisDataResDto rstValue = new KprAnalysisDataResDto();

		Integer dateKeyFlag = this.kprAnalysisDataMapper.selectAnalysisDateKeyFlagCheck(adr);
		if (dateKeyFlag.intValue() > 0) {
			Integer dateFilterCount = this.kprAnalysisDataMapper.selectAnalysisDateFilterCheck(adr);

			if (dateFilterCount.intValue() == 0)
				rstValue.setDateFlag(Boolean.FALSE);
			else
				rstValue.setDateFlag(Boolean.TRUE);
		} else {
			rstValue.setDateFlag(Boolean.TRUE);
		}

		rstValue.setSuccess(true);
		return rstValue;
	}

	public KprAnalysisDataResDto getAnalysisPublishReport(KprAnalysisDataReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);

		String analysisType = adr.getAnalysisTypeCode();
		return setAnalysisDataSet(adr, analysisType);
	}

	private KprAnalysisDataResDto setAnalysisDataSet(KprAnalysisDataReqDto adr, String analysisType) {
		LogUtil.param(KprAnalysisService.class, adr);

		KprAnalysisEngineReqDto engineReqDto = new KprAnalysisEngineReqDto();
		engineReqDto.setAnalysisId(adr.getAnalysisId());
		engineReqDto.setAnalysisMasterFlag(adr.getAnalysisMasterFlag());
		engineReqDto.setPublishFlag(adr.getPublishFlag());
		engineReqDto.setFieldGroupColumnId(adr.getFieldGroupColumnId());
		engineReqDto.setPromptDataMap(adr.getPromptDataMap());
		engineReqDto.setCurrentDrillDownGroupList(adr.getCurrentDrillDownGroupList());
		engineReqDto.setDashboardPromptDataMap(adr.getDashboardPromptDataMap());

		KprAnalysisEngineResDto dataSetDto = null;
		KprAnalysisDataResDto rstValue = new KprAnalysisDataResDto();

		if (KprAnalysisConstants.ANALYSIS_TYPE.TABLE.name().equals(analysisType)) {
			dataSetDto = this.kprAnalysisEngineService.getAnalysisDataDetail(engineReqDto, KprAnalysisConstants.ANALYSIS_TYPE.TABLE);
		} else {
			dataSetDto = this.kprAnalysisEngineService.getAnalysisDataDetail(engineReqDto, KprAnalysisConstants.ANALYSIS_TYPE.CHART);
			rstValue.setChartInformation(dataSetDto.getChartInformation());
		}

		rstValue.setBaseSQL(dataSetDto.getBaseSQL());
		rstValue.setFieldGroupColumnId(dataSetDto.getFieldGroupColumnId());

		rstValue.setMeasureLoc(dataSetDto.getMeasureLoc());
		rstValue.setColTotalTypeCode(dataSetDto.getColTotalTypeCode());
		rstValue.setColTotalTypeCodeName(dataSetDto.getColTotalTypeCodeName());
		rstValue.setRowTotalTypeCode(dataSetDto.getRowTotalTypeCode());
		rstValue.setRowTotalTypeCodeName(dataSetDto.getRowTotalTypeCodeName());

		rstValue.setColumnNameList(dataSetDto.getColumnNameList());
		rstValue.setRowNameList(dataSetDto.getRowNameList());
		rstValue.setValueNameList(dataSetDto.getValueNameList());
		rstValue.setMartDataList(dataSetDto.getMartDataList());

		rstValue.setPromptDataMap(dataSetDto.getPromptDataMap());
		rstValue.setFieldGroupFlag(dataSetDto.getFieldGroupFlag());
		rstValue.setPromptFlag(dataSetDto.getPromptFlag());

		rstValue.setMeasureList(dataSetDto.getMeasureList());
		rstValue.setAnalysisDataMap(dataSetDto.getAnalysisDataMap());

		rstValue.setMetaDrillDownGroupList(dataSetDto.getMetaDrillDownGroupList());
		rstValue.setCurrentDrillDownGroupList(dataSetDto.getCurrentDrillDownGroupList());

		rstValue.setSuccess(true);
		return rstValue;
	}
}