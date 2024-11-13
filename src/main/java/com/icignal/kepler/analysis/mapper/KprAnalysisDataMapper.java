package com.icignal.kepler.analysis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisDataReqDto;


/*
 * 1. 클래스명	: KPRAnalysisDataMapper
 * 2. 파일명	: KPRAnalysisDataMapper.java
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
public interface KprAnalysisDataMapper {

	Integer selectAnalysisDateKeyFlagCheck(KprAnalysisDataReqDto adr);

	Integer selectAnalysisDateFilterCheck(KprAnalysisDataReqDto adr);

}
