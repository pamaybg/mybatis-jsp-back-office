package com.icignal.kepler.analysis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.analysis.dto.request.KprAnalysisFilterDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisFilterDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisFilterMapper
 * 2. 파일명	: KPRAnalysisFilterMapper.java
 * 3. 패키지명	: com.icignal.kepler.analysis.mapper
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
public interface KprAnalysisFilterMapper {

	public void insertAnalysisFilterDetailMasterToInst(KprAnalysisFilterDetailReqDto filterReqDto);

	public Integer selectAnalysisFilterCount(KprAnalysisFilterDetailReqDto filterDetailReqDto);

	public List<String> selectAnalysisFilterIdListInst(KprAnalysisFilterDetailReqDto filterDetailReqDto);
     
	public void insertAnalysisFilterDetailInstToMaster(KprAnalysisFilterDetailReqDto tempFilterDetailReqDto);
     
	public void updateAnalysisFilterDetailInstToMaster(KprAnalysisFilterDetailReqDto tempFilterDetailReqDto);
     
	public void deleteAnalysisFilterDetailMaster(KprAnalysisFilterDetailReqDto filterDetailReqDto);
     
	public void deleteAnalysisFilterListInst(KprAnalysisFilterDetailReqDto filterDetailReqDto);
     
	public void insertAnalysisFilterDetailMaster(KprAnalysisFilterDetailReqDto filterDetailReqDto);
     
	public void insertAnalysisFilterDetailCopy(KprAnalysisFilterDetailReqDto filterDetailReqDto);
     
	public List<KprAnalysisFilterDetailResDto> selectAnalysisFilterList(KprAnalysisFilterDetailReqDto afr);
     
	public String selectAnalysisFilterCheckSql(KprAnalysisFilterDetailReqDto afr);
     
	public void insertAnalysisFilterDetailInst(KprAnalysisFilterDetailReqDto filter);
     
	public void updateAnalysisFilterDetailInst(KprAnalysisFilterDetailReqDto filter);
     
	public void deleteAnalysisFilterDetailInst(KprAnalysisFilterDetailReqDto afr);

	@Deprecated
	KprAnalysisFilterDetailResDto selectAnalysisFilterDefault(KprAnalysisFilterDetailReqDto afr);
}
