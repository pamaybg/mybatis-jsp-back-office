package com.icignal.kepler.analysis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisPromptDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisPromptDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisPromptMapper
 * 2. 파일명	: KPRAnalysisPromptMapper.java
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
public interface KprAnalysisPromptMapper {

	void insertAnalysisPromptDetailMasterToInst(KprAnalysisPromptDetailReqDto promptReqDto);

	List<String> selectAnalysisPromptIdListInst(KprAnalysisPromptDetailReqDto promptDetailReqDto);

	Integer selectAnalysisPromptIdCheckMaster(KprAnalysisPromptDetailReqDto tempPromptDetailReqDto);

	void insertAnalysisPromptDetailInstToMaster(KprAnalysisPromptDetailReqDto tempPromptDetailReqDto);

	void updateAnalysisPromptDetailInstToMaster(KprAnalysisPromptDetailReqDto tempPromptDetailReqDto);

	void deleteAnalysisPromptDetailMaster(KprAnalysisPromptDetailReqDto promptDetailReqDto);

	void deleteAnalysisPromptListInst(KprAnalysisPromptDetailReqDto promptDetailReqDto);

	void insertAnalysisPromptDetailMaster(KprAnalysisPromptDetailReqDto promptDetailReqDto);

	void insertAnalysisPromptDetailCopy(KprAnalysisPromptDetailReqDto promptDetailReqDto);

	KprAnalysisPromptDetailResDto selectAnalysisPromptDetailInst(KprAnalysisPromptDetailReqDto apr);

	void insertAnalysisPromptDetailInst(KprAnalysisPromptDetailReqDto promptReqDto);

	Integer selectAnalysisPromptCount(KprAnalysisPromptDetailReqDto apr);

	List<KprAnalysisPromptDetailResDto> selectAnalysisPromptListInst(KprAnalysisPromptDetailReqDto apr);

	void updateAnalysisPromptDetailInst(KprAnalysisPromptDetailReqDto apr);

	void updateAnalysisPromptAllSequenceInst(KprAnalysisPromptDetailReqDto apr);

	void deleteAnalysisPromptDetailInst(KprAnalysisPromptDetailReqDto apr);

	void updateAnalysisPromptSequenceInst(KprAnalysisPromptDetailReqDto apr);

	List<KprAnalysisPromptDetailResDto> selectAnalysisDatePromptList(KprAnalysisPromptDetailReqDto apr);
	
	List<KprAnalysisPromptDetailResDto> selectAnalysisPromptCheck(KprAnalysisPromptDetailReqDto param);


}
