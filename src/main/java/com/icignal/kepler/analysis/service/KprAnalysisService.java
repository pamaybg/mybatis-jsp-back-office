package com.icignal.kepler.analysis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.component.Messages;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonGridReqDto;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.common.dto.response.KprAnalysisCommonResDto;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisColumnDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisExternalReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisFilterDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisPromptDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDatabaseInfoResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisExternalResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisListResDto;
import com.icignal.kepler.common.dto.request.KprAnalysisModifyCheckReqDto;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;


/*
 * 1. 클래스명	: KPRAnalysisService
 * 2. 파일명	: KPRAnalysisService.java
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
@Service("KprAnalysisService")
public class KprAnalysisService extends KprAnalysisCommonSerivce{
	
	 /*
	  * 1. 메소드명: getAnalysisList
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param alr
	 *   @return	
	 */
	public GridPagingResDto<KprAnalysisListResDto> getAnalysisList(KprAnalysisListReqDto alr) {
		LogUtil.param(KprAnalysisService.class, alr);
		alr.setSVCAlias("");

		return new GridPagingResHelper<KprAnalysisListResDto>().newGridPagingResDto(
				alr.init(CommonUtil.getInstance().getDBType()), this.kprAnalysisMapper.selectAnalysisList(alr));
	}

	 /*
	  * 1. 메소드명: getAnalysisDetail
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	@Transactional
	public KprAnalysisDetailResDto getAnalysisDetail(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		KprAnalysisModifyCheckReqDto modifyReqDto = new KprAnalysisModifyCheckReqDto();
		modifyReqDto.setSystemColumn(adr.getSystemColumn());
		modifyReqDto.setAnalysisId(adr.getAnalysisId());
		Integer modifyResDto = this.kprCommonMapper.selectAnalysisModifyCheck(modifyReqDto);

		KprAnalysisDetailResDto rstValue = new KprAnalysisDetailResDto();

		if (modifyResDto.intValue() == 0) {
//			this.startTransaction();

			this.kprAnalysisMapper.insertAnalysisDetailMasterToInst(adr);

			KprAnalysisColumnDetailReqDto columnReqDto = new KprAnalysisColumnDetailReqDto();
			columnReqDto.setSystemColumn(adr.getSystemColumn());
			columnReqDto.setAnalysisId(adr.getAnalysisId());
			this.kprAnalysisColumnMapper.insertAnalysisColumnDetailMasterToInst(columnReqDto);

			KprAnalysisPromptDetailReqDto promptReqDto = new KprAnalysisPromptDetailReqDto();
			promptReqDto.setSystemColumn(adr.getSystemColumn());
			promptReqDto.setAnalysisId(adr.getAnalysisId());
			this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMasterToInst(promptReqDto);

			KprAnalysisFilterDetailReqDto filterReqDto = new KprAnalysisFilterDetailReqDto();
			filterReqDto.setSystemColumn(adr.getSystemColumn());
			filterReqDto.setAnalysisId(adr.getAnalysisId());
			this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMasterToInst(filterReqDto);

			KprAnalysisChartLabelDetailReqDto chartLabelReqDto = new KprAnalysisChartLabelDetailReqDto();
			chartLabelReqDto.setSystemColumn(adr.getSystemColumn());
			chartLabelReqDto.setAnalysisId(adr.getAnalysisId());
			this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailMasterToInst(chartLabelReqDto);

//			this.commitTransaction();
//			this.endTransaction();
		}
		adr.setSVCAlias("arm");
		rstValue = this.kprAnalysisMapper.selectAnalysisDetailInst(adr);

		KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
		filterDetailReqDto.setSystemColumn(adr.getSystemColumn());
		filterDetailReqDto.setAnalysisId(adr.getAnalysisId());
		filterDetailReqDto.setAnalysisMasterFlag(adr.getAnalysisMasterFlag());
		Integer filterCount = this.kprAnalysisFilterMapper.selectAnalysisFilterCount(filterDetailReqDto);
		rstValue.setFilterCount(filterCount);
		rstValue.setSuccess(true);
		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisName
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public KprAnalysisDetailResDto getAnalysisName(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		return this.kprAnalysisMapper.selectAnalysisName(adr);
	}

	 /*
	  * 1. 메소드명: addAnalysisDetail
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public StatusResDto addAnalysisDetail(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		kprAnalysisMapper.insertAnalysisDetailInst(adr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailSave
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public StatusResDto editAnalysisDetailSave(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		StatusResDto rstValue = new StatusResDto();

		Integer analysisNameCheckFlag = this.kprAnalysisMapper.selectAnalysisNameCheckMaster(adr);

		if (analysisNameCheckFlag.intValue() == 0) {
			this.kprAnalysisMapper.updateAnalysisDetailInst(adr);

			String dashboardId = adr.getDashboardId();
			if (!(ObjectUtil.isNotEmpty(dashboardId))) {
				adr.setSVCAlias("");
				Integer analysisIdCheckFlag = this.kprAnalysisMapper.selectAnalysisIdCheckMaster(adr);
				if (analysisIdCheckFlag.intValue() == 0)
					this.kprAnalysisMapper.insertAnalysisDetailInstToMaster(adr);
				else {
					this.kprAnalysisMapper.updateAnalysisDetailInstToMaster(adr);
				}

				KprAnalysisColumnDetailReqDto columnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				columnDetailReqDto.setSystemColumn(adr.getSystemColumn());
				columnDetailReqDto.setEmpId(adr.getEmpId());
				columnDetailReqDto.setAnalysisId(adr.getAnalysisId());

				List<String> columnIdList = this.kprAnalysisColumnMapper.selectAnalysisColumnIdListInst(columnDetailReqDto);
				columnDetailReqDto.setColumnIdList(columnIdList);
				if (ObjectUtil.isNotEmpty(columnIdList)) {
					for (String columnId : columnIdList) {
						KprAnalysisColumnDetailReqDto tempColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
						tempColumnDetailReqDto.setSystemColumn(adr.getSystemColumn());
						tempColumnDetailReqDto.setEmpId(adr.getEmpId());
						tempColumnDetailReqDto.setColumnId(columnId);

						int analysisColumnIdCheckFlag = this.kprAnalysisColumnMapper.selectAnalysisColumnIdCheckMaster(tempColumnDetailReqDto);

						if (analysisColumnIdCheckFlag == 0) {
							this.kprAnalysisColumnMapper.insertAnalysisColumnDetailInstToMaster(tempColumnDetailReqDto);
						} else {
							this.kprAnalysisColumnMapper.updateAnalysisColumnDetailInstToMaster(tempColumnDetailReqDto);
						}
					}
				}

				this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailMaster(columnDetailReqDto);

				KprAnalysisPromptDetailReqDto promptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				promptDetailReqDto.setSystemColumn(adr.getSystemColumn());
				promptDetailReqDto.setEmpId(adr.getEmpId());
				promptDetailReqDto.setAnalysisId(adr.getAnalysisId());

				List<String> promptIdList = this.kprAnalysisPromptMapper.selectAnalysisPromptIdListInst(promptDetailReqDto);
				promptDetailReqDto.setPromptIdList(promptIdList);
				if (ObjectUtil.isNotEmpty(promptIdList)) {
					for (String promptId : promptIdList) {
						KprAnalysisPromptDetailReqDto tempPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
						tempPromptDetailReqDto.setSystemColumn(adr.getSystemColumn());
						tempPromptDetailReqDto.setEmpId(adr.getEmpId());
						tempPromptDetailReqDto.setPromptId(promptId);

						int analysisPromptIdCheckFlag = this.kprAnalysisPromptMapper.selectAnalysisPromptIdCheckMaster(tempPromptDetailReqDto);

						if (analysisPromptIdCheckFlag == 0)
							this.kprAnalysisPromptMapper.insertAnalysisPromptDetailInstToMaster(tempPromptDetailReqDto);
						else {
							this.kprAnalysisPromptMapper.updateAnalysisPromptDetailInstToMaster(tempPromptDetailReqDto);
						}
					}
				}

				this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(promptDetailReqDto);

				KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				filterDetailReqDto.setSystemColumn(adr.getSystemColumn());
				filterDetailReqDto.setEmpId(adr.getEmpId());
				filterDetailReqDto.setAnalysisId(adr.getAnalysisId());

				List<String> filterIdList = this.kprAnalysisFilterMapper.selectAnalysisFilterIdListInst(filterDetailReqDto);
				filterDetailReqDto.setFilterIdList(filterIdList);
				if (ObjectUtil.isNotEmpty(filterIdList)) {
					for (String filterId : filterIdList) {
						KprAnalysisFilterDetailReqDto tempFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
						tempFilterDetailReqDto.setSystemColumn(adr.getSystemColumn());
						tempFilterDetailReqDto.setEmpId(adr.getEmpId());
						tempFilterDetailReqDto.setFilterId(filterId);
						tempFilterDetailReqDto.setAnalysisMasterFlag(adr.getAnalysisMasterFlag());

						int analysisFilterIdCheckFlag = this.kprAnalysisFilterMapper.selectAnalysisFilterCount(tempFilterDetailReqDto);

						if (analysisFilterIdCheckFlag == 0)
							this.kprAnalysisFilterMapper.insertAnalysisFilterDetailInstToMaster(tempFilterDetailReqDto);
						else {
							this.kprAnalysisFilterMapper.updateAnalysisFilterDetailInstToMaster(tempFilterDetailReqDto);
						}
					}
				}

				this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(filterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setSystemColumn(adr.getSystemColumn());
				chartLabelDetailReqDto.setCreateBy(adr.getEmpId());
				chartLabelDetailReqDto.setModifyBy(adr.getEmpId());
				chartLabelDetailReqDto.setAnalysisId(adr.getAnalysisId());

				List<String> chartLabelDetailIdList = this.kprAnalysisChartSettingMapper.selectAnalysisChartLabelIdListInst(chartLabelDetailReqDto);
				chartLabelDetailReqDto.setFontIdList(chartLabelDetailIdList);
				if (ObjectUtil.isNotEmpty(chartLabelDetailIdList)) {
					for (String chartLabelDetailId : chartLabelDetailIdList) {
						
						KprAnalysisChartLabelDetailReqDto tempChartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
						
						tempChartLabelDetailReqDto.setSystemColumn(adr.getSystemColumn());
						tempChartLabelDetailReqDto.setCreateBy(adr.getEmpId());
						tempChartLabelDetailReqDto.setModifyBy(adr.getEmpId());
						tempChartLabelDetailReqDto.setFontId(chartLabelDetailId);
						tempChartLabelDetailReqDto.setAnalysisMasterFlag(adr.getAnalysisMasterFlag());

						int analysisChartLabelIdCheckFlag = this.kprAnalysisChartSettingMapper.selectAnalysisColumnIdCheckMaster(tempChartLabelDetailReqDto);

						if (analysisChartLabelIdCheckFlag == 0) {
							this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailInstToMaster(tempChartLabelDetailReqDto);
						} else {
							this.kprAnalysisChartSettingMapper.updateAnalysisChartLabelDetailInstToMaster(tempChartLabelDetailReqDto);
						}
					}
				}

				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
				this.kprAnalysisMapper.deleteAnalysisDetailInst(adr);
				this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(columnDetailReqDto);
				this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(promptDetailReqDto);
				this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(filterDetailReqDto);
				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);
			}

			rstValue.setSuccess(true);
		} else {
			rstValue.setSuccess(false);
			rstValue.setMessage(Messages.getMessage("M01642", adr.getLang()));
		}

		return rstValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailSaveAs
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	@Transactional
	public StatusResDto editAnalysisDetailSaveAs(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);

		StatusResDto rstValue = new StatusResDto();
		adr.setSVCAlias("");
		Integer analysisNameCheckFlag = this.kprAnalysisMapper.selectAnalysisNameCheckMaster(adr);

		if (analysisNameCheckFlag.intValue() == 0) {
//			this.startTransaction();

			String dashboardId = adr.getDashboardId();
			if (!(ObjectUtil.isNotEmpty(dashboardId))) {
				String analysisId_New = CommonUtil.newRid();
				adr.setAnalysisId_New(analysisId_New);
				this.kprAnalysisMapper.insertAnalysisDetailMaster(adr);

				KprAnalysisColumnDetailReqDto columnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				columnDetailReqDto.setSystemColumn(adr.getSystemColumn());
				columnDetailReqDto.setEmpId(adr.getEmpId());
				columnDetailReqDto.setAnalysisId(adr.getAnalysisId());
				columnDetailReqDto.setAnalysisId_New(analysisId_New);

				this.kprAnalysisColumnMapper.insertAnalysisColumnDetailMaster(columnDetailReqDto);

				KprAnalysisPromptDetailReqDto promptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				promptDetailReqDto.setSystemColumn(adr.getSystemColumn());
				promptDetailReqDto.setEmpId(adr.getEmpId());
				promptDetailReqDto.setAnalysisId(adr.getAnalysisId());
				promptDetailReqDto.setAnalysisId_New(analysisId_New);

				this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMaster(promptDetailReqDto);

				KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				filterDetailReqDto.setSystemColumn(adr.getSystemColumn());
				filterDetailReqDto.setEmpId(adr.getEmpId());
				filterDetailReqDto.setAnalysisId(adr.getAnalysisId());
				filterDetailReqDto.setAnalysisId_New(analysisId_New);

				this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMaster(filterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setCreateBy(adr.getEmpId());
				chartLabelDetailReqDto.setModifyBy(adr.getEmpId());
				chartLabelDetailReqDto.setAnalysisId(adr.getAnalysisId());
				chartLabelDetailReqDto.setAnalysisId_New(analysisId_New);

				this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);

				this.kprAnalysisMapper.deleteAnalysisDetailInst(adr);
				this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(columnDetailReqDto);
				this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(promptDetailReqDto);
				this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(filterDetailReqDto);
				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);
			}

//			this.commitTransaction();
//			this.endTransaction();
			rstValue.setSuccess(true);
		} else {
			rstValue.setSuccess(false);
			rstValue.setMessage(Messages.getMessage("M01642", adr.getLang()));
		}

		return rstValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailCopy
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	@Transactional
	public KprAnalysisDetailResDto editAnalysisDetailCopy(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		KprAnalysisDetailResDto rstDto = new KprAnalysisDetailResDto();
//		this.startTransaction();

		String analysisId_New = CommonUtil.newRid();
		adr.setAnalysisId_New(analysisId_New);
		this.kprAnalysisMapper.insertAnalysisDetailCopy(adr);

		KprAnalysisColumnDetailReqDto columnDetailReqDto = new KprAnalysisColumnDetailReqDto();
		columnDetailReqDto.setSystemColumn(adr.getSystemColumn());
		columnDetailReqDto.setEmpId(adr.getEmpId());
		columnDetailReqDto.setAnalysisId(adr.getAnalysisId());
		columnDetailReqDto.setAnalysisId_New(analysisId_New);

		this.kprAnalysisColumnMapper.insertAnalysisColumnDetailCopy(columnDetailReqDto);

		KprAnalysisPromptDetailReqDto promptDetailReqDto = new KprAnalysisPromptDetailReqDto();
		promptDetailReqDto.setSystemColumn(adr.getSystemColumn());
		promptDetailReqDto.setEmpId(adr.getEmpId());
		promptDetailReqDto.setAnalysisId(adr.getAnalysisId());
		promptDetailReqDto.setAnalysisId_New(analysisId_New);

		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailCopy(promptDetailReqDto);

		KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
		filterDetailReqDto.setSystemColumn(adr.getSystemColumn());
		filterDetailReqDto.setEmpId(adr.getEmpId());
		filterDetailReqDto.setAnalysisId(adr.getAnalysisId());
		filterDetailReqDto.setAnalysisId_New(analysisId_New);

		this.kprAnalysisFilterMapper.insertAnalysisFilterDetailCopy(filterDetailReqDto);

		KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
		chartLabelDetailReqDto.setCreateBy(adr.getEmpId());
		chartLabelDetailReqDto.setModifyBy(adr.getEmpId());
		chartLabelDetailReqDto.setAnalysisId(adr.getAnalysisId());
		chartLabelDetailReqDto.setAnalysisId_New(analysisId_New);

		this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailCopy(chartLabelDetailReqDto);

//		this.commitTransaction();
//		this.endTransaction();

		rstDto.setSuccess(true);
		rstDto.setAnalysisId(analysisId_New);
		return rstDto;
	}

	 /*
	  * 1. 메소드명: editAnalysisLogicalCompId
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public StatusResDto editAnalysisLogicalCompId(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisMapper.updateAnalysisLogicalCompIdInst(adr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: resetAnalysisDetail
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	@Transactional
	public StatusResDto resetAnalysisDetail(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		StatusResDto rstValue = new StatusResDto();

//		this.startTransaction();

		this.kprAnalysisMapper.updateAnalysisLogicalCompIdInst(adr);

		KprAnalysisColumnDetailReqDto columnReqDto = new KprAnalysisColumnDetailReqDto();
		columnReqDto.setSystemColumn(adr.getSystemColumn());
		columnReqDto.setAnalysisId(adr.getAnalysisId());
		this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(columnReqDto);

		KprAnalysisPromptDetailReqDto promptReqDto = new KprAnalysisPromptDetailReqDto();
		promptReqDto.setSystemColumn(adr.getSystemColumn());
		promptReqDto.setAnalysisId(adr.getAnalysisId());
		this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(promptReqDto);

		KprAnalysisFilterDetailReqDto filterReqDto = new KprAnalysisFilterDetailReqDto();
		filterReqDto.setSystemColumn(adr.getSystemColumn());
		filterReqDto.setAnalysisId(adr.getAnalysisId());
		this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(filterReqDto);

		KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
		chartLabelDetailReqDto.setCreateBy(adr.getEmpId());
		chartLabelDetailReqDto.setModifyBy(adr.getEmpId());
		chartLabelDetailReqDto.setAnalysisId(adr.getAnalysisId());
		this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);

//		this.commitTransaction();
//		this.endTransaction();

		rstValue.setSuccess(true);
		return rstValue;
	}

	 /*
	  * 1. 메소드명: removeAnalysisDetail
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	@Transactional
	public StatusResDto removeAnalysisDetail(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		StatusResDto rstValue = new StatusResDto();
		adr.setSVCAlias("");

		KprAnalysisColumnDetailReqDto columnDetailReqDto = new KprAnalysisColumnDetailReqDto();
		columnDetailReqDto.setSystemColumn(adr.getSystemColumn());
		columnDetailReqDto.setEmpId(adr.getEmpId());
		columnDetailReqDto.setAnalysisId(adr.getAnalysisId());

		KprAnalysisPromptDetailReqDto promptDetailReqDto = new KprAnalysisPromptDetailReqDto();
		promptDetailReqDto.setSystemColumn(adr.getSystemColumn());
		promptDetailReqDto.setEmpId(adr.getEmpId());
		promptDetailReqDto.setAnalysisId(adr.getAnalysisId());

		KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
		filterDetailReqDto.setSystemColumn(adr.getSystemColumn());
		filterDetailReqDto.setEmpId(adr.getEmpId());
		filterDetailReqDto.setAnalysisId(adr.getAnalysisId());

		KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
		chartLabelDetailReqDto.setCreateBy(adr.getEmpId());
		chartLabelDetailReqDto.setModifyBy(adr.getEmpId());
		chartLabelDetailReqDto.setAnalysisId(adr.getAnalysisId());

		Integer saveAnalysisFlag = this.kprAnalysisMapper.selectAnalysisIdCheckMaster(adr);
		String analysisMasterFlag = adr.getAnalysisMasterFlag();

//		this.startTransaction();

		String dashboardId = adr.getDashboardId();
		if (ObjectUtil.isEmpty(dashboardId)) {
			this.kprAnalysisMapper.deleteAnalysisDetailInst(adr);
			this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(columnDetailReqDto);
			this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(promptDetailReqDto);
			this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(filterDetailReqDto);
			this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);

			if (saveAnalysisFlag.intValue() != 0 && "Y".equals(analysisMasterFlag)) {
				this.kprAnalysisMapper.deleteAnalysisDetailMaster(adr);
				this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailMaster(columnDetailReqDto);
				this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(promptDetailReqDto);
				this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(filterDetailReqDto);
				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
			}
		} else if (saveAnalysisFlag.intValue() != 0) {
			this.kprAnalysisMapper.deleteAnalysisDetailInst(adr);
			this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(columnDetailReqDto);
			this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(promptDetailReqDto);
			this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(filterDetailReqDto);
			this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);

			this.kprAnalysisMapper.insertAnalysisDetailMasterToInst(adr);
			this.kprAnalysisColumnMapper.insertAnalysisColumnDetailMasterToInst(columnDetailReqDto);
			this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMasterToInst(promptDetailReqDto);
			this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMasterToInst(filterDetailReqDto);
			this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailMasterToInst(chartLabelDetailReqDto);
		}

//		this.commitTransaction();
//		this.endTransaction();

		rstValue.setSuccess(true);
		return rstValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnGroupFlag
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public StatusResDto editAnalysisColumnGroupFlag(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisMapper.updateAnalysisColumnGroupFlagInst(adr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisChartTypeChange
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param adr
	 *   @return	
	 */
	public StatusResDto editAnalysisChartTypeChange(KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisService.class, adr);
		adr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisMapper.updateAnalysisChartTypeChangeInst(adr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnDetail
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param agc
	 *   @return	
	 */
	public List<KprAnalysisAtribGroupColumnDetailResDto> getAnalysisAtribGroupColumnDetail(KprAnalysisCommonReqDto agc) {
		LogUtil.param(KprAnalysisService.class, agc);
		agc.setSVCAlias("");
		return this.kprAnalysisMapper.selectAnalysisAtribGroupColumnDetail(agc);
	}

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnList
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param acr
	 *   @return	
	 */
	public List<KprAnalysisAtribGroupColumnDetailResDto> getAnalysisAtribGroupColumnList(KprAnalysisCommonReqDto acr) {
		LogUtil.param(KprAnalysisService.class, acr);
		acr.setSVCAlias("lcm");
		return this.kprAnalysisMapper.selectAnalysisAtribGroupColumnList(acr);
	}

	 /*
	  * 1. 메소드명: getAnalysisExtenalRequestBase
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param aer
	 *   @return	
	 */
	public KprAnalysisExternalResDto getAnalysisExtenalRequestBase(KprAnalysisExternalReqDto aer) {
		LogUtil.param(this.getClass(), aer);

		String langTypeCode = aer.getLangTypeCode();
		KprCommonCodeReqDto langCodeReqDto = new KprCommonCodeReqDto();
		langCodeReqDto.setGroupCode(langTypeCode);
		langCodeReqDto.setEnableNA(Boolean.FALSE);
		List<KprCommonCodeResDto> langTypeCodeList = this.kprCommonMapper.getCommCodeList(langCodeReqDto);

		KprAnalysisExternalResDto rstValue = new KprAnalysisExternalResDto();
		rstValue.setLangTypeCodeList(langTypeCodeList);

		String analysisType = aer.getAnalysisType();
		if (ObjectUtil.isNotEmpty(analysisType)) {
			String analysisEmbedTypeCode = aer.getAnalysisEmbedTypeCode();

			KprCommonCodeReqDto analysisCodeReqDto = new KprCommonCodeReqDto();
			analysisCodeReqDto.setSystemColumn(aer.getSystemColumn());
			analysisCodeReqDto.setGroupCode(analysisEmbedTypeCode);
			List<KprCommonCodeResDto> analysisEmbedTypeCodeList = this.kprCommonMapper.getCommCodeList(analysisCodeReqDto);
			rstValue.setAnalysisEmbedTypeCodeList(analysisEmbedTypeCodeList);
		}

		rstValue.setSuccess(true);
		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnValueList
	  * 2. 클래스명: KPRAnalysisService
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
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<Object> getAnalysisAtribGroupColumnValueList(KprAnalysisCommonGridReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adi");
		KprAnalysisCommonReqDto valueDetailReqDto = new KprAnalysisCommonReqDto();
		valueDetailReqDto.setAtribGroupColumnId(reqDto.getAtribGroupColumnId());
		KprAnalysisCommonResDto valueDetail = this.kprAnalysisMapper.selectAnalysisAtribGroupColumnValueDetail(valueDetailReqDto);

		KprAnalysisCommonReqDto databaseReqDto = new KprAnalysisCommonReqDto();
		databaseReqDto.setSystemColumn(reqDto.getSystemColumn());
		databaseReqDto.setAtribGroupColumnId(reqDto.getAtribGroupColumnId());
		KprAnalysisDatabaseInfoResDto databaseResDto = this.kprAnalysisMapper.selectAnalysisDatabaseInfo(databaseReqDto);

		
		if(ObjectUtil.isNotEmpty(databaseResDto.getSecretNm())) {
				
		//	BeansUtil.getAWSCredentials()
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(databaseResDto.getSecretNm());					
				
			//	dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
				databaseResDto.setConnectUrl(map.get("url").toString());
				databaseResDto.setConnectId(map.get("username").toString());
				databaseResDto.setConnectPw(map.get("password").toString());
				databaseResDto.setConnectIp(map.get("ip").toString());
				databaseResDto.setConnectPort(map.get("port").toString());

		}
		
		
		MKTDBInfoDTO databaseInfo = new MKTDBInfoDTO();
		
		
		databaseInfo.setDriverClassName(databaseResDto.getConnectDatabaseClass());
		databaseInfo.setConIp(databaseResDto.getConnectIp());
		databaseInfo.setConPort(databaseResDto.getConnectPort());
		databaseInfo.setUserName(databaseResDto.getConnectId());
		//databaseInfo.setPassword(this.encrypor.decrypt(databaseResDto.getConnectPw()));
		databaseInfo.setPassword(databaseResDto.getConnectPw());
		databaseInfo.setUrl(databaseResDto.getConnectUrl());
		databaseInfo.setConDbType(databaseResDto.getConnectDatabaseType());

		String groupFuncTypeCode = reqDto.getGroupFuncTypeCode();
		StringBuilder valueSQL = new StringBuilder();
		String selectSQL = "";
		String groupBySQL = "";
		String orderBySQL = "";
		if (ObjectUtil.isNotEmpty(groupFuncTypeCode)) {
			selectSQL = KprAnalysisConstants.convertGroupFunction(groupFuncTypeCode, valueDetail.getColumnName()) + " as \"colValue\"\n";

			KprAnalysisColumnDetailReqDto columnDimensionReqDto = new KprAnalysisColumnDetailReqDto();
			columnDimensionReqDto.setAnalysisId(reqDto.getAnalysisId());
			columnDimensionReqDto.setAnalysisMasterFlag("N");
			columnDimensionReqDto.setColumnTypeCode(KprAnalysisConstants.COL_TYPE_CD.DIMENSION.name());
			List<KprAnalysisColumnDetailResDto> columnDimensionResList = this.kprAnalysisColumnMapper.selectAnalysisColumnList(columnDimensionReqDto);


			boolean commaFlag = false;
			for (KprAnalysisColumnDetailResDto columnDimensionResDto : columnDimensionResList) {
				if (commaFlag) {
					groupBySQL = groupBySQL + ", ";
					orderBySQL = orderBySQL + ", ";
				} else {
					commaFlag = true;
				}

				selectSQL = selectSQL + ", " + columnDimensionResDto.getTableColumnAlias() + " as \"" + columnDimensionResDto.getColumnAlias() + "\"\n";
				groupBySQL = groupBySQL + columnDimensionResDto.getTableColumnAlias() + "\n";
				orderBySQL = orderBySQL + columnDimensionResDto.getTableColumnAlias() + "\n";
			}
		} else {
			selectSQL = valueDetail.getColumnName() + " as \"colValue\"";
			groupBySQL = valueDetail.getColumnName();
			orderBySQL = valueDetail.getColumnName();
		}

		valueSQL.append("select " + selectSQL + "\n")
			    .append("  " + valueDetail.getLogicalCompSql() + "\n")
			    .append(" group by " + groupBySQL + "\n")
			    .append(" order by " + orderBySQL + "\n");

		if (!reqDto.getPagingFlag()) {
			KprAnalysisCommonResDto resDto = new KprAnalysisCommonResDto();
			resDto.setSuccess(true);
			resDto.setRows(this.mktCallQuery.callSelectForList("KPRAnalysis.selectAnalysisAtribGroupColumnValueList", valueSQL.toString(), new ArrayList<String>(), databaseInfo, String.class));
			return resDto;
		} else {
			return this.mktCallQuery.callSelectForGridList("KPRAnalysis.selectAnalysisAtribGroupColumnValueList", valueSQL.toString(), new ArrayList<String>(), databaseInfo, reqDto);
		}
	}
}