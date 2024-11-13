package com.icignal.marketing.executionStatus.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultReqDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultResDto;
import com.icignal.marketing.executionStatus.mapper.MktexecutionStatusMapper;

@Service
public class MktexecutionStatusService {
	@Autowired
	private MktexecutionStatusMapper MktexecutionStatusMapper;
	//캠페인 목록 그리드 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultResDto>
	selectCampaignListForExecResult(MktexecutionStatusSelectCampaignListForExecResultReqDto param){
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return new GridPagingResHelper<MktexecutionStatusSelectCampaignListForExecResultResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			MktexecutionStatusMapper.selectCampaignListForExecResult(param), AnnotationType.CommCode);  
	}
	//캠페인 특정 목록 그리드 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultOfListResDto>
	selectCampaignListForExecResultOfList(MktexecutionStatusSelectCampaignListForExecResultOfListReqDto param){
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return new GridPagingResHelper<MktexecutionStatusSelectCampaignListForExecResultOfListResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			MktexecutionStatusMapper.selectCampaignListForExecResultOfList(param), AnnotationType.CommCode);  
	}
	//캠페인 상세 특정 목록 그리드 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto>
	selectCampaignDetailForExecResultOfList(MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param){
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return new GridPagingResHelper<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			MktexecutionStatusMapper.selectCampaignDetailForExecResultOfList(param), AnnotationType.CommCode);  
	}	
	//MKT.MKT_TGT_DTL_RMV 채널 실패 사유 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto>
	selectCampaignDetailForExecResultErrorReason(MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto param){
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return new GridPagingResHelper<MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			MktexecutionStatusMapper.selectCampaignDetailForExecResultErrorReason(param), AnnotationType.CommCode);  
	}	
	//캠페인 PUSH 상세 목록 그리드 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto>
	selectPushCampaignDetailForExecResultOfList(MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param){
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return new GridPagingResHelper<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			MktexecutionStatusMapper.selectPushCampaignDetailForExecResultOfList(param), AnnotationType.CommCode);  
	}
	//캠페인 구매반응정보 조회
	public GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultResDto>
	selectPurReaction(MktexecutionStatusSelectCampaignListForExecResultReqDto param){

		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

		return new GridPagingResHelper<MktexecutionStatusSelectCampaignListForExecResultResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				MktexecutionStatusMapper.selectPurReaction(param), AnnotationType.CommCode);
	}
}
