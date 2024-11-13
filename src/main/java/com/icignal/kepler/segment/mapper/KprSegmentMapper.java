package com.icignal.kepler.segment.mapper;

import java.util.List;

import com.icignal.kepler.segment.dto.request.*;
import com.icignal.kepler.segment.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface KprSegmentMapper {


	public List<KprLogicalComponentListResDto> selectLogicalComponentList(KprLogicalComponentListReqDto lclr);

	public void insertSegment(KprSetSegmentReqDto ssr);

	public void insertSegmentFilter(KprSetSegmentFilterReqDto ssfr);

	public KprLogicalComponentSegKeyAndSqlResDto selectLogicalComponentSegKeyAndSql(
			KprSegmentFilterReqDto sfr);

	public KprSegmentFilterResDto selectAllCountSegmentFilter(KprSegmentFilterReqDto sfr);

	public void deleteSegmentBySegmentId(KprSetSegmentReqDto ssr);

	public void deleteSegmentFilterBySegmentId(KprSetSegmentFilterReqDto ssfr);

	public KprAttributeGroupColumnInfoResDto selectAtribGroupColumnInfo(
			KprAttributeGroupColumnInfoReqDto agcir);

	public KprSegmentCountResDto selectSegmentAllCountSql(KprSegmentCountReqDto scr);

	public KprSegmentDetailResDto selectSegmentDetail(KprSegmentDetailReqDto sdr);

	public List<KprSegmentFilterRelListResDto> selectSegmentFilterRelList(KprSegmentDetailReqDto sdr);

	public List<KprSegmentFilterListResDto> selectSegmentFilterList(KprSegmentDetailReqDto sdr);

	public void updateSegmentFilter(KprSetSegmentFilterReqDto ssfr);

	public void deleteSegmentFilter(KprSetSegmentFilterReqDto ssfr);

	public void deleteSegmentFilterRelByChildFilterId(KprSetSegmentFilterRelReqDto ssfrr);

	public void updateSegmentFilterOffSet(KprSetSegmentFilterReqDto filter);

	public KprSegmentFilterResDto selectSegmentFilter(KprSegmentFilterReqDto sfr);

	public void insertSegmentFilterRel(KprSetSegmentFilterRelReqDto ssfrr);

	public void updateSegmentFilterRel(KprSetSegmentFilterRelReqDto ssfrr);

	public void deleteSegmentFilterRel(KprSetSegmentFilterRelReqDto ssfrr);

	public void updateSegment(KprSetSegmentReqDto ssr);

	public void deleteSegmentFilterRelBySegmentId(KprSetSegmentFilterRelReqDto ssfrr);

	public void updateSegmentLogicalComponentId(KprSetSegmentReqDto ssr);

	public List<KprLogicalComponentColumnListResDto> selectLogicalComponentColumnList(
			KprLogicalComponentColumnListReqDto lcclr);

	public List<KprSegmentFilterResDto> selectChildSegmentFilterList(KprSegmentFilterReqDto sfr);

	public List<KprSegmentFilterResDto> selectParentSegmentFilterIdList(KprSegmentFilterReqDto sfr);

	public int insertCopySegment(KprSetSegmentReqDto ssr);

	public int insertCopySegmentFilter(KprSetSegmentFilterReqDto ssfr);

	public int insertCopySegmentFilterRel(KprSetSegmentFilterRelReqDto ssfrr);

	public void updateSegmentFilterSqlAndCount(KprSetSegmentFilterReqDto ssfr);

	public KprLogicalComponentDBInfoResDto selectLogicalComponentDBInfo(
			KprLogicalComponentDBInfoReqDto lcdbir);

	public List<KprSegmentListResDto> selectSegmentList(KprSegmentListReqDto slr);

	public void deleteSegmentChildNodes(KprSetSegmentReqDto ssr);


	public List<KprSegmentLcTblRelListResDto> selectSegmentLcTableRelListBySegId(KprSegmentLcTblRelListReqDto reqDto);

	public List<KprSegmentLcTblRelListResDto> selectSegmentLcTableRelListByTblRelId(KprSegmentLcTblRelListReqDto reqDto);

	public int insertCopyDifferentSegment(KprSetSegmentReqDto ssr);

	public int insertCopyDifferentFilter(KprSetSegmentFilterReqDto ssr);

	public int insertCopyDifferentFilterRel(KprSetSegmentFilterRelReqDto ssr);

	public List<kprSegmentFilterLinkResDto> segmentDifferentFilterRelTarget(String segId);
}
