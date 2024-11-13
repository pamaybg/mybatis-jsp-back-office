package com.icignal.kepler.analysis.common.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisEngineReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisEngineResDto;


/*
 * 1. 클래스명	: KPRAnalysisEngineMapper
 * 2. 파일명	: KPRAnalysisEngineMapper.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *		KPRAnalysisEngineMapper
 * </PRE>
 */ 
@Mapper
public interface KprAnalysisEngineMapper {

	KprAnalysisEngineResDto selectAnalysisDetail(KprAnalysisEngineReqDto aer);

	HashMap<String, Object> selectAnalysisChartInformation(KprAnalysisEngineReqDto chartInformaionReqDto);

	List<KprAnalysisEngineResDto> selectAnalysisDrillDownGroupList(KprAnalysisEngineReqDto aer);

	List<KprAnalysisEngineResDto> selectAnalysisColumnList(KprAnalysisEngineReqDto aer);

	List<KprAnalysisEngineResDto> selectAnalysisFilterList(KprAnalysisEngineReqDto aer);

	List<KprAnalysisEngineResDto> selectAnalysisPromptList(KprAnalysisEngineReqDto aer);

	List<KprAnalysisEngineResDto> selectDashboardPromptDataList(KprAnalysisEngineReqDto aer);

}
