package com.icignal.kepler.operation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.operation.dto.request.KprDrillDownGroupReqDto;
import com.icignal.kepler.operation.dto.response.KprDrillDownGroupResDto;

/*
 * 1. 클래스명	: KPRDrillDownGroupMapper
 * 2. 파일명	: KPRDrillDownGroupMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.kepler.operation.mapper
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
public interface KprDrillDownGroupMapper {

	List<KprDrillDownGroupResDto> selectMetaServiceList(KprDrillDownGroupReqDto reqDto);

	List<KprDrillDownGroupResDto> selectMetaTableColumnList(KprDrillDownGroupReqDto reqDto);

	List<KprDrillDownGroupResDto> selectDrillDownGroupList(KprDrillDownGroupReqDto reqDto);

	void insertDrillDownGroup(KprDrillDownGroupReqDto reqDto);

	void updateDrillDownGroup(KprDrillDownGroupReqDto reqDto);

	void deleteDrillDownGroup(KprDrillDownGroupReqDto reqDto);

}
