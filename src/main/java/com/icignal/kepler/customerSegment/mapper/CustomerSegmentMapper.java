package com.icignal.kepler.customerSegment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.customerSegment.dto.request.CustSegMartReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegStageReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegmentRuleReqDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegMartResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegStageResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegmentRuleResDto;
import com.icignal.kepler.segment.dto.request.KprSegmentListReqDto;
import com.icignal.kepler.segment.dto.response.KprSegmentListResDto;

@Mapper
public interface CustomerSegmentMapper {

	List<CustSegMartResDto> selectCustSegMartList(CustSegMartReqDto reqDto);

	CustSegMartResDto selectCustSegMartDetail(CustSegMartReqDto reqDto);

	void insertCustSegmentMart(CustSegMartReqDto reqDto);

	void updateCustSegmentMart(CustSegMartReqDto reqDto);

	void delCustSegmentMart(CustSegMartReqDto reqDto);

	List<CustSegMartResDto> selectLogicalCompList(CustSegMartReqDto reqDto);

	List<CustSegResDto> selectCustSegList(CustSegReqDto reqDto);

	CustSegResDto selectCustSegDetail(CustSegReqDto reqDto);

	void delCustSegment(CustSegReqDto reqDto);

	void insertCustSegment(CustSegReqDto reqDto);

	void updateCustSegment(CustSegReqDto reqDto);

	List<CustSegStageResDto> selectCustSegStageList(CustSegStageReqDto reqDto);

	Integer selectTodaySeq(CustSegReqDto reqDto);

	CustSegStageResDto selectCustSegStageDetail(CustSegStageReqDto reqDto);

	void insertCustSegmentStage(CustSegStageReqDto reqDto);

	void updateCustSegmentStage(CustSegStageReqDto reqDto);

	void delCustSegmentStage(CustSegReqDto reqDto);

	int insertCustSegmentRule(CustSegmentRuleReqDto reqDto);

	List<CustSegmentRuleResDto> selectCustSegRuleList(CustSegmentRuleReqDto reqDto);

	CustSegMartResDto selectCustSegMartData(CustSegMartReqDto reqDto);

	List<CustSegmentRuleResDto> selectCustRuleBySegId(CustSegmentRuleReqDto reqDto);

	void delCustSegmentRule(CustSegReqDto reqDto);

	List<KprSegmentListResDto> selectCustSegmentList(KprSegmentListReqDto slr);

	Integer selectCustSegStageIdx(CustSegStageReqDto reqDto);

	Integer selectIndexDupChk(CustSegStageReqDto reqDto);

	Integer selectIndexDupChkforUpdate(CustSegStageReqDto reqDto);

	Integer selectTypeCdDupChk(CustSegReqDto reqDto);

	Integer selectTypeCdDupChkForUpdate(CustSegReqDto reqDto);

	CustSegmentRuleResDto selectSegmentCond(CustSegmentRuleReqDto reqDto);

	CustSegmentRuleResDto selectCustRuleNmForTxt(CustSegmentRuleReqDto reqDto);


}
