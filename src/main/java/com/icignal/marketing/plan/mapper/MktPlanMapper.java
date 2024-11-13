package com.icignal.marketing.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.plan.dto.request.MktPlanCampaignListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanIdListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanInsertReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanListReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanRemoveReqDto;
import com.icignal.marketing.plan.dto.request.MktPlanUpdateListDto;
import com.icignal.marketing.plan.dto.request.MktWorkFlowPlanListReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeDeleteReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeInsertReqDto;
import com.icignal.marketing.plan.dto.request.MktplanNodeUpdateReqDto;
import com.icignal.marketing.plan.dto.response.MktPlanCampaignListResDto;
import com.icignal.marketing.plan.dto.response.MktPlanIdListResDto;
import com.icignal.marketing.plan.dto.response.MktPlanListResDto;
import com.icignal.marketing.plan.dto.response.MktWorkFlowPlanListResDto;


@Mapper
public interface MktPlanMapper {
	//마케팅 플랜 리스트 전체 조회
    public List<MktPlanListResDto> selectPlanList (MktPlanListReqDto param) ;
	//마케팅 플랜 리스트 삽입
    public void insertPlan (MktPlanInsertReqDto param) ;
	//마케팅 플랜 리스트 선택 삭제 
    public void removePlan (MktPlanRemoveReqDto param) ;
	//마케팅 플랜 리스트 특정 조회
    public MktPlanIdListResDto selectIdPlanList (MktPlanIdListReqDto param) ;
	//마케팅 플랜 리스트 선택 수정
    public void updatePlan (MktPlanUpdateListDto param) ;
	//마케팅 플랜 디테일 신규 버튼 리스트 전체 조회    
    public List<MktPlanCampaignListResDto> selectCampaignPlanList (MktPlanCampaignListReqDto param) ;
    //마케팅 플랜 디테일 워크플로우 캠페인 노드 생성을 위한 삽입
    public void planNodeInsert (MktplanNodeInsertReqDto param) ;
	//마케팅 플랜 리스트 특정 조회
    public List<MktWorkFlowPlanListResDto> planNodeSelect (MktWorkFlowPlanListReqDto param) ;
	//마케팅 플랜 디테일 워크플로우 수정
    public void planNodeUpdate (MktplanNodeUpdateReqDto param) ;
	//마케팅 플랜 리스트 선택 삭제
    public void planNodeDelete (MktplanNodeDeleteReqDto param) ;
    //마케팅 플랜 리스트 워크플로우 노드 전부 삭제
    public void planAllNodeDelete (MktPlanRemoveReqDto param) ;
    //마케팅 플랜 리스트 워크플로우 노드 전부 수정
    public void planAllNodeUpdate (MktplanNodeUpdateReqDto param) ;


  
}