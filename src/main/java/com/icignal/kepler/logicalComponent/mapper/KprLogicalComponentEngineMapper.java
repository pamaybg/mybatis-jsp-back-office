package com.icignal.kepler.logicalComponent.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentEngineDetailReqDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentEngineDetailResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentEngineMapper
 * 2. 파일명	: KPRLogicalComponentEngineMapper.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.mapper
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
public interface KprLogicalComponentEngineMapper {

	List<KprLogicalComponentEngineDetailResDto> selectLgcCompColList(KprLogicalComponentEngineDetailReqDto reqDto);

	List<KprLogicalComponentEngineDetailResDto> selectLgcCompTblList(KprLogicalComponentEngineDetailReqDto reqDto);

	List<KprLogicalComponentEngineDetailResDto> selectLgcCompTblJoinColList(
			KprLogicalComponentEngineDetailReqDto tblJoinColumnListReqDto);

	List<KprLogicalComponentEngineDetailResDto> selectLgcCompGrpColList(
			KprLogicalComponentEngineDetailReqDto reqDto);

	List<KprLogicalComponentEngineDetailResDto> selectLgcCompGrpByColList(
			KprLogicalComponentEngineDetailReqDto reqDto);

}
