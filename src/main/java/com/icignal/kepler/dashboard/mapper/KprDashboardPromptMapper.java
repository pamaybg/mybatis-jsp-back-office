package com.icignal.kepler.dashboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptCheckReqDto;
import com.icignal.kepler.dashboard.dto.request.KprDashboardPromptReqDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptCheckResDto;
import com.icignal.kepler.dashboard.dto.response.KprDashboardPromptResDto;


/*
 * 1. 클래스명	: KPRDashboardPromptMapper
 * 2. 파일명	: KPRDashboardPromptMapper.java
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
public interface KprDashboardPromptMapper {

	void insertDashboardPromptMasterToInst(KprDashboardPromptReqDto dashboardPromptReqDto);

	List<KprDashboardPromptResDto> selectDashboardPromptInstList(KprDashboardPromptReqDto dashboardPromptReqDto);

	Integer selectDashboardPromptMasterIdCheck(KprDashboardPromptReqDto tempDashboardPromptReqDto);

	void insertDashboardPromptInstToMaster(KprDashboardPromptReqDto tempDashboardPromptReqDto);

	void updateDashboardPromptInstToMaster(KprDashboardPromptReqDto tempDashboardPromptReqDto);

	void deleteDashboardPromptMaster(KprDashboardPromptReqDto dashboardPromptReqDto);

	void deleteDashboardPromptInst(KprDashboardPromptReqDto dashboardPromptReqDto);

	void insertDashboardPromptMaster(KprDashboardPromptReqDto dashboardPromptReqDto);

	List<KprDashboardPromptResDto> selectDashboardPromptMasterList(KprDashboardPromptReqDto dashboardPromptReqDto);

	void insertDashboardPromptCopy(KprDashboardPromptReqDto dashboardPromptReqDto);

	List<KprDashboardPromptResDto> selectDashboardCommonColumnList(KprDashboardPromptReqDto reqDto);

	Integer selectDashboardPromptInstIdCheck(KprDashboardPromptReqDto promptDto);

	void insertDashboardPromptInst(KprDashboardPromptReqDto promptDto);

	void updateDashboardPromptInst(KprDashboardPromptReqDto promptDto);
	//프롬프트 값 체크 로직 MAPPER(DAO)
	List<KprDashboardPromptCheckResDto> selectDashBoardPromptCheck(KprDashboardPromptCheckReqDto param);


}
