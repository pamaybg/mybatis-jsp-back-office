package com.icignal.kepler.analysis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisChartLabelDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisChartSettingMapper
 * 2. 파일명	: KPRAnalysisChartSettingMapper.java
 * 3. 패키지명	: com.icignal.kepler.analysis.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Mapper
public interface KprAnalysisChartSettingMapper {

	KprAnalysisChartLabelDetailResDto selectAnalysisChartLabelDetail(KprAnalysisChartLabelDetailReqDto reqDto);

	List<KprAnalysisChartLabelDetailResDto> selectAnalysisChartLabelFontDetailList(	KprAnalysisChartLabelDetailReqDto reqDto);

	void updateAnalysisChartLabelDetail(KprAnalysisChartLabelDetailReqDto reqDto);

	void insertAnalysisChartLabelDetailInst(KprAnalysisChartLabelDetailReqDto chartLabelFontDetail);

	void updateAnalysisChartLabelDetailInst(KprAnalysisChartLabelDetailReqDto chartLabelFontDetail);

	void deleteAnalysisChartLabelDetailListInst(KprAnalysisChartLabelDetailReqDto reqDto);

	void insertAnalysisChartLabelDetailMasterToInst(KprAnalysisChartLabelDetailReqDto chartLabelReqDto);

	List<String> selectAnalysisChartLabelIdListInst(KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto);

	Integer selectAnalysisColumnIdCheckMaster(KprAnalysisChartLabelDetailReqDto tempChartLabelDetailReqDto);

	void insertAnalysisChartLabelDetailInstToMaster(KprAnalysisChartLabelDetailReqDto tempChartLabelDetailReqDto);

	void updateAnalysisChartLabelDetailInstToMaster(KprAnalysisChartLabelDetailReqDto tempChartLabelDetailReqDto);

	void deleteAnalysisChartLabelDetailMaster(KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto);

	void insertAnalysisChartLabelDetailMaster(KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto);

	void insertAnalysisChartLabelDetailCopy(KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto);

	List<KprAnalysisChartLabelDetailResDto> selectAnalysisChartLabelDetailList(KprAnalysisChartLabelDetailReqDto charLabelDetailReqDto);
	
	//사용하지 않는거 같습니다.
	void deleteAnalysisChartLabelDetailInst(KprAnalysisChartLabelDetailReqDto reqDto);

}
