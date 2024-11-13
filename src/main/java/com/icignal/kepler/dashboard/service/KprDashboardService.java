package com.icignal.kepler.dashboard.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.dto.request.KprAnalysisChartLabelDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisColumnDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisFilterDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisPromptDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDetailResDto;
import com.icignal.kepler.common.dto.request.KprAnalysisModifyCheckReqDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardDetailReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPublishDataReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardDetailResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPublishDataResDto;

/*
 * 1. 클래스명	: KPRDashboardService
 * 2. 파일명	: KPRDashboardService.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.service
 * 4. 작성자명	: kj.kang
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		Dashboaard Service
 * </PRE>
 */ 
@Service("KprDashboardService")
public class KprDashboardService extends KprAnalysisCommonSerivce {
	
	
//
//	@Autowired
//	private MKTBase iMKTBase;
//
//	@Autowired
//	private KPRCommonDAO iKPRCommon;

	 /*
	  * 1. 메소드명: getDashboardLayoutList
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public List<KprDashboardDetailResDto> getDashboardLayoutList(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");

		return kprDashboardMapper.selectDashboardLayoutList(reqDto);
	}

	 /*
	  * 1. 메소드명: getDashboardDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public KprDashboardDetailResDto getDashboardDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		KprDashboardDetailResDto resDto = new KprDashboardDetailResDto();
		KprAnalysisModifyCheckReqDto dashboardModifyCheckReqDto = new KprAnalysisModifyCheckReqDto();
		dashboardModifyCheckReqDto.setDashboardId(reqDto.getDashboardId());
		int dashboardFlag = this.kprCommonMapper.selectAnalysisModifyCheck(dashboardModifyCheckReqDto);

		reqDto.setDashboardMasterFlag("Y");
		List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);

//		this.startTransaction();
		if (dashboardFlag == 0) {
			this.kprDashboardMapper.insertDashboardDetailMasterToInst(reqDto);

			KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
			dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
			this.kprDashboardPromptMapper.insertDashboardPromptMasterToInst(dashboardPromptReqDto);

			if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
				for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
					KprAnalysisModifyCheckReqDto analysisModifyCheckReqDto = new KprAnalysisModifyCheckReqDto();
					analysisModifyCheckReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
					int analysisFlag = this.kprCommonMapper.selectAnalysisModifyCheck(analysisModifyCheckReqDto);

					if (analysisFlag == 0) {
						KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
						analysisDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

						this.kprAnalysisMapper.insertAnalysisDetailMasterToInst(analysisDetailReqDto);

						KprAnalysisColumnDetailReqDto columnReqDto = new KprAnalysisColumnDetailReqDto();
						columnReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

						this.kprAnalysisColumnMapper.insertAnalysisColumnDetailMasterToInst(columnReqDto);

						KprAnalysisPromptDetailReqDto promptReqDto = new KprAnalysisPromptDetailReqDto();
						promptReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

						this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMasterToInst(promptReqDto);

						KprAnalysisFilterDetailReqDto filterReqDto = new KprAnalysisFilterDetailReqDto();
						filterReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

						this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMasterToInst(filterReqDto);

						KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
						chartLabelDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

						this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailMasterToInst(chartLabelDetailReqDto);
					}
				}
			}
		}

//		this.commitTransaction();
//		this.endTransaction();

		reqDto.setDashboardMasterFlag("N");
		reqDto.setSVCAlias("");
		dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);
		reqDto.setSVCAlias("adl");
		resDto = this.kprDashboardMapper.selectDashboardDetailInst(reqDto);
		resDto.setAnalysisList(dashboardAnalysisList);
		return resDto;
	}

	 /*
	  * 1. 메소드명: getDashboardNameCheck
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public KprDashboardDetailResDto getDashboardNameCheck(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprDashboardDetailResDto resDto = new KprDashboardDetailResDto();
		reqDto.setSVCAlias("");
		int dashboardNameCheck = kprDashboardMapper.selectDashboardNameCheck(reqDto);
		boolean nameFlag = dashboardNameCheck == 0 ? true : false;

		resDto.setSuccess(true);
		resDto.setNameFlag(nameFlag);
		return resDto;
	}

	 /*
	  * 1. 메소드명: addDashboardDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public StatusResDto addDashboardDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		kprDashboardMapper.insertDashboardDetailInst(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editDashboardDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public StatusResDto editDashboardDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		kprDashboardMapper.updateDashboardDetailInst(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editDashboardDetailSave
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public KprDashboardDetailResDto editDashboardDetailSave(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprDashboardDetailResDto resDto = new KprDashboardDetailResDto();
		reqDto.setSVCAlias("");
		// inst 에 등록된 대시보드 정보 업데이트
		kprDashboardMapper.updateDashboardDetailInst(reqDto);

		// inst 정보를 토대로 master 업데이트
		int dashboardIdCheck = this.kprDashboardMapper.selectDashboardIdCheck(reqDto);
		if (dashboardIdCheck == 0) {
			this.kprDashboardMapper.insertDashboardDetailInstToMaster(reqDto);
		} else {
			this.kprDashboardMapper.updateDashboardDetailInstToMaster(reqDto);
		}

		KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
		dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
		List<KprDashboardPromptResDto> dashboardPromptList = this.kprDashboardPromptMapper.selectDashboardPromptInstList(dashboardPromptReqDto);
		List<KprDashboardPromptReqDto> promptReqList = new ArrayList<KprDashboardPromptReqDto>();
		if (ObjectUtil.isNotEmpty(dashboardPromptList)) {

			for (KprDashboardPromptResDto dashboardPromptResDto : dashboardPromptList) {
				KprDashboardPromptReqDto tempDashboardPromptReqDto = new KprDashboardPromptReqDto();
				tempDashboardPromptReqDto.setModifyBy(reqDto.getModifyBy());
				tempDashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
				tempDashboardPromptReqDto.setPromptId(dashboardPromptResDto.getPromptId());

				int dashboardPromptIdCheck = this.kprDashboardPromptMapper.selectDashboardPromptMasterIdCheck(tempDashboardPromptReqDto);
				if (dashboardPromptIdCheck == 0) {
					this.kprDashboardPromptMapper.insertDashboardPromptInstToMaster(tempDashboardPromptReqDto);
				} else {
					this.kprDashboardPromptMapper.updateDashboardPromptInstToMaster(tempDashboardPromptReqDto);
				}

				promptReqList.add(tempDashboardPromptReqDto);
			}
		}

		dashboardPromptReqDto.setPromptList(promptReqList);
		this.kprDashboardPromptMapper.deleteDashboardPromptMaster(dashboardPromptReqDto);

		// inst 에 등록된 분석 정보 select
		reqDto.setDashboardMasterFlag("N");
		List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);

		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				// 분석 마스터 업데이트
				String analysisId = dashboardAnalysisResDto.getAnalysisId();
				KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
				analysisDetailReqDto.setAnalysisId(analysisId);

				int analysisIdCheckFlag = this.kprAnalysisMapper.selectAnalysisIdCheckMaster(analysisDetailReqDto);
				if (analysisIdCheckFlag == 0) {
					this.kprAnalysisMapper.insertAnalysisDetailInstToMaster(analysisDetailReqDto);
				} else {
					this.kprAnalysisMapper.updateAnalysisDetailInstToMaster(analysisDetailReqDto);
				}

				// 분석 컬럼 업데이트
				KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				analysisColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisColumnDetailReqDto.setAnalysisId(analysisId);

				List<String> columnIdList = this.kprAnalysisColumnMapper.selectAnalysisColumnIdListInst(analysisColumnDetailReqDto);
				analysisColumnDetailReqDto.setColumnIdList(columnIdList);

				for (String columnId : columnIdList) {
					KprAnalysisColumnDetailReqDto tempColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
					tempColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
					tempColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
					tempColumnDetailReqDto.setColumnId(columnId);

					int analysisColumnIdCheckFlag = this.kprAnalysisColumnMapper.selectAnalysisColumnIdCheckMaster(tempColumnDetailReqDto);

					if (analysisColumnIdCheckFlag == 0) {
						this.kprAnalysisColumnMapper.insertAnalysisColumnDetailInstToMaster(tempColumnDetailReqDto);
					} else {
						this.kprAnalysisColumnMapper.updateAnalysisColumnDetailInstToMaster(tempColumnDetailReqDto);
					}
				}

				this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailMaster(analysisColumnDetailReqDto);

				// 분석 프롬프트 업데이트
				KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				analysisPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisPromptDetailReqDto.setAnalysisId(analysisId);

				List<String> promptIdList = this.kprAnalysisPromptMapper.selectAnalysisPromptIdListInst(analysisPromptDetailReqDto);
				analysisPromptDetailReqDto.setPromptIdList(promptIdList);

				for (String promptId : promptIdList) {
					KprAnalysisPromptDetailReqDto tempPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
					tempPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
					tempPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
					tempPromptDetailReqDto.setPromptId(promptId);

					int analysisPromptIdCheckFlag = this.kprAnalysisPromptMapper.selectAnalysisPromptIdCheckMaster(tempPromptDetailReqDto);

					if (analysisPromptIdCheckFlag == 0)
						this.kprAnalysisPromptMapper.insertAnalysisPromptDetailInstToMaster(tempPromptDetailReqDto);
					else {
						this.kprAnalysisPromptMapper.updateAnalysisPromptDetailInstToMaster(tempPromptDetailReqDto);
					}
				}

				this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(analysisPromptDetailReqDto);

				// 분석 필터 업데이트
				KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				analysisFilterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisFilterDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisFilterDetailReqDto.setAnalysisId(analysisId);

				List<String> filterIdList = this.kprAnalysisFilterMapper.selectAnalysisFilterIdListInst(analysisFilterDetailReqDto);
				analysisFilterDetailReqDto.setFilterIdList(filterIdList);

				for (String filterId : filterIdList) {
					KprAnalysisFilterDetailReqDto tempFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
					tempFilterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
					tempFilterDetailReqDto.setEmpId(reqDto.getModifyBy());
					tempFilterDetailReqDto.setFilterId(filterId);
					tempFilterDetailReqDto.setAnalysisMasterFlag("Y");

					int analysisFilterIdCheckFlag = this.kprAnalysisFilterMapper.selectAnalysisFilterCount(tempFilterDetailReqDto);

					if (analysisFilterIdCheckFlag == 0)
						this.kprAnalysisFilterMapper.insertAnalysisFilterDetailInstToMaster(tempFilterDetailReqDto);
					else {
						this.kprAnalysisFilterMapper.updateAnalysisFilterDetailInstToMaster(tempFilterDetailReqDto);
					}
				}

				this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(analysisFilterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
				chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
				chartLabelDetailReqDto.setAnalysisId(analysisId);

				List<String> chartLabelDetailIdList = this.kprAnalysisChartSettingMapper.selectAnalysisChartLabelIdListInst(chartLabelDetailReqDto);
				chartLabelDetailReqDto.setFontIdList(chartLabelDetailIdList);
				if (ObjectUtil.isNotEmpty(chartLabelDetailIdList)) {
					for (String chartLabelDetailId : chartLabelDetailIdList) {
						KprAnalysisChartLabelDetailReqDto tempChartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
						tempChartLabelDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
						tempChartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
						tempChartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
						tempChartLabelDetailReqDto.setFontId(chartLabelDetailId);
						tempChartLabelDetailReqDto.setAnalysisMasterFlag("Y");

						int analysisChartLabelIdCheckFlag = this.kprAnalysisChartSettingMapper.selectAnalysisColumnIdCheckMaster(tempChartLabelDetailReqDto);

						if (analysisChartLabelIdCheckFlag == 0) {
							this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailInstToMaster(tempChartLabelDetailReqDto);
						} else {
							this.kprAnalysisChartSettingMapper.updateAnalysisChartLabelDetailInstToMaster(tempChartLabelDetailReqDto);
						}
					}
				}

				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
			}
		}
		reqDto.setSVCAlias("");
		// master에 등록된 분석 삭제 처리
		List<String> dashboardAnalysisDeleteList = this.kprDashboardMapper.selectDashboardAnalysisDeleteList(reqDto);
		if (ObjectUtil.isNotEmpty(dashboardAnalysisDeleteList)) {
			for (String analysisId : dashboardAnalysisDeleteList) {
				KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
				analysisDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisDetailReqDto.setAnalysisId(analysisId);

				this.kprAnalysisMapper.deleteAnalysisDetailMaster(analysisDetailReqDto);

				KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				analysisColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisColumnDetailReqDto.setAnalysisId(analysisId);

				this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailMaster(analysisColumnDetailReqDto);

				// 분석 프롬프트 업데이트
				KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				analysisPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisPromptDetailReqDto.setAnalysisId(analysisId);

				this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(analysisPromptDetailReqDto);

				KprAnalysisFilterDetailReqDto filterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				filterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				filterDetailReqDto.setEmpId(reqDto.getModifyBy());
				filterDetailReqDto.setAnalysisId(analysisId);

				this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(filterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setAnalysisMasterFlag("N");
				chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
				chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
				chartLabelDetailReqDto.setAnalysisId(analysisId);

				this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
			}
		}

		// 대시보드 삭제
		this.kprDashboardMapper.deleteDashboardDetailInst(reqDto);

		// 대시보드 프롬프트 삭제
		dashboardPromptReqDto.setPromptList(null);
		this.kprDashboardPromptMapper.deleteDashboardPromptInst(dashboardPromptReqDto);

		// 분석 삭제
		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				KprDashboardDetailReqDto dashboardAnalysisReqDto = new KprDashboardDetailReqDto();
				dashboardAnalysisReqDto.setCreateBy(reqDto.getCreateBy());
				dashboardAnalysisReqDto.setModifyBy(reqDto.getModifyBy());
				dashboardAnalysisReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

				this.removeDashboardAnalysisDetail(dashboardAnalysisReqDto);
			}
		}

		resDto.setSuccess(true);
		resDto.setDashboardId(reqDto.getDashboardId());
		return resDto;
	}

	 /*
	  * 1. 메소드명: editDashboardDetailSaveAs
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public KprDashboardDetailResDto editDashboardDetailSaveAs(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprDashboardDetailResDto resDto = new KprDashboardDetailResDto();
		String dashboardIdNew = CommonUtil.newRid();
		reqDto.setDashboardId_New(dashboardIdNew);

		// 대시보드 등록
		this.kprDashboardMapper.insertDashboardDetailMaster(reqDto);

		KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
		dashboardPromptReqDto.setCreateBy(reqDto.getCreateBy());
		dashboardPromptReqDto.setModifyBy(reqDto.getModifyBy());
		dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
		dashboardPromptReqDto.setDashboardId_New(dashboardIdNew);

		this.kprDashboardPromptMapper.insertDashboardPromptMaster(dashboardPromptReqDto);

		reqDto.setDashboardMasterFlag("N");
		List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);
		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				String analysisIdNew = CommonUtil.newRid();

				KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
				analysisDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisDetailReqDto.setDashboardId(dashboardIdNew);
				analysisDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
				analysisDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisMapper.insertAnalysisDetailMaster(analysisDetailReqDto);

				KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				analysisColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisColumnDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
				analysisColumnDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisColumnMapper.insertAnalysisColumnDetailMaster(analysisColumnDetailReqDto);

				KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				analysisPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisPromptDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
				analysisPromptDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisPromptMapper.insertAnalysisPromptDetailMaster(analysisPromptDetailReqDto);

				KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				analysisFilterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisFilterDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisFilterDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
				analysisFilterDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMaster(analysisFilterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setAnalysisMasterFlag("N");
				chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
				chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
				chartLabelDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());
				chartLabelDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
			}
		}

		// 대시보드 삭제
		this.kprDashboardMapper.deleteDashboardDetailInst(reqDto);
		this.kprDashboardPromptMapper.deleteDashboardPromptInst(dashboardPromptReqDto);
		// 분석 삭제
		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				KprDashboardDetailReqDto dashboardAnalysisReqDto = new KprDashboardDetailReqDto();
				dashboardAnalysisReqDto.setCreateBy(reqDto.getCreateBy());
				dashboardAnalysisReqDto.setModifyBy(reqDto.getModifyBy());
				dashboardAnalysisReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

				this.removeDashboardAnalysisDetail(dashboardAnalysisReqDto);
			}
		}

		resDto.setSuccess(true);
		resDto.setDashboardId(dashboardIdNew);
		return resDto;
	}

	 /*
	  * 1. 메소드명: removeDashboardDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public StatusResDto removeDashboardDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto resDto = new StatusResDto();

		KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
		dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());

		// 마스터 데이터도 지워야한다면...
		String dashboardMasterFlag = reqDto.getDashboardMasterFlag();
		if ("Y".equals(dashboardMasterFlag)) {
			List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);

			// Flag 0 처리
			this.kprDashboardMapper.deleteDashboardDetailMaster(reqDto);

			this.kprDashboardPromptMapper.deleteDashboardPromptMaster(dashboardPromptReqDto);

			// 마스터 대시보드와 연결된 분석리스트 조회 후..
			if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
				for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
					// 분석 리스트도 루프돌면서 플레그 처리
					KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
					analysisDetailReqDto.setEmpId(reqDto.getModifyBy());
					analysisDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

					this.kprAnalysisMapper.deleteAnalysisDetailMaster(analysisDetailReqDto);

					KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
					analysisColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
					analysisColumnDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

					this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailMaster(analysisColumnDetailReqDto);

					KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
					analysisPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
					analysisPromptDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

					this.kprAnalysisPromptMapper.deleteAnalysisPromptDetailMaster(analysisPromptDetailReqDto);

					KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
					analysisFilterDetailReqDto.setEmpId(reqDto.getModifyBy());
					analysisFilterDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

					this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(analysisFilterDetailReqDto);

					KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
					chartLabelDetailReqDto.setAnalysisMasterFlag("N");
					chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
					chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
					chartLabelDetailReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

					this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailMaster(chartLabelDetailReqDto);
				}
			}
		}

		// 대시보드 삭제
		this.kprDashboardMapper.deleteDashboardDetailInst(reqDto);
		this.kprDashboardPromptMapper.deleteDashboardPromptInst(dashboardPromptReqDto);

		// 분석 삭제
		reqDto.setDashboardMasterFlag("N");
		List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);
		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				KprDashboardDetailReqDto dashboardAnalysisReqDto = new KprDashboardDetailReqDto();
				dashboardAnalysisReqDto.setCreateBy(reqDto.getCreateBy());
				dashboardAnalysisReqDto.setModifyBy(reqDto.getModifyBy());
				dashboardAnalysisReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

				this.removeDashboardAnalysisDetail(dashboardAnalysisReqDto);
			}
		}

		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: addDashboardAnalysisDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public KprDashboardDetailResDto addDashboardAnalysisDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		KprDashboardDetailResDto resDto = new KprDashboardDetailResDto();
		String analysisNew = CommonUtil.newRid();

//		this.startTransaction();

		KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
		analysisDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
		analysisDetailReqDto.setEmpId(reqDto.getCreateBy());
		analysisDetailReqDto.setDashboardId(reqDto.getDashboardId());
		analysisDetailReqDto.setDashboardSeq(reqDto.getDashboardSeq());
		analysisDetailReqDto.setDashboardEmbedType(reqDto.getDashboardEmbedType());
		analysisDetailReqDto.setAnalysisId(reqDto.getAnalysisId());
		analysisDetailReqDto.setAnalysisId_New(analysisNew);
		this.kprAnalysisMapper.insertAnalysisDetailCopy(analysisDetailReqDto);

		KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
		analysisColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
		analysisColumnDetailReqDto.setEmpId(reqDto.getCreateBy());
		analysisColumnDetailReqDto.setAnalysisId(reqDto.getAnalysisId());
		analysisColumnDetailReqDto.setAnalysisId_New(analysisNew);

		this.kprAnalysisColumnMapper.insertAnalysisColumnDetailCopy(analysisColumnDetailReqDto);

		KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
		analysisPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
		analysisPromptDetailReqDto.setEmpId(reqDto.getCreateBy());
		analysisPromptDetailReqDto.setAnalysisId(reqDto.getAnalysisId());
		analysisPromptDetailReqDto.setAnalysisId_New(analysisNew);

		this.kprAnalysisPromptMapper.insertAnalysisPromptDetailCopy(analysisPromptDetailReqDto);

		KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
		analysisFilterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
		analysisFilterDetailReqDto.setEmpId(reqDto.getCreateBy());
		analysisFilterDetailReqDto.setAnalysisId(reqDto.getAnalysisId());
		analysisFilterDetailReqDto.setAnalysisId_New(analysisNew);

		this.kprAnalysisFilterMapper.insertAnalysisFilterDetailCopy(analysisFilterDetailReqDto);

		KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
		chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
		chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
		chartLabelDetailReqDto.setAnalysisId(reqDto.getAnalysisId());
		chartLabelDetailReqDto.setAnalysisId_New(analysisNew);

		this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailCopy(chartLabelDetailReqDto);

//		this.commitTransaction();
//		this.endTransaction();

		analysisDetailReqDto.setAnalysisMasterFlag("N");
		analysisDetailReqDto.setAnalysisId(analysisNew);
		KprAnalysisDetailResDto analysisDetailResDto = this.kprAnalysisMapper.selectAnalysisName(analysisDetailReqDto);

		resDto.setSuccess(true);
		resDto.setAnalysisId(analysisNew);
		resDto.setAnalysisName(analysisDetailResDto.getAnalysisName());
		return resDto;
	}

	 /*
	  * 1. 메소드명: removeDashboardAnalysisDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public StatusResDto removeDashboardAnalysisDetail(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto resDto = new StatusResDto();

		KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
		analysisDetailReqDto.setCreateBy(reqDto.getCreateBy());
		analysisDetailReqDto.setModifyBy(reqDto.getModifyBy());
		analysisDetailReqDto.setAnalysisId(reqDto.getAnalysisId());

		this.kprAnalysisMapper.deleteAnalysisDetailInst(analysisDetailReqDto);

		KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
		analysisColumnDetailReqDto.setCreateBy(reqDto.getCreateBy());
		analysisColumnDetailReqDto.setModifyBy(reqDto.getModifyBy());
		analysisColumnDetailReqDto.setAnalysisId(reqDto.getAnalysisId());

		this.kprAnalysisColumnMapper.deleteAnalysisColumnListInst(analysisColumnDetailReqDto);

		KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
		analysisPromptDetailReqDto.setCreateBy(reqDto.getCreateBy());
		analysisPromptDetailReqDto.setModifyBy(reqDto.getModifyBy());
		analysisPromptDetailReqDto.setAnalysisId(reqDto.getAnalysisId());

		this.kprAnalysisPromptMapper.deleteAnalysisPromptListInst(analysisPromptDetailReqDto);

		KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
		analysisFilterDetailReqDto.setCreateBy(reqDto.getCreateBy());
		analysisFilterDetailReqDto.setModifyBy(reqDto.getModifyBy());
		analysisFilterDetailReqDto.setAnalysisId(reqDto.getAnalysisId());

		this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(analysisFilterDetailReqDto);

		KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
		chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
		chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
		chartLabelDetailReqDto.setAnalysisId(reqDto.getAnalysisId());

		this.kprAnalysisChartSettingMapper.deleteAnalysisChartLabelDetailListInst(chartLabelDetailReqDto);

		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: removeDashboardAnalysisList
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 6. 30.
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
	public StatusResDto removeDashboardAnalysisList(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto resDto = new StatusResDto();

		reqDto.setDashboardMasterFlag("N");
		List<KprDashboardDetailResDto> dashboardAnalysisList = this.kprDashboardMapper.selectDashboardAnalysisList(reqDto);

//		this.startTransaction();

		if (ObjectUtil.isNotEmpty(dashboardAnalysisList)) {
			for (KprDashboardDetailResDto dashboardAnalysisResDto : dashboardAnalysisList) {
				KprDashboardDetailReqDto dashboardAnalysisReqDto = new KprDashboardDetailReqDto();
				dashboardAnalysisReqDto.setCreateBy(reqDto.getCreateBy());
				dashboardAnalysisReqDto.setModifyBy(reqDto.getModifyBy());
				dashboardAnalysisReqDto.setAnalysisId(dashboardAnalysisResDto.getAnalysisId());

				this.removeDashboardAnalysisDetail(dashboardAnalysisReqDto);
			}
		}

		this.kprDashboardMapper.updateDashboardDetailInst(reqDto);

//		this.commitTransaction();
//		this.endTransaction();

		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: getPublishDashboardDetail
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 10. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		Publish 및 External 용 대시보드 요청
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public KprDashboardPublishDataResDto getPublishDashboardDetail(KprDashboardPublishDataReqDto reqDto) {
		LogUtil.param(KprDashboardService.class, reqDto);
		reqDto.setSVCAlias("adl");
		KprDashboardPublishDataResDto rstDto = kprDashboardMapper.selectPublishDashboardDetail(reqDto);

		if (ObjectUtil.isNotEmpty(rstDto)) {
			List<KprDashboardPublishDataResDto> analysisList = kprDashboardMapper.selectPublishAnalysisDetail(reqDto);
			rstDto.setAnalysisList(analysisList);

			KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
			dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
			dashboardPromptReqDto.setAnalysisMasterFlag(reqDto.getAnalysisMasterFlag());
			List<KprDashboardPromptResDto> dashboardPromptList = this.kprDashboardPromptMapper.selectDashboardPromptMasterList(dashboardPromptReqDto);

			if (ObjectUtil.isNotEmpty(dashboardPromptList)) {
				KprCommonDateFunctionReqDto dateFunctionReqDto = new KprCommonDateFunctionReqDto();
				dateFunctionReqDto.setDatabaseType(CommonUtil.getInstance().getDatabaseType());

				for (KprDashboardPromptResDto dashboardPromptDto : dashboardPromptList) {
					String promptTypeCode = dashboardPromptDto.getPromptTypeCode();
					if (!KprAnalysisConstants.PROMPT_TYPE_CD.LIST_BOX.name().equals(promptTypeCode)) {
						String promptValue = dashboardPromptDto.getPromptValue();
						String[] splitValueList = promptValue.split(" AND ");

						String promptValue1 = null;
						String promptValue2 = null;

						int idx = 0;
						for (String splitValue : splitValueList) {
							if (idx == 0) {
								promptValue1 = splitValue.replace("'", "");
								idx++;
							} else {
								promptValue2 = splitValue.replace("'", "");
							}
						}

						if (ObjectUtil.isNotEmpty(promptValue1)) {
							dateFunctionReqDto.setCodeName(promptValue1);
							KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

							if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
								String dateValue = this.kprCommonMapper.selectCommonDateCodeValue(dateCodeResDto.getDateFunc());

								dashboardPromptDto.setPromptValue1CodeName(dateValue);
								dashboardPromptDto.setPromptValue1MarkName(dateValue);
							} else {
								dashboardPromptDto.setPromptValue1CodeName(promptValue1);
								dashboardPromptDto.setPromptValue1MarkName(promptValue1);
							}
						}

						if (ObjectUtil.isNotEmpty(promptValue2)) {
							dateFunctionReqDto.setCodeName(promptValue2);
							KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

							if (ObjectUtil.isNotEmpty(dateCodeResDto)) {
								String dateValue = this.kprCommonMapper.selectCommonDateCodeValue(dateCodeResDto.getDateFunc());

								dashboardPromptDto.setPromptValue2CodeName(dateValue);
								dashboardPromptDto.setPromptValue2MarkName(dateValue);
							} else {
								dashboardPromptDto.setPromptValue2CodeName(promptValue2);
								dashboardPromptDto.setPromptValue2MarkName(promptValue2);
							}
						}
					}
				}
			}

			rstDto.setDashboardPromptList(dashboardPromptList);
		}

		return rstDto;
	}

	 /*
	  * 1. 메소드명: editDashboardDetailCopy
	  * 2. 클래스명: KPRDashboardService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 10. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대시보드 인스턴스 복사 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public KprDashboardDetailResDto editDashboardDetailCopy(KprDashboardDetailReqDto reqDto) {
		LogUtil.param(KprDashboardService.class, reqDto);

		String dashboardIdNew = CommonUtil.newRid();
		reqDto.setDashboardId_New(dashboardIdNew);

		kprDashboardMapper.insertDashboardDetailCopy(reqDto);

		KprDashboardPromptReqDto dashboardPromptReqDto = new KprDashboardPromptReqDto();
		dashboardPromptReqDto.setSystemColumn(reqDto.getSystemColumn());
		dashboardPromptReqDto.setCreateBy(reqDto.getCreateBy());
		dashboardPromptReqDto.setModifyBy(reqDto.getModifyBy());
		dashboardPromptReqDto.setDashboardId(reqDto.getDashboardId());
		dashboardPromptReqDto.setDashboardId_New(dashboardIdNew);
		kprDashboardPromptMapper.insertDashboardPromptCopy(dashboardPromptReqDto);

		KprDashboardDetailResDto rstDto = new KprDashboardDetailResDto();
		List<String> analysisIdList = kprDashboardMapper.selectDashboardAnalysisIdList(reqDto);
		if (ObjectUtil.isNotEmpty(analysisIdList)) {
			for (String analyisId : analysisIdList) {
				String analysisIdNew = CommonUtil.newRid();

				KprAnalysisDetailReqDto analysisDetailReqDto = new KprAnalysisDetailReqDto();
				analysisDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisDetailReqDto.setDashboardId(dashboardIdNew);
				analysisDetailReqDto.setAnalysisId(analyisId);
				analysisDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisMapper.insertAnalysisDetailCopy(analysisDetailReqDto);

				KprAnalysisColumnDetailReqDto analysisColumnDetailReqDto = new KprAnalysisColumnDetailReqDto();
				analysisColumnDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisColumnDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisColumnDetailReqDto.setAnalysisId(analyisId);
				analysisColumnDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisColumnMapper.insertAnalysisColumnDetailCopy(analysisColumnDetailReqDto);

				KprAnalysisPromptDetailReqDto analysisPromptDetailReqDto = new KprAnalysisPromptDetailReqDto();
				analysisPromptDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisPromptDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisPromptDetailReqDto.setAnalysisId(analyisId);
				analysisPromptDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisPromptMapper.insertAnalysisPromptDetailCopy(analysisPromptDetailReqDto);

				KprAnalysisFilterDetailReqDto analysisFilterDetailReqDto = new KprAnalysisFilterDetailReqDto();
				analysisFilterDetailReqDto.setSystemColumn(reqDto.getSystemColumn());
				analysisFilterDetailReqDto.setEmpId(reqDto.getModifyBy());
				analysisFilterDetailReqDto.setAnalysisId(analyisId);
				analysisFilterDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisFilterMapper.insertAnalysisFilterDetailCopy(analysisFilterDetailReqDto);

				KprAnalysisChartLabelDetailReqDto chartLabelDetailReqDto = new KprAnalysisChartLabelDetailReqDto();
				chartLabelDetailReqDto.setAnalysisMasterFlag("N");
				chartLabelDetailReqDto.setCreateBy(reqDto.getCreateBy());
				chartLabelDetailReqDto.setModifyBy(reqDto.getModifyBy());
				chartLabelDetailReqDto.setAnalysisId(analyisId);
				chartLabelDetailReqDto.setAnalysisId_New(analysisIdNew);

				this.kprAnalysisChartSettingMapper.insertAnalysisChartLabelDetailCopy(chartLabelDetailReqDto);
			}
		}

		rstDto.setDashboardId(dashboardIdNew);
		rstDto.setSuccess(true);
		return rstDto;
	}
}
