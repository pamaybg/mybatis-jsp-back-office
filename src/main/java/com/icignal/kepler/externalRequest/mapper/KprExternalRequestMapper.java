package com.icignal.kepler.externalRequest.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.externalRequest.dto.response.KprExternalRequestDashboardResDto;


/*
 * 1. 클래스명	: KPRExternalRequestMapper
 * 2. 파일명	: KPRExternalRequestMapper.java
 * 3. 패키지명	: com.icignal.kepler.externalRequest.mapper
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
public interface KprExternalRequestMapper {

	KprExternalRequestDashboardResDto selectExternalAnalysisDetail(String paramValue);

	KprExternalRequestDashboardResDto selectExternalDashboardDetail(String paramValue);

}
