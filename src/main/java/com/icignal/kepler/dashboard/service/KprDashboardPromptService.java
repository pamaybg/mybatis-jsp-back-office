package com.icignal.kepler.dashboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptCheckReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptCheckResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptResDto;


/*
 * 1. 클래스명	: KPRDashboardPromptService
 * 2. 파일명	: KPRDashboardPromptService.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.service
 * 4. 작성자명	: KioLee
 * 5. 작성일자	: 2017. 12. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprDashboardPromptService")
public class KprDashboardPromptService extends KprAnalysisCommonSerivce {

	
	 /*
	  * 1. 메소드명: getDashboardCommonColumnList
	  * 2. 클래스명: KPRDashboardPromptService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2017. 12. 26.
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
	public List<KprDashboardPromptResDto> getDashboardCommonColumnList(KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return kprDashboardPromptMapper.selectDashboardCommonColumnList(reqDto);
	}

	 /*
	  * 1. 메소드명: getDashboardPromptList
	  * 2. 클래스명: KPRDashboardPromptService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2017. 12. 26.
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
	public List<KprDashboardPromptResDto> getDashboardPromptList(KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		List<KprDashboardPromptResDto> promptList = kprDashboardPromptMapper.selectDashboardPromptInstList(reqDto);
		if (ObjectUtil.isNotEmpty(promptList)) {
			KprCommonDateFunctionReqDto dateFunctionReqDto = new KprCommonDateFunctionReqDto();
			dateFunctionReqDto.setDatabaseType(CommonUtil.getInstance().getDatabaseType());

			for (KprDashboardPromptResDto promptDto : promptList) {
				String promptTypeCode = promptDto.getPromptTypeCode();
				if (!KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode)) {
					String promptValue = promptDto.getPromptValue();
					String[] splitValueList = promptValue.split(" AND ");
	
					String promptValue1 = null;
					String promptValue2 = null;
					String promptValue3 = null;
	
					int idx = 0;
					for (String splitValue : splitValueList) {
						
						if(splitValueList.length > 1) {
							
							if (idx == 0) {
								promptValue1 = splitValue.replace("'", "");
								idx++;
							} else {
								promptValue2 = splitValue.replace("'", "");
							}
							
						}else if(splitValueList.length == 1){
							promptValue3 = splitValue.replace("'", "");
						}
					}
					
					if (ObjectUtil.isNotEmpty(promptValue1)) {
						dateFunctionReqDto.setCodeName(promptValue1);
						KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);
	
						if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
							promptDto.setPromptValue1CodeName(dateCodeResDto.getCodeName());
							promptDto.setPromptValue1MarkName(dateCodeResDto.getMarkName());
						} else {
							promptDto.setPromptValue1CodeName(promptValue1);
							promptDto.setPromptValue1MarkName(promptValue1);
						}
					}
	
					if (ObjectUtil.isNotEmpty(promptValue2)) {
						dateFunctionReqDto.setCodeName(promptValue2);
						KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);
	
						if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
							promptDto.setPromptValue2CodeName(dateCodeResDto.getCodeName());
							promptDto.setPromptValue2MarkName(dateCodeResDto.getMarkName());
						} else {
							promptDto.setPromptValue2CodeName(promptValue2);
							promptDto.setPromptValue2MarkName(promptValue2);
						}
					}
					if (ObjectUtil.isNotEmpty(promptValue3)) {
						dateFunctionReqDto.setCodeName(promptValue3);
						KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);
	
						if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
							promptDto.setPromptValue3CodeName(dateCodeResDto.getCodeName());
							promptDto.setPromptValue3MarkName(dateCodeResDto.getMarkName());
						} else {
							promptDto.setPromptValue3CodeName(promptValue3);
							promptDto.setPromptValue3MarkName(promptValue3);
						}
					}
				}
			}
		}

		return promptList;
	}

	 /*
	  * 1. 메소드명: saveDashboardPrompt
	  * 2. 클래스명: KPRDashboardPromptService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2017. 12. 26.
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
	public StatusResDto saveDashboardPrompt(KprDashboardPromptReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto resDto = new StatusResDto();

//		this.startTransaction();
		List<KprDashboardPromptReqDto> promptList = reqDto.getPromptList();
		if (ObjectUtil.isNotEmpty(promptList)) {
			for (KprDashboardPromptReqDto promptDto : promptList) {
				promptDto.setSystemColumn(reqDto.getSystemColumn());
				promptDto.setDashboardId(reqDto.getDashboardId());

				String promptTypeCode = promptDto.getPromptTypeCode();
				StringBuilder promptValue = new StringBuilder();

				if (!KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode)) {
					String promptValue1CodeName = promptDto.getPromptValue1CodeName();
					String promptValue2CodeName = promptDto.getPromptValue2CodeName();
					String promptValue3CodeName = promptDto.getPromptValue3CodeName();


					if (ObjectUtil.isNotEmpty(promptValue1CodeName)) {
						promptValue.append("'" + promptValue1CodeName + "'");
					}

					if (ObjectUtil.isNotEmpty(promptValue2CodeName)) {
						promptValue.append(" AND ");
						promptValue.append("'" + promptValue2CodeName + "'");
					}
					
					if (ObjectUtil.isNotEmpty(promptValue3CodeName)) {
						promptValue.append("'" + promptValue3CodeName + "'");
					}

					promptDto.setPromptValue(promptValue.toString());
				}

				int promptInstIdCnt = this.kprDashboardPromptMapper.selectDashboardPromptInstIdCheck(promptDto);
				if (promptInstIdCnt == 0) {
					this.kprDashboardPromptMapper.insertDashboardPromptInst(promptDto);
				} else {
					this.kprDashboardPromptMapper.updateDashboardPromptInst(promptDto);
				}
			}
		}

		this.kprDashboardPromptMapper.deleteDashboardPromptInst(reqDto);

//		this.commitTransaction();
//		this.endTransaction();

		resDto.setSuccess(true);
		return resDto;
	}
	
	 /*
	  * 1. 메소드명: selectDashBoardPromptCheck
	  * 2. 클래스명: KPRDashboardPromptService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 07. 10.
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
	public List<KprDashboardPromptCheckResDto> selectDashBoardPromptCheck(KprDashboardPromptCheckReqDto param) {
		LogUtil.param(this.getClass(), param);		
		

		return kprDashboardPromptMapper.selectDashBoardPromptCheck(param);
	}
}
