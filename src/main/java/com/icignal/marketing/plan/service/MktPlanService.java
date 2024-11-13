package com.icignal.marketing.plan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.marketing.plan.dto.request.MktPlanCampaignListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanIdListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanInsertReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanRemoveReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanUpdateListDto;
import com.icignal.marketing.plan.dto.request.MktWorkFlowPlanListReqDto;
import com.icignal.marketing.plan.dto.request.MktplanAllNodeUpdateReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeDeleteReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeInsertReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeUpdateReqDto;
import com.icignal.marketing.plan.dto.response.MktPlanCampaignListResDto;
import com.icignal.marketing.plan.dto.response.MktPlanIdListResDto;
import com.icignal.marketing.plan.dto.response.MktPlanListResDto;
import com.icignal.marketing.plan.dto.response.MktWorkFlowPlanListResDto;
import com.icignal.marketing.plan.mapper.MktPlanMapper;

/*
 * 마케팅 플랜 Service 
 * 
 * @date 2020. 06. 11.
 * @author LEE GYEONG YOUNG
 * 
 */

@Service("MktPlanService")
public class MktPlanService {
	//공통 서비스 등록
	@Autowired
	private CommonService commonService;
	//플랜 Mapper 등록
	@Autowired
	private MktPlanMapper mktPlanMapper;
	//workflow 사용을 위한 서비스 등록


	//마케팅 플랜 리스트 전체 조회
	public GridPagingResDto<MktPlanListResDto> getPlanList(MktPlanListReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			param.setSVCAlias("T1");

		return new GridPagingResHelper<MktPlanListResDto>().newGridPagingResDto( 
				param.init(CommonUtil.getInstance().getDBType()),
				mktPlanMapper.selectPlanList(param), AnnotationType.CommCode);  
	}
	//마케팅 플랜 리스트 선택 삭제 및 노드 데이터 삭제
	public StatusResDto removePlan(MktPlanRemoveReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			mktPlanMapper.removePlan(param);
			mktPlanMapper.planAllNodeDelete(param);
			rtnValue.setSuccess(true);

		return rtnValue;
	}
	//마케팅 플랜 리스트 삽입
	public StatusResDto addPlanDtl(MktPlanInsertReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			
			param.setId(commonService.getRowID());
			
			mktPlanMapper.insertPlan(param);
			rtnValue.setSuccess(true);
			rtnValue.setMessage(param.getId());

		return rtnValue;
	}
	//마케팅 플랜 리스트 특정 조회
	public MktPlanIdListResDto selectIdPlanList(MktPlanIdListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");

	return mktPlanMapper.selectIdPlanList(param);  
	}
	//마케팅 플랜 리스트 선택 수정
	public StatusResDto updatePlan(MktPlanUpdateListDto param) {
		
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mktPlanMapper.updatePlan(param);
		rtnValue.setSuccess(true);

	return rtnValue;
	}
	//마케팅 플랜 디테일 신규 버튼 리스트 전체 조회
	public GridPagingResDto<MktPlanCampaignListResDto> selectCampaignPlanList(MktPlanCampaignListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("C");

	return new GridPagingResHelper<MktPlanCampaignListResDto>().newGridPagingResDto( 
			param.init(CommonUtil.getInstance().getDBType()),
			mktPlanMapper.selectCampaignPlanList(param), AnnotationType.CommCode);  
	}
    //마케팅 플랜 디테일 워크플로우 캠페인 노드 생성을 위한 삽입
	public StatusResDto planNodeInsert(MktplanNodeInsertReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			
			param.setId(commonService.getRowID());
			
			mktPlanMapper.planNodeInsert(param);
			rtnValue.setSuccess(true);
			rtnValue.setMessage(param.getId());

		return rtnValue;
	}
	//마케팅 플랜 리스트 특정 조회
	public List<MktWorkFlowPlanListResDto> planNodeSelect(MktWorkFlowPlanListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("T1");
		

	return mktPlanMapper.planNodeSelect(param);  
	}
	//마케팅 플랜 디테일 워크플로우 수정
	public StatusResDto planNodeUpdate(MktplanNodeUpdateReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			mktPlanMapper.planNodeUpdate(param);
			rtnValue.setSuccess(true);

		return rtnValue;
	}
	//마케팅 플랜 리스트 선택 삭제
	public StatusResDto planNodeDelete(MktplanNodeDeleteReqDto param) {
			
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			mktPlanMapper.planNodeDelete(param);
			rtnValue.setSuccess(true);

		return rtnValue;
	}
	
    //마케팅 플랜 리스트 워크플로우 노드 전부 수정
	public StatusResDto planAllNodeUpdate(MktplanAllNodeUpdateReqDto param) {
			LogUtil.param(this.getClass(), param);
			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);			

			for (MktplanNodeUpdateReqDto node : param.getNodeList()) {
				node.setSystemColumn(param.getSystemColumn());
				mktPlanMapper.planAllNodeUpdate(node);
			}
			rtnValue.setSuccess(true);

		return rtnValue;
	}
	
}
