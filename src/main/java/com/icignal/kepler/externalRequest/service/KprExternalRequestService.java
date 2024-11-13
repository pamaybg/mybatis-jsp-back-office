package com.icignal.kepler.externalRequest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.util.LogUtil;
import com.icignal.kepler.externalRequest.dto.response.KprExternalRequestDashboardResDto;
import com.icignal.kepler.externalRequest.mapper.KprExternalRequestMapper;


/*
 * 1. 클래스명	: KPRExternalRequestService
 * 2. 파일명	: KPRExternalRequestService.java
 * 3. 패키지명	: com.icignal.kepler.externalRequest.service
 * 4. 작성자명	: KioLee
 * 5. 작성일자	: 2016. 10. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service(value = "KprExternalRequestService")
public class KprExternalRequestService {

	
	@Autowired
	private KprExternalRequestMapper kprExternalRequestMapper;

	 /*
	  * 1. 메소드명: getExternalAnalysisDetail
	  * 2. 클래스명: KPRExternalRequestService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 10. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		외부 요청 분석 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param paramValue
	 *   @return	
	 */
	public KprExternalRequestDashboardResDto getExternalAnalysisDetail(String paramValue) {
		LogUtil.param(KprExternalRequestService.class, paramValue);

		return kprExternalRequestMapper.selectExternalAnalysisDetail(paramValue);
	}

	 /*
	  * 1. 메소드명: getExternalDashboardDetail
	  * 2. 클래스명: KPRExternalRequestService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 10. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		외부 요청 대시보드 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param paramValue
	 *   @return	
	 */
	public KprExternalRequestDashboardResDto getExternalDashboardDetail(String paramValue) {
		LogUtil.param(KprExternalRequestService.class, paramValue);

		return kprExternalRequestMapper.selectExternalDashboardDetail(paramValue);
	}
}
