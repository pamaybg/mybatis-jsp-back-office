package com.icignal.kepler.analysis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisColumnDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisColumnDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisColumnMapper
 * 2. 파일명	: KPRAnalysisColumnMapper.java
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
public interface KprAnalysisColumnMapper {

	List<KprAnalysisColumnDetailResDto> selectAnalysisColumnList(KprAnalysisColumnDetailReqDto acr);

	KprAnalysisColumnDetailResDto selectAnalysisColumnDetailInst(KprAnalysisColumnDetailReqDto acr);

	Integer selectAnalysisColumnDisplayNameCount(KprAnalysisColumnDetailReqDto columnReqDto);

	void insertAnalysisColumnDetailInst(KprAnalysisColumnDetailReqDto columnReqDto);

	void updateAnalysisColumnDetailInst(KprAnalysisColumnDetailReqDto acr);

	void updateAnalysisColumnAllSequenceInst(KprAnalysisColumnDetailReqDto acr);

	void updateAnalysisColumnTypeCodeChangeInst(KprAnalysisColumnDetailReqDto acr);

	void updateAnalysisColumnCombTypeChangeInst(KprAnalysisColumnDetailReqDto acr);

	void deleteAnalysisColumnDetailInst(KprAnalysisColumnDetailReqDto acr);

	void updateAnalysisColumnSequenceInst(KprAnalysisColumnDetailReqDto acr);

	List<KprAnalysisColumnDetailResDto> selectAnalysisSameTableColumnList(KprAnalysisColumnDetailReqDto reqDto);

	void insertAnalysisColumnDetailMasterToInst(KprAnalysisColumnDetailReqDto columnReqDto);

	List<String> selectAnalysisColumnIdListInst(KprAnalysisColumnDetailReqDto columnDetailReqDto);

	Integer selectAnalysisColumnIdCheckMaster(KprAnalysisColumnDetailReqDto tempColumnDetailReqDto);

	void insertAnalysisColumnDetailInstToMaster(KprAnalysisColumnDetailReqDto tempColumnDetailReqDto);

	void updateAnalysisColumnDetailInstToMaster(KprAnalysisColumnDetailReqDto tempColumnDetailReqDto);

	void deleteAnalysisColumnDetailMaster(KprAnalysisColumnDetailReqDto columnDetailReqDto);

	void deleteAnalysisColumnListInst(KprAnalysisColumnDetailReqDto columnDetailReqDto);

	void insertAnalysisColumnDetailMaster(KprAnalysisColumnDetailReqDto columnDetailReqDto);

	void insertAnalysisColumnDetailCopy(KprAnalysisColumnDetailReqDto columnDetailReqDto);

}
