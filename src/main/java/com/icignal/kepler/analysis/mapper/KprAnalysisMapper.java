package com.icignal.kepler.analysis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDatabaseInfoResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisListResDto;


/*
 * 1. 클래스명	: KPRAnalysisMapper
 * 2. 파일명	: KPRAnalysisMapper.java
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
public interface KprAnalysisMapper {

	List<KprAnalysisAtribGroupColumnDetailResDto> selectAnalysisAtribGroupColumnDetail(	KprAnalysisCommonReqDto analysisCommonReqDto);

	List<KprAnalysisListResDto> selectAnalysisList(KprAnalysisListReqDto alr);

	void insertAnalysisDetailMasterToInst(KprAnalysisDetailReqDto adr);

	KprAnalysisDetailResDto selectAnalysisDetailInst(KprAnalysisDetailReqDto adr);

	KprAnalysisDetailResDto selectAnalysisName(KprAnalysisDetailReqDto adr);

	void insertAnalysisDetailInst(KprAnalysisDetailReqDto adr);

	Integer selectAnalysisNameCheckMaster(KprAnalysisDetailReqDto adr);

	void updateAnalysisDetailInst(KprAnalysisDetailReqDto adr);

	Integer selectAnalysisIdCheckMaster(KprAnalysisDetailReqDto adr);

	void insertAnalysisDetailInstToMaster(KprAnalysisDetailReqDto adr);

	void updateAnalysisDetailInstToMaster(KprAnalysisDetailReqDto adr);

	void deleteAnalysisDetailInst(KprAnalysisDetailReqDto adr);

	void insertAnalysisDetailMaster(KprAnalysisDetailReqDto adr);

	void insertAnalysisDetailCopy(KprAnalysisDetailReqDto adr);

	void updateAnalysisLogicalCompIdInst(KprAnalysisDetailReqDto adr);

	void deleteAnalysisDetailMaster(KprAnalysisDetailReqDto adr);

	void updateAnalysisColumnGroupFlagInst(KprAnalysisDetailReqDto adr);

	void updateAnalysisChartTypeChangeInst(KprAnalysisDetailReqDto adr);

	List<KprAnalysisAtribGroupColumnDetailResDto> selectAnalysisAtribGroupColumnList(KprAnalysisCommonReqDto acr);

	KprAnalysisCommonResDto selectAnalysisAtribGroupColumnValueDetail(KprAnalysisCommonReqDto valueDetailReqDto);

	KprAnalysisDatabaseInfoResDto selectAnalysisDatabaseInfo(KprAnalysisCommonReqDto databaseReqDto);


}
