package com.icignal.marketing.executionStatus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultReqDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultResDto;



@Mapper
public interface MktexecutionStatusMapper {
	//캠페인 목록 그리드 조회
    public List<MktexecutionStatusSelectCampaignListForExecResultResDto> selectCampaignListForExecResult (MktexecutionStatusSelectCampaignListForExecResultReqDto param) ;
	//캠페인 목록 그리드 조회
    public List<MktexecutionStatusSelectCampaignListForExecResultOfListResDto> selectCampaignListForExecResultOfList (MktexecutionStatusSelectCampaignListForExecResultOfListReqDto param) ;
	//캠페인 상세 목록 그리드 조회
    public List<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> selectCampaignDetailForExecResultOfList (MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param) ;
    //MKT.MKT_TGT_DTL_RMV 채널 실패 사유 조회
    public List<MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto> selectCampaignDetailForExecResultErrorReason (MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto param) ;
	//캠페인 PUSH 상세 목록 그리드 조회
    public List<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> selectPushCampaignDetailForExecResultOfList (MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param) ;
    //캠페인 구매반응정보 조회
    public List<MktexecutionStatusSelectCampaignListForExecResultResDto> selectPurReaction (MktexecutionStatusSelectCampaignListForExecResultReqDto param) ;

}
