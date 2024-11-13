package com.icignal.kepler.analysis.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisChartLabelDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisChartSettingService
 * 2. 파일명	: KPRAnalysisChartSettingService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprAnalysisChartSettingService")
public class KprAnalysisChartSettingService extends KprAnalysisCommonSerivce  {

	 /*
	  * 1. 메소드명: getAnalysisChartLabelDetail
	  * 2. 클래스명: KPRAnalysisChartSettingService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	public KprAnalysisChartLabelDetailResDto getAnalysisChartLabelDetail(KprAnalysisChartLabelDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisService.class, reqDto);

		KprAnalysisChartLabelDetailResDto resDto = kprAnalysisChartSettingMapper.selectAnalysisChartLabelDetail(reqDto);
		List<KprAnalysisChartLabelDetailResDto> analysisChartLabelFontList = kprAnalysisChartSettingMapper.selectAnalysisChartLabelFontDetailList(reqDto);

		resDto.setChartLabelFontList(analysisChartLabelFontList);
		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: editAnalysisChartLabelDetail
	  * 2. 클래스명: KPRAnalysisChartSettingService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	@Transactional
	public StatusResDto editAnalysisChartLabelDetail(KprAnalysisChartLabelDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisService.class, reqDto);
		StatusResDto resDto = new StatusResDto();

//		this.startTransaction();

		// PIE, DOUGHNUT 일 경우 dataUnitTypeCode 를 leftChartLabelTypeCode 에 넣어준다
		String dataUnitTypeCode = reqDto.getDataUnitTypeCode();
		if (ObjectUtil.isNotEmpty(dataUnitTypeCode)) {
			reqDto.setLeftChartLabelTypeCode(dataUnitTypeCode);
		}

		this.kprAnalysisChartSettingMapper.updateAnalysisChartLabelDetail(reqDto);

		List<KprAnalysisChartLabelDetailReqDto> chartLabelFontList = reqDto.getChartLabelFontList();
		if (ObjectUtil.isNotEmpty(chartLabelFontList)) {
			for (KprAnalysisChartLabelDetailReqDto chartLabelFontDetail : chartLabelFontList) {
				String fontId = chartLabelFontDetail.getFontId();

				chartLabelFontDetail.setAnalysisId(reqDto.getAnalysisId());
				chartLabelFontDetail.setCreateBy(reqDto.getCreateBy());
				chartLabelFontDetail.setModifyBy(reqDto.getModifyBy());

				if (ObjectUtil.isEmpty(fontId)) {
					fontId = CommonUtil.newRid();
					chartLabelFontDetail.setFontId(fontId);

					this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailInst(chartLabelFontDetail);
				} else {
					this.kprAnalysisChartSettingMapper.updateAnalysisChartLabelDetailInst(chartLabelFontDetail);
				}
			}
		} else {
			// 리스트가 없다면, PIE 혹은 DOUGHNUT 임으로..
			this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(reqDto);
		}

//		this.commitTransaction();
//		this.endTransaction();

		resDto.setSuccess(true);
		return resDto;
	}
}