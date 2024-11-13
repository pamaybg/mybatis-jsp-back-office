package com.icignal.kepler.dashboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.dashboard.dto.request.KprDashboardDetailReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPublishDataReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardDetailResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPublishDataResDto;


/*
 * 1. 클래스명	: KPRDashboardMapper
 * 2. 파일명	: KPRDashboardMapper.java
 * 3. 패키지명	: com.icignal.kepler.dashboard.mapper
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
public interface KprDashboardMapper {

	List<KprDashboardDetailResDto> selectDashboardLayoutList(KprDashboardDetailReqDto reqDto);

	List<KprDashboardDetailResDto> selectDashboardAnalysisList(KprDashboardDetailReqDto reqDto);

	void insertDashboardDetailMasterToInst(KprDashboardDetailReqDto reqDto);

	KprDashboardDetailResDto selectDashboardDetailInst(KprDashboardDetailReqDto reqDto);

	Integer selectDashboardNameCheck(KprDashboardDetailReqDto reqDto);

	void insertDashboardDetailInst(KprDashboardDetailReqDto reqDto);

	void updateDashboardDetailInst(KprDashboardDetailReqDto reqDto);

	Integer selectDashboardIdCheck(KprDashboardDetailReqDto reqDto);

	void insertDashboardDetailInstToMaster(KprDashboardDetailReqDto reqDto);

	void updateDashboardDetailInstToMaster(KprDashboardDetailReqDto reqDto);

	List<String> selectDashboardAnalysisDeleteList(KprDashboardDetailReqDto reqDto);

	void deleteDashboardDetailInst(KprDashboardDetailReqDto reqDto);

	void insertDashboardDetailMaster(KprDashboardDetailReqDto reqDto);

	void deleteDashboardDetailMaster(KprDashboardDetailReqDto reqDto);

	KprDashboardPublishDataResDto selectPublishDashboardDetail(KprDashboardPublishDataReqDto reqDto);

	List<KprDashboardPublishDataResDto> selectPublishAnalysisDetail(KprDashboardPublishDataReqDto reqDto);

	void insertDashboardDetailCopy(KprDashboardDetailReqDto reqDto);

	List<String> selectDashboardAnalysisIdList(KprDashboardDetailReqDto reqDto);

}
