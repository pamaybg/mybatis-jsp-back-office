package com.icignal.kepler.analysis.service;

import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.dto.request.KprAnalysisTableDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisTableDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisTableSettingService
 * 2. 파일명	: KPRAnalysisTableSettingService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 6. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service(value = "KprAnalysisTableSettingService")
public class KprAnalysisTableSettingService extends KprAnalysisCommonSerivce {

	 /*
	  * 1. 메소드명: getAnalysisTableDetail
	  * 2. 클래스명: KPRAnalysisTableSettingService
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public KprAnalysisTableDetailResDto getAnalysisTableDetail(KprAnalysisTableDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprAnalysisTableDetailResDto resDto =kprAnalysisTableSettingMapper.selectAnalysisTableDetail(reqDto);
		resDto.setSuccess(true);
		return resDto;
		
	}

	 /*
	  * 1. 메소드명: editAnalysisChartLabelDetail
	  * 2. 클래스명: kprAnalysisTableSettingMapperService
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editAnalysisChartLabelDetail(KprAnalysisTableDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisTableSettingMapper.updateAnalysisTableDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
}