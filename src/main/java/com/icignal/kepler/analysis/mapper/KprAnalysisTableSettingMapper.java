package com.icignal.kepler.analysis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisTableDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisTableDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisTableSettingMapper
 * 2. 파일명	: KPRAnalysisTableSettingMapper.java
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
public interface KprAnalysisTableSettingMapper {

	KprAnalysisTableDetailResDto selectAnalysisTableDetail(KprAnalysisTableDetailReqDto reqDto);

	void updateAnalysisTableDetail(KprAnalysisTableDetailReqDto reqDto);

}
