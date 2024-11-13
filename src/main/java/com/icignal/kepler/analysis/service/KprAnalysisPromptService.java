package com.icignal.kepler.analysis.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.dto.request.KprAnalysisPromptDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisPromptDetailResDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;

/*
 * 1. 클래스명	: KPRAnalysisPromptService
 * 2. 파일명	: KPRAnalysisPromptService.java
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
@Service("KprAnalysisPromptService")
public class KprAnalysisPromptService extends KprAnalysisCommonSerivce{
	
	
	 /*
	  * 1. 메소드명: getAnalysisPromptList
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public List<KprAnalysisPromptDetailResDto> getAnalysisPromptList(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("arp");
		return this.kprAnalysisPromptMapper.selectAnalysisPromptListInst(apr);
	}

	 /*
	  * 1. 메소드명: getAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public KprAnalysisPromptDetailResDto getAnalysisPromptDetail(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("arp");
		KprAnalysisPromptDetailResDto rstValue = this.kprAnalysisPromptMapper.selectAnalysisPromptDetailInst(apr);
		String promptTypeCode = rstValue.getPromptTypeCode();
		rstValue.setSuccess(false);

		if (!(KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode))) {
			KprCommonDateFunctionReqDto dateFunctionReqDto = new KprCommonDateFunctionReqDto();
			dateFunctionReqDto.setDatabaseType(CommonUtil.getInstance().getDatabaseType());
			
			String promptValue = rstValue.getPromptValue();
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
					rstValue.setPromptValue1(dateCodeResDto.getCodeName());
					rstValue.setPromptValue1Text(dateCodeResDto.getMarkName());
				} else {
					rstValue.setPromptValue1(promptValue1);
					rstValue.setPromptValue1Text(promptValue1);
				}
			}

			if (ObjectUtil.isNotEmpty(promptValue2)) {
				dateFunctionReqDto.setCodeName(promptValue2);
				KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

				if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
					rstValue.setPromptValue2(dateCodeResDto.getCodeName());
					rstValue.setPromptValue2Text(dateCodeResDto.getMarkName());
				} else {
					rstValue.setPromptValue2(promptValue2);
					rstValue.setPromptValue2Text(promptValue2);
				}
			}
			
			if (ObjectUtil.isNotEmpty(promptValue3)) {
				dateFunctionReqDto.setCodeName(promptValue3);
				KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

				if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
					rstValue.setPromptValue3(dateCodeResDto.getCodeName());
					rstValue.setPromptValue3Text(dateCodeResDto.getMarkName());
				} else {
					rstValue.setPromptValue3(promptValue3);
					rstValue.setPromptValue3Text(promptValue3);
				}
			}
		}
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: addAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	@Transactional
	public StatusResDto addAnalysisPromptDetail(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");
//		this.startTransaction();
		StatusResDto resDto = new StatusResDto();

		List<KprAnalysisPromptDetailReqDto> promptList = apr.getPromptList();
		if (ObjectUtil.isNotEmpty(promptList)) {
			for (KprAnalysisPromptDetailReqDto promptReqDto : promptList) {
				promptReqDto.setEmpId(apr.getEmpId());
				this.kprAnalysisPromptMapper.insertAnalysisPromptDetailInst(promptReqDto);
			}
		}

//		this.commitTransaction();
//		this.endTransaction();

		resDto.setSuccess(true);
		return resDto;
	}
	
	 /*
	  * 1. 메소드명: editAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param apr
	 *   @return	
	 */
	@Transactional
	public StatusResDto editAnalysisPromptDetail(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		String promptTypeCode = apr.getPromptTypeCode();
		StringBuilder promptValue = new StringBuilder();

		if (!(KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode))) {
			String promptValue1 = apr.getPromptValue1();
			String promptValue2 = apr.getPromptValue2();
			String promptValue3 = apr.getPromptValue3();
			
			if (ObjectUtil.isNotEmpty(promptValue3)) {
				promptValue.append("'" + promptValue3 + "'");
			}else {
				if (ObjectUtil.isNotEmpty(promptValue1)) {
					promptValue.append("'" + promptValue1 + "'");
				}
	
				if (ObjectUtil.isNotEmpty(promptValue2)) {
					promptValue.append(" AND ");
					promptValue.append("'" + promptValue2 + "'");
				}
			}

			apr.setPromptValue(promptValue.toString());
		}
		this.kprAnalysisPromptMapper.updateAnalysisPromptDetailInst(apr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisPromptAllSequence
	  * 2. 클래스명: KPRAnalysisPromptService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto editAnalysisPromptAllSequence(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");
		
		StatusResDto rstValue = new StatusResDto();
		rstValue.setSuccess(false);
		kprAnalysisPromptMapper.updateAnalysisPromptAllSequenceInst(apr);		
		rstValue.setSuccess(true);
		return rstValue;
	}
	
	 /*
	  * 1. 메소드명: removeAnalysisPromptDetail
	  * 2. 클래스명: KPRAnalysisPromptService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param apr
	 *   @return	
	 */
	@Transactional
	public StatusResDto removeAnalysisPromptDetail(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");
		KprAnalysisPromptDetailResDto promptDetail = this.kprAnalysisPromptMapper.selectAnalysisPromptDetailInst(apr);
		apr.setSeq(promptDetail.getSeq());

		StatusResDto rstValue = new StatusResDto();
//		this.startTransaction();

		this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailInst(apr);
		this.kprAnalysisPromptMapper.updateAnalysisPromptSequenceInst(apr);

//		this.commitTransaction();
//		this.endTransaction();

		rstValue.setSuccess(true);
		return rstValue;
	}
	
	
	 /*
	  * 1. 메소드명: selectAnalysisDatePromptList
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public List<KprAnalysisPromptDetailResDto> selectAnalysisDatePromptList(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		return this.kprAnalysisPromptMapper.selectAnalysisDatePromptList(apr);
	}


	 /*
	  * 1. 메소드명: selectAnalysisPromptIdListInst
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public List<String> selectAnalysisPromptIdListInst(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		return this.kprAnalysisPromptMapper.selectAnalysisPromptIdListInst(apr);
	}

	 /*
	  * 1. 메소드명: selectAnalysisPromptIdCheckMaster
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public Integer selectAnalysisPromptIdCheckMaster(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		return this.kprAnalysisPromptMapper.selectAnalysisPromptIdCheckMaster(apr);
	}

	 /*
	  * 1. 메소드명: selectAnalysisPromptCount
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public Integer selectAnalysisPromptCount(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		return this.kprAnalysisPromptMapper.selectAnalysisPromptCount(apr);
	}

	 /*
	  * 1. 메소드명: insertAnalysisPromptDetailMaster
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto insertAnalysisPromptDetailMaster(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMaster(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}


	 /*
	  * 1. 메소드명: insertAnalysisPromptDetailMasterToInst
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto insertAnalysisPromptDetailMasterToInst(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMasterToInst(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: insertAnalysisPromptDetailInstToMaster
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto insertAnalysisPromptDetailInstToMaster(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailInstToMaster(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: insertAnalysisPromptDetailCopy
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto insertAnalysisPromptDetailCopy(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailCopy(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}


	 /*
	  * 1. 메소드명: updateAnalysisPromptDetailInstToMaster
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto updateAnalysisPromptDetailInstToMaster(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.updateAnalysisPromptDetailInstToMaster(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}


	 /*
	  * 1. 메소드명: deleteAnalysisPromptDetailMaster
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto deleteAnalysisPromptDetailMaster(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: deleteAnalysisPromptListInst
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public StatusResDto deleteAnalysisPromptListInst(KprAnalysisPromptDetailReqDto apr) {
		LogUtil.param(KprAnalysisService.class, apr);
		apr.setSVCAlias("");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(apr);
		rstValue.setSuccess(true);

		return rstValue;
	}
	
	 /*
	  * 1. 메소드명: selectAnalysisDatePromptList
	  * 2. 클래스명: KPRAnalysisPromptService
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
	 *   @param apr
	 *   @return	
	 */
	public List<KprAnalysisPromptDetailResDto> selectAnalysisPromptCheck(KprAnalysisPromptDetailReqDto param) {
		LogUtil.param(KprAnalysisService.class, param);
		param.setSVCAlias("");

		return kprAnalysisPromptMapper.selectAnalysisPromptCheck(param);
	}

}