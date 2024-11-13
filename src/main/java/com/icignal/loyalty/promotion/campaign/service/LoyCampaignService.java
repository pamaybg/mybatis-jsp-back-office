package com.icignal.loyalty.promotion.campaign.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.CAMPAIGN_STATUS_TYPE;
import com.icignal.common.util.CommonUtil.CAMPAIGN_WORKFLOW_NODE_DATA_TYPE;
import com.icignal.common.util.CommonUtil.DATA_STATUS;
import com.icignal.common.util.CommonUtil.MKT_CAM_TYPE_CD;
import com.icignal.common.util.CommonUtil.PROMOTION_STATUS;
import com.icignal.common.util.CommonUtil.TASK_DATA_STATUS;
import com.icignal.common.util.CommonUtil.WORKFLOW_SAVE_TYPE;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.workflow.dto.request.WorkflowTaskReqDto;
import com.icignal.common.workflow.service.WorkflowService;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.promotion.campaign.dto.request.CampaignApprovalReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignDefaultInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutableUserReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutionInfoItemReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignExecutionInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetConidByCamidReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetTempNodeListReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignOfferReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignProgramReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignPromotionExeInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignRemoveReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqtDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignScheduleCheckReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTargetDtlReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTargetReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTgtChnlChkReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowNodeDataReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowStatusReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowTemplateReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1CardDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1ClbDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1FamDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1FrndDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc1JoinDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2AddDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2AgrDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2OnDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionAc2SurDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionActionDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionDefaultInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionKpiDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionRuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1AniDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1RuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa1XmRuleDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa2SumDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionTierActionReqDto;
import com.icignal.loyalty.promotion.campaign.dto.response.CampaignOfferResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.CampaignWorkflowDataResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.CampaignWorkflowStatusListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LOYCampaignListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignApprovalResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignExecutableUserResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetConidByCamidResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetTempNodeListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignOfferListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignOfferResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignPromotionExeInfoResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignScheduleCheckResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignTgtChnlChkResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyChnlTgtGrpResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyProdTgtGrpResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1CardDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1ClbDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1FamDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1FrndDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc1JoinDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2AddDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2AgrDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2ConDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2ConDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2OnDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionAc2SurDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionActionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionActionTierList;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionDefaultInfoResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionKpiDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1AniDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1RuleDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa1XmRuleDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa2SumDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionTierActionDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyTgtGrpListResDto;
import com.icignal.loyalty.promotion.campaign.mapper.LoyCampaignMapper;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetMstReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRuleSetResDto;
import com.icignal.loyalty.promotion.ruleset.service.LoyRuleSetService;
import com.icignal.marketing.campaign.dto.request.MktCampaignContentsChnnelRelReqDto;
import com.icignal.marketing.campaign.dto.response.MktCampaignContentsChnnelRelResDto;












/**
 * @name : infavor.loyalty.campaign.service.impl.LOYCampaignService
 * @date : 2018. 11. 19.
 * @author : hy.jun
 * @description :
 */
@Service
public class LoyCampaignService {


	@Autowired private LoyCampaignMapper cmpMapper;
	@Autowired private WorkflowService workflowSubService;
	@Autowired private LoyRuleSetService ruleSetService;
	/**
	 * @programId : MKT_MNG_001
	 * @name : getPromotionList
	 * @date : 2015. 9. 23.
	 * @author : 류동균
	 * @description : 캠페인 목록
	 */
	public GridPagingResDto<LOYCampaignListResDto> getPromotionList(LoyCampaignReqtDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		mcr.setSVCAlias("c");
		mcr.setInDataAuthTargetColumn("c.CAM_PLAN_ORG_CD");

		return new GridPagingResHelper<LOYCampaignListResDto>().newGridPagingResDto( 
				mcr.init(CommonUtil.getInstance().getDBType()),
				cmpMapper.getPromotionList(mcr),AnnotationType.CommCode);  
	}



	public GridPagingResDto<LoyCampaignGetTempNodeListResDto> getTemp(LoyCampaignGetTempNodeListReqDto dto)  throws Exception {
		dto.setSVCAlias("mwtm");
		return  new GridPagingResHelper<LoyCampaignGetTempNodeListResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				cmpMapper.getTemp(dto));

	}

	public GridPagingResDto<LoyCampaignGetTempNodeListResDto>getTempNodeList(LoyCampaignGetTempNodeListReqDto dto) {
		LogUtil.param(this.getClass(), dto);
		dto.setSVCAlias("mwtm");

		return new GridPagingResHelper<LoyCampaignGetTempNodeListResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				cmpMapper.getTempNodeList(dto));
	}

	public StatusResDto setCampaignStop(LoyCampaignDefaultInfoReqDto mcdir) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		LoyCampaignReqDto req = new LoyCampaignReqDto();
		req.setRid(mcdir.getId());

		//캠페인 기본정보 조회
		LoyPromotionDefaultInfoResDto camInfo = getCampaignDefaultInfo(req);

		//캠페인 상태가 활성일 경우만 중지 가능
		if (CAMPAIGN_STATUS_TYPE.A.name().equals(camInfo.getPromStatCd())) {

			//캠페인 상태 중지
			mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.S.name());
			mcdir.setPromStatCd(CAMPAIGN_STATUS_TYPE.S.name());
			rtnValue = editCampaignStatus(mcdir);

				callProcIfVanPromotionAllInsByStop(mcdir);
		}

		return rtnValue;
	}
	
	public StatusResDto setCampaignActive(LoyCampaignDefaultInfoReqDto mcdir) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		LoyCampaignReqDto req = new LoyCampaignReqDto();
		req.setRid(mcdir.getId());

		//캠페인 기본정보 조회
		LoyPromotionDefaultInfoResDto camInfo = getCampaignDefaultInfo(req);

		//캠페인 상태가 활성일 경우만 중지 가능
		if (!CAMPAIGN_STATUS_TYPE.A.name().equals(camInfo.getPromStatCd())) {

			//캠페인 상태 중지
			mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.A.name());
			mcdir.setPromStatCd(CAMPAIGN_STATUS_TYPE.A.name());
			rtnValue = editCampaignStatus(mcdir);

				/*callProcIfVanPromotionAllInsByStop(mcdir);*/
		}

		return rtnValue;
	}
	
	
	public StatusResDto editCampaignStatus(LoyCampaignDefaultInfoReqDto mcdir) {
		LogUtil.param(this.getClass(), mcdir);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		cmpMapper.updateCampaignStatus(mcdir);

		//실행정보아이템 상태 수정 : 활성
		/*if (CAMPAIGN_STATUS_TYPE.A.toString().equals(mcdir.getCampaignStatusCode())) {
			cmpMapper.updateCampaignExeInfoStatusActive(mcdir);
		}
		//실행정보아이템 상태 수정 : 중지
		else if (CAMPAIGN_STATUS_TYPE.S.toString().equals(mcdir.getCampaignStatusCode()) || CAMPAIGN_STATUS_TYPE.C.toString().equals(mcdir.getCampaignStatusCode())) {
			cmpMapper.updateCampaignExeInfoStatusStop(mcdir);
		}*/

		rtnValue.setSuccess(true);

		//승인서버 데이터 동기화
		//        iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_CAM_MST, mcdir.getId(), DATA_SYNC_TYPE.U);

		return rtnValue;
	}
	/**
	 * @programId :
	 * @name : callProcIfVanPromotionAllInsByStop
	 * @date : 2015. 10. 29.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : 인터페이스 승인전송 프로모션 저장 프로시저 호출 (프로모션 중지)
	 */
	public StatusResDto callProcIfVanPromotionAllInsByStop(LoyCampaignDefaultInfoReqDto mcdir) {
		LogUtil.param(this.getClass(), mcdir);

		StatusResDto rtnValue = new StatusResDto();

		LoyCampaignReqDto camReq = new LoyCampaignReqDto();
		camReq.setId(mcdir.getId());
		camReq.setSVCAlias("mtt");
		//캠페인 기본정보 조회
		LoyPromotionDefaultInfoResDto camInfo = cmpMapper.selectCampaignDefaultInfo(camReq);

		/*if ("1".equals(camInfo.getPromYn())) {*/

			//활성 프로모션 실행정보 목록 조회
			LoyCampaignPromotionExeInfoReqDto promReq = new LoyCampaignPromotionExeInfoReqDto();
			promReq.setSystemColumn(mcdir.getSystemColumn());
			promReq.setCamId(mcdir.getId());

			List<LoyCampaignPromotionExeInfoResDto> promResList = new ArrayList<LoyCampaignPromotionExeInfoResDto>();
			promResList = cmpMapper.selectExeInfoPromActiveList(promReq);

			for (LoyCampaignPromotionExeInfoResDto promRes : promResList) {

				LoyCampaignPromotionExeInfoReqDto req = new LoyCampaignPromotionExeInfoReqDto();
				req.setPromNo(promRes.getPromNo());
				req.setPromStatusCd(PROMOTION_STATUS.STOP.getValue());

				//승인서버 전송 프로모션 중지상태 등록
				callProcIfVanPromotionAllIns(req);
			}
		//}

		rtnValue.setSuccess(true);

		return rtnValue;
	}
	public StatusResDto callProcIfVanPromotionAllIns(LoyCampaignPromotionExeInfoReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		Map<String, String> rtn = cmpMapper.proc_if_ifl_vanPromotionAll_ins(param);
		String resultCd = rtn.get("resultCd");

		if ("S".equals(resultCd)) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(rtn.get("resultMsg"));
		}

		return rtnValue;
	}

	public StatusResDto removeCampaignProgram(LoyCampaignProgramReqDto mcpr) {

		StatusResDto rtnValue =  new StatusResDto();
		cmpMapper.deleteCampaignProgram(mcpr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public LoyCampaignTgtChnlChkResDto getTgtChnlChk(LoyCampaignTgtChnlChkReqDto ccrsr) {
		LogUtil.param(this.getClass(), ccrsr);

		LoyCampaignTgtChnlChkResDto rtnValue = new LoyCampaignTgtChnlChkResDto();
		ccrsr.setSVCAlias("mst");
		String tgtChk = cmpMapper.selectTgtChk(ccrsr);
		ccrsr.setSVCAlias("mcm");
		List<String> chnlChk = cmpMapper.selectChnlChk(ccrsr);

		rtnValue.setExeChnlTypeCd(tgtChk);
		rtnValue.setChnlTypeCdList(chnlChk);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public StatusResDto saveCampaignWorkflowTemplateUse(LoyCampaignWorkflowTemplateReqDto mcwtr) {
		LogUtil.param(this.getClass(), mcwtr);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		LoyCampaignReqDto mcr = new LoyCampaignReqDto();
		mcr.setLang(mcwtr.getLang());
		mcr.setId(mcwtr.getCampaignId());

		//캠페인 기본정보 조회
		LoyPromotionDefaultInfoResDto mcdir =  getCampaignDefaultInfo(mcr);

		/*mcwtr.setWfCamPrpsCode(mcdir.getCampaignPurposeCode());
		mcwtr.setWfCamTypeCode(mcdir.getCampaignTypeCode());
		mcwtr.setWfName(mcdir.getCampaignName());*/

		//템플릿 사용여부 저장
		if ("1".equals(mcwtr.getTemplateUseFlag())) {
			if (cmpMapper.selectCampaignWorkflowTemplateCount(mcwtr) == 0) {
				cmpMapper.updateCampaignWorkflowTemplate(mcwtr);
				rtnValue.setSuccess(true);
			}
		} else {
			cmpMapper.deleteCampaignWorkflowTemplate(mcwtr);
			cmpMapper.updateCampaignTemplateFlag(mcwtr);
			rtnValue.setSuccess(true);
		}

		cmpMapper.deleteCampaignWorkflowTemplate(mcwtr);
		cmpMapper.updateCampaignTemplateFlag(mcwtr);

		rtnValue.setSuccess(true);

		// 승인서버 데이터 동기화
	//	MKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_CAM_MST, mcwtr.getCampaignId(), DATA_SYNC_TYPE.U);
		return rtnValue;
	}

	public LoyCampaignOfferResDto getCampaignOffer(LoyCampaignOfferReqDto mcor) {
		 LoyCampaignOfferResDto campaignOffer = new LoyCampaignOfferResDto();
	        campaignOffer.setOfferList(getCampaignOfferList2(mcor));

	        return campaignOffer;
	
	}

	public StatusResDto callProcCamCopy(LoyCampaignReqDto param) {
		  LogUtil.param(this.getClass(), param);

		  StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        cmpMapper.procCamCopy(param);
	        String resultCd = param.getResultCd();

	        if ("S".equals(resultCd)) {
	        	rtnValue.setSuccess(true);
	        	rtnValue.setMessage(param.getResultMsg());
	        }

	        return rtnValue;
	}

	public List<LoyCampaignGetConidByCamidResDto> getConidByCamid(LoyCampaignGetConidByCamidReqDto param) {
		   param.setSVCAlias("mccr");
		return cmpMapper.selectConidByCamid(param);
	}

	
	@Transactional
	public StatusResDto saveCampaignOfferRel(LoyCampaignOfferReqDto mcor) {
		   LogUtil.param(this.getClass(), mcor);

	        //캠페인 상태 저장여부 확인
	        //checkCampaignStatusSaveFlag(mcor.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.OFFER.name());
	        StatusResDto rtnValue = new StatusResDto();

	        for (LoyCampaignOfferReqDto offer : mcor.getOfferList()) {
	            offer.setSystemColumn(mcor.getSystemColumn());
	            offer.setCampaignId(mcor.getCampaignId());

	            //캠페인 오퍼 관계 삭제
	            if ( DATA_STATUS.D.toString().equals(offer.getDataStatus()) ) {
	                   rtnValue.setSuccess(false);
	                   cmpMapper.deleteCampaignOfferRel(offer);
	                   rtnValue.setSuccess(true);
	            }
	            //캠페인 오퍼 관계 수정
	            else if ( ObjectUtil.isNotEmpty(offer.getId())) {
	                rtnValue.setSuccess(false);
	                cmpMapper.updateCampaignOfferRel(offer);
	            	rtnValue.setSuccess(true);
	            }
	            //캠페인 오퍼 관계 등록
	            else {
	            	 rtnValue.setSuccess(false);
	            	 String id = CommonUtil.newRid();
	            	 offer.setId(id);
	                 cmpMapper.insertCampaignOfferRel(offer);
	                 rtnValue.setSuccess(true);
	            	
	            }
	        }

	        return rtnValue;
	}
	
    
   

	public StatusResDto removeCampaign(LoyCampaignRemoveReqDto param) {
		LogUtil.param(this.getClass(), param);

        StatusResDto rtnDto = new StatusResDto();
        rtnDto.setSuccess(false);


        // 작성중 && 결제 진행중이 아니고, 결제 승인완료도 아닌 캠페인만 삭제 가능
        if ( CAMPAIGN_STATUS_TYPE.W.name().equals(param.getCampaignStatusCode())
               /* && APPROVAL_STATUS.APPROVAL_IN_PROCESS.getCode().equals(param.getCampaignApprovalStatusCode()) == false*/
                /*&& APPROVAL_STATUS.APPROVAL_SUCCESS.getCode().equals(param.getCampaignApprovalStatusCode()) == false*/) {

            // 1. 삭제처리
        	cmpMapper.removeCampaign(param);
            rtnDto.setSuccess(true); 

            // 2. 각 채널별 발송 중지
			/*
			 * if ( rtnDto.getSuccess() ) { rtnDto.setSuccess(false);
			 * LoyCampaignDefaultInfoReqDto mcdir = new LoyCampaignDefaultInfoReqDto();
			 * mcdir.setSystemColumn(param.getSystemColumn()); mcdir.setId(param.getId());
			 * 
			 * //메세지 발송 중지 cmpMapper.updateStopSendingMessagesByCampaignId(mcdir);
			 * 
			 * //PUSH 발송 중지 cmpMapper.updateStopSendingPushByCampaignId(mcdir);
			 * 
			 * //이메일 발송 중지 cmpMapper.updateStopSendingEmailByCampaignId(mcdir);
			 * 
			 * //카카오 친구톡 발송 중지 cmpMapper.updateStopSendingKakaoByCampaignId(mcdir);
			 * 
			 * rtnDto.setSuccess(true);
			 * 
			 * }
			 */
            
            /*if ( rtnDto.getSuccess() ) {
            	rtnDto.setSuccess(false);
            	cmpMapper.removeCampaignTemplates(param);
            	rtnDto.setSuccess(true);
            }*/
        }
        return rtnDto;
	}

	public StatusResDto setCampaignComplete(LoyCampaignDefaultInfoReqDto mcdir) {
	     LogUtil.param(this.getClass(), mcdir);

	        boolean firstFlag = true;

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        LoyCampaignReqDto req = new LoyCampaignReqDto();
	        req.setSystemColumn(mcdir.getSystemColumn());
	        req.setId(mcdir.getId());

	        //캠페인 기본정보 조회
	        LoyPromotionDefaultInfoResDto camInfo =getCampaignDefaultInfo(req);

	        //활성 권한 조회
	        LoyCampaignExecutableUserReqDto mceur = new LoyCampaignExecutableUserReqDto();
	        mceur.setSystemColumn(mcdir.getSystemColumn());
	        mceur.setCamId(mcdir.getId());

	        if (isExecutableUser(mceur)) {

	            //캠페인 상태가 작성중일 경우만 활성 가능
	            if ( CAMPAIGN_STATUS_TYPE.W.name().equals(camInfo.getPromStatCd()) ) {

	                //캠페인 상태 확인
	                LoyCampaignStatusCheckReqDto cscr = new LoyCampaignStatusCheckReqDto();
	                cscr.setCamId(mcdir.getId());
	                //cscr.setUseApproval(false);
	                //2018.11.06 hy.jun 캠페인 테스트 위한 임시 전자결재체크 해제
	                cscr.setUseApproval(true);
	                cscr.setType(mcdir.getType());
	                rtnValue = campaignStatusCheck(cscr);
	                String message = rtnValue.getMessage();

	                //캠페인 상태 변경
	                if ( "true".equals(message) ) {


	                    //프로모션일 경우
	                	if ("1".equals(camInfo.getPromYn())) {
	                    	//프로모션 일 경우 프로모션 실행정보 설정
	                    	
	                    	/*
	                         * 2018.12.04 hy.jun
	                         * 로열티 시스템 프로모션 캠페인은 룰셋 존재 여부 체크하지 않는다.
	                         */
	                    	//if(ObjectUtil.isEmpty(cscr.getType()) || !cscr.getType().equals(CommonUtil.CAMPAIGN_PROGRAM_TYPE.Loy.toString())) {
	                    		//rtnValue = setPromotionExeInfo(req);
	                    	//}
	                    }
	                    //프로모션이 아닌 정기캠페인 일 경우 실행정보 설정
					/*
					 * else if
					 * (MKT_CAM_TYPE_CD.REGULAR.toString().equals(camInfo.getCampaignTypeCode())) {
					 * //rtnValue = setRegularExeInfo(req); }
					 */

	                    if (rtnValue.getSuccess()) {
	                    	mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.A.name());
	                    	rtnValue = editCampaignStatus(mcdir);
	                    }
	                    else {
	                    	rtnValue.setSuccess(false);
	                    	rtnValue.setMessage("97");	//일정 등록 실패
	                    }
	                }
	            }
	            else {
	                rtnValue.setSuccess(true);
	                rtnValue.setMessage("99"); //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
	            }
	        }
	        else {
	            rtnValue.setSuccess(true);
	            rtnValue.setMessage("98");  //실행권환이 없습니다.
	        }

	        return rtnValue;
	}
    /**
     * 실행 권한 여부 조회
     *
     * (아래의 세 조건중 하나이상 충족할 경우 캠페인을 실행할 수 있다.)
     * 조건 1. 승인그룹에 속해있다.
     * 조건 2. 작성자
     * 조건 3. 요청자
     *
     * @programId :
     * @name : isExecutableUser
     * @date : 2018. 1. 22.
     * @author : jh.kim
     * @table :
     * @return : boolean
     * @description :
     */
    public boolean isExecutableUser(LoyCampaignExecutableUserReqDto mceur) {

        boolean rtnFlag = false;
        LoyCampaignExecutableUserResDto isExecutableUserInfo = cmpMapper.isExecutableUser(mceur);

        if ("1".equals(isExecutableUserInfo.getAuthGroupUserYN())
                || "1".equals(isExecutableUserInfo.getCreateUserYN())
                || "1".equals(isExecutableUserInfo.getRqtrUserYN()) ) {
            rtnFlag = true;
        }
        return rtnFlag;
    }
	
    /**
	 * @name : checkCampaignStatus
	 * @date : 2016. 03. 28.
	 * @author : 장용
	 * @table : mkt_cam_mst
	 * @return : StatusResDto
	 * @description : 캠페인 상태 조회
	 */
    
    public StatusResDto campaignStatusCheck(LoyCampaignStatusCheckReqDto cscr) {
        LogUtil.param(this.getClass(), cscr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);
        rtnValue.setMessage("true");

        boolean successFlag = true;

        //캠페인 정보조회
        LoyCampaignReqDto camInfoReq = new LoyCampaignReqDto();
        camInfoReq.setSystemColumn(cscr.getSystemColumn());
        camInfoReq.setId(cscr.getCamId());

        LoyPromotionDefaultInfoResDto camInfo = getCampaignDefaultInfo(camInfoReq);

        // - 이벤트 트리거 캠페인은 일정이 없어야 한다.

        //일정 존재여부 체크
        String exeInfo =cmpMapper.checkChnlExeInfo(cscr);
        String exeInfoItem = cmpMapper.checkChnlExeInfoItem(cscr);

		/*
		 * if ( MKT_CAM_TYPE_CD.TRIGGER.name().equals(camInfo.getCampaignTypeCode().
		 * toUpperCase()) ) {
		 * 
		 * if ( exeInfoItem != null && exeInfoItem.length() > 0 ) { //실패 successFlag =
		 * false; rtnValue.setMessage("6"); } else { //성공
		 * LogUtil.debug("validation check :: 이벤트 트리거 -> 일정 없음."); } }
		 */
     
        

        // - 영수증, 단말기, 웹게시가 아닌 채널을 가지고 있을때 이벤트 트리거가 아닌 모든 캠페인은 일정이 있어야 한다

        //채널 정보 조회
        if ( successFlag ) {

            // 해당 캠페인이 가지고 있는 일정노드가 필요한 채널의 개수
            int chkChnl = cmpMapper.checkChnlInfo(cscr);

            if ( ObjectUtil.isNotEmpty(chkChnl) && chkChnl > 0 ) {
                if ( !MKT_CAM_TYPE_CD.TRIGGER.name().equalsIgnoreCase(camInfo.getCampaignTypeCode())) {

                    // 정기 캠페인인 경우에는 item 없이 info만 존재함
                    if ( MKT_CAM_TYPE_CD.REGULAR.name().equalsIgnoreCase(camInfo.getCampaignTypeCode()) ) {

                        if ( exeInfo != null && exeInfo.length() > 0 ) {
                            //성공
                            LogUtil.info("validation check :: 정기 캠페인 채널 존재 -> 일정 존재. ");
                        }
                        else {
                            //실패
                            successFlag = false;
                            rtnValue.setMessage("5");
                        }
                    }
                    else {
                        if ( exeInfoItem != null && exeInfoItem.length() > 0 ) {
                            //성공
                            LogUtil.info("validation check :: (이벤트 트리거 제외) 채널 존재 -> 일정 존재. ");
                        }
                        else {
                            //실패
                            successFlag = false;
                            rtnValue.setMessage("5");
                        }
                    }
                }
            }
        }

        //채널 발송시간 채크
        if(successFlag) {

        	LoyCampaignScheduleCheckReqDto reqCamId = new LoyCampaignScheduleCheckReqDto();

        	//캠페인에 등록된 채널 타입 반환
        	List<LoyCampaignScheduleCheckResDto> chnlType = cmpMapper.chnlTypeCheck(cscr);

        	if(ObjectUtil.isNotEmpty(chnlType)) {
        		//캠페인 채널등록여부
        		if(ObjectUtil.isNotEmpty(chnlType.get(0).getChnlType())) {
	        		//채널타입으로 전송시간 체크
	        		for(LoyCampaignScheduleCheckResDto scr : chnlType) {
	        		reqCamId.setCamId(cscr.getCamId());
	        		reqCamId.setChnlType(scr.getChnlType());

	       			//채널 전송시간 체크
	        		int scheduleCheck = cmpMapper.chnlTimeValidCheck(reqCamId);

	           			if(scheduleCheck > 0) {
           					successFlag = false;
           					rtnValue.setMessage("17");
           					return rtnValue;
           				}else {
           					LogUtil.info("validation check :: 채널 발송시간  체크");
           				}
        			}
        		}
        	}
        }
   
        // - 프로모션인 경우 오퍼 필수
        // - 쿠폰이 등록되어있는 경우 오퍼 필수

        if ( successFlag ) {

            //오퍼 정보 조회
            String offerType = cmpMapper.checkOfferInfo(cscr);

            //포스 이벤트일 경우 일정 체크
            if ( ObjectUtil.isNotEmpty(offerType) && offerType.equalsIgnoreCase("POS_EVENT")) {

                //일정 등록 조회
                String exeInfoItemId = cmpMapper.checkExeInfoItemId(cscr);

                if ( exeInfoItemId != null && exeInfoItemId.length() > 0 ) {
                    //성공
                    LogUtil.info("validation check :: 포스이벤트 -> 일정 존재.");
                }
                else {
                    successFlag = false;
                    rtnValue.setMessage("4");
                }
            }

            //if ( successFlag ) {

                //프로모션 여부를 체크한 경우
            	 /*if ( "1".equals(camInfo.getPromYn()) ) {
                 	*//**
                      * 2019.11.28 sm.lee
                      * 마케팅 캠페인은 오퍼 존재 여부 체크하지 않음. 단, 로열티 프로모션 캠페인은 오퍼 존재 여부를 체크함
                      *//*
                 	if(ObjectUtil.isEmpty(cscr.getType()) || cscr.getType().equals(CommonUtil.CAMPAIGN_PROGRAM_TYPE.Loy.toString())) {
                		//오퍼 필수
                		if ( ObjectUtil.isNotEmpty(offerType) ) {
                        	//성공
                        	LogUtil.info("validation check :: 프로모션 체크 -> 오퍼 존재.");
                    	}
                    	else {
                        	successFlag = false;
                        	rtnValue.setMessage("8");
                    	}
                	}
                    if ( successFlag ) {
                    	*//**
                         * 2018.12.04 hy.jun
                         * 로열티 시스템 프로모션 캠페인은 룰셋 존재 여부 체크하지 않는다.
                         *//*
                    	if(ObjectUtil.isEmpty(cscr.getType()) || !cscr.getType().equals(CommonUtil.CAMPAIGN_PROGRAM_TYPE.Loy.toString())) {

	                        // ruleset 필수
	                        LoyRulesetDtlReqDto dtlReq = new LoyRulesetDtlReqDto();
	                        dtlReq.setSystemColumn(cscr.getSystemColumn());
	                        dtlReq.setRidMktCamMst(cscr.getCamId());

	                        LoyRulesetDtlResDto rulesetInfo = ruleSetService.getLoyRulesetDtl(dtlReq);

	                        if ( ObjectUtil.isNotEmpty(rulesetInfo) ) {
	                            //성공
	                            LogUtil.info("validation check :: 프로모션 체크 -> 룰셋 존재.");
	                        }
	                        else {
	                            successFlag = false;
	                            rtnValue.setMessage("9");
	                        }

                    	}
                    }


                    //상품 프로모션
                    if(successFlag) {
                    	if(CommonUtil.Loy_PROM_SUB_TYPE.P011.toString().equals(camInfo.getPromSubType())) {

                    		//상품 프로모션 대상상품 존재X
                    		int promProduct = ruleSetMapper.selectValidPromProd(cscr);

                        	if(promProduct > 0) {
                        		successFlag = false;
                                rtnValue.setMessage("15");
                        	}else {
                        		LogUtil.info("validation check :: 상품 프로모션 대상상품 NULL 값 체크 -> NULL 값 없음.");
                        	}

                        	//캠페인 기간내 상품 프로모션 중복
                        	int termPromProduct = ruleSetMapper.selectValidPromProdTerm(cscr);

                        	if(termPromProduct > 0) {
                        		successFlag = false;
                           		rtnValue.setMessage("16");
                        	}else {
                        		LogUtil.debug("validation check :: 상품 프로모션 기간 중복 실행 체크 -> 중복 없음.");
                        	}
                    	}

                    }
                }*/
            //}

  
        }


        	//캠페인 워크플로우 노드 데이터 유무 확인
        	if ( successFlag ) {

        		//캠페인 워크플로우 테스크 및 데이터 조회
        		LoyCampaignWorkflowReqDto mcwr = new LoyCampaignWorkflowReqDto();
        		mcwr.setCampaignId(cscr.getCamId());
        		mcwr.setLang(cscr.getLang());

        		List<CampaignWorkflowStatusListResDto> campaignList = getCampaignWorkflowStatusList(mcwr);

        		//캠페인 워크플로우 노드 데이터 유무 확인
        		for ( CampaignWorkflowStatusListResDto data : campaignList ) {

        			LogUtil.debug("validation check :: Node check = " + data.getTaskTypeCode() + "," + data.getEnterTime());

        			if ( data.getEnterTime() == null ) {
        				successFlag = false;
        				rtnValue.setMessage("3");
        				break;
        			}
        		}
        	}

        //결제상신에 사용될 경우 승인여부를 체크하지 않는다
        if (cscr.isUseApproval() == false) {

            //승인 여부에 따른 승인 완료 여부
            if ( successFlag ) {
                String checkVal2 = cmpMapper.checkElecAprov(cscr);

                // 승인 존재함
                if ( ObjectUtil.isNotEmpty(checkVal2) ) {

                    // 승인 완료됨
                    if (checkVal2.equalsIgnoreCase("false")) {
                        successFlag = false;
                        rtnValue.setMessage("2");
                    }
                    else {
                        //성공
                        LogUtil.debug("validation check :: 승인 존재 -> 승인완료.");
                    }
                }
                // 승인존재하지 않음.
                else {
                    successFlag = false;
                    rtnValue.setMessage("13");
                }
            }
        }

        return rtnValue;
    }



	public LoyCampaignApprovalResDto getCampaignApproval(CampaignApprovalReqDto mcar) {
        LogUtil.param(this.getClass(), mcar);
	    LoyCampaignApprovalResDto rtnValue = new LoyCampaignApprovalResDto();

        mcar.setSVCAlias("ea");
        rtnValue = cmpMapper.selectCampaignApproval(mcar);

        return rtnValue;
	}
    
    public List<LoyCampaignOfferListResDto> getCampaignOfferList2(LoyCampaignOfferReqDto mcor) {
        LogUtil.param(this.getClass(), mcor);
        mcor.setSVCAlias("cor");

        return cmpMapper.selectCampaignOfferList(mcor);
    }
    
    
    
	   /**
  * @programId : MKT_MNG_P04
  * @name : removeCampaignOfferRelByCmapaignId
  * @date : 2015. 10. 29.
  * @author : 류동균
  * @table : mkt.mkt_cam_offer_rel
  * @return :
  * @description : 캠페인 오퍼 삭제 By campaignId
  */
	
	 public StatusResDto removeCampaignOfferRelByCampaignId(LoyCampaignOfferReqDto mcor) {
	        LogUtil.param(this.getClass(), mcor);

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);
	        mcor.setSVCAlias("cor");
	        //승인서버 데이터 동기화를 위한 삭제 목록 조회
		/*
		 * List<LoyCampaignOfferListResDto> offerList=
		 * workflowMapper.selectCampaignOfferList(mcor);
		 */

	        cmpMapper.deleteCampaignOfferRelByCampaignId(mcor);
	        rtnValue.setSuccess(true);

	        return rtnValue;	
	    }
	 
	   /**
   * @programId : MKT_MNG_P05
   * @name : removeCampaignContentsChnnelRel
   * @date : 2015. 11. 27.
   * @author : "류동균"
   * @table : mkt.mkt_conts_chnl_rel
   * @return :
   * @description : 캠페인 콘텐츠 채널 관계 삭제
   */
  public StatusResDto removeCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
      LogUtil.param(this.getClass(), mcccrr);

      StatusResDto rtnValue = new StatusResDto();
      rtnValue.setSuccess(false);

      //콘텐츠 채널 관계 삭제
      cmpMapper.deleteCampaignContentsChnnelRel(mcccrr);

      //콘텐츠 삭제
      cmpMapper.deleteCampaignContents(mcccrr);

      rtnValue.setSuccess(true);

      return rtnValue;
  }
  /**
   * @programId : MKT_MNG_P06
   * @name : removeCampaignTargetByCampaignId
   * @date : 2015. 11. 2.
   * @author : 류동균
   * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl
   * @return :
   * @description : 캠페인대상 삭제 By CampaignId
   */
  public StatusResDto removeCampaignTargetByCampaignId(LoyCampaignTargetReqDto mctr) {
      LogUtil.param(this.getClass() , mctr);

      StatusResDto rtnValue = new StatusResDto();
      rtnValue.setSuccess(false);

      //캠페인대상 헤더삭제
      cmpMapper.deleteCampaignTargetByCampaignId(mctr);

      //캠페인대상 상세삭제
      LoyCampaignTargetDtlReqDto mctdr = new LoyCampaignTargetDtlReqDto();
      mctdr.setCampaignId(mctr.getCampaignId());
      cmpMapper.deleteCampaignTargetDtlByCampaignId(mctdr);

      rtnValue.setSuccess(true);

      return rtnValue;
  }
  
  /**
   * @programId : MKT_MNG_P08
   * @name : removeExecutionInfo
   * @date : 2015. 11. 2.
   * @author : 류동균
   * @table : mkt.mkt_exe_info
   * @return :
   * @description : 실행정보 삭제
   */
  public StatusResDto removeExecutionInfo(LoyCampaignExecutionInfoReqDto mceir) {
      LogUtil.param(this.getClass(), mceir);

      StatusResDto rtnValue = new StatusResDto();
      rtnValue.setSuccess(false);

      //실행정보 삭제
      cmpMapper.deleteExecutionInfo(mceir);

      //실행정보 아이템 삭제
      LoyCampaignExecutionInfoItemReqDto mceiir = new LoyCampaignExecutionInfoItemReqDto();
      mceiir.setSystemColumn(mceir.getSystemColumn());
      mceiir.setExeInfoId(mceir.getId());
      cmpMapper.deleteExecutionInfoItemByExeInfoId(mceiir);

      rtnValue.setSuccess(true);

      return rtnValue;
  }
	
  /**
   * @programId : MKT_MNG_P08
   * @name : removeExecutionInfoByCampaignId
   * @date : 2015. 11. 2.
   * @author : 류동균
   * @table : mkt.mkt_exe_info
   * @return :
   * @description : 실행정보 삭제 By CampaignId
   */
	   public StatusResDto removeExecutionInfoByCampaignId(LoyCampaignExecutionInfoReqDto mceir) {
	        LogUtil.param(this.getClass(), mceir);

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        //실행정보 삭제
	        cmpMapper.deleteExecutionInfoByCampaignId(mceir);

	        //실행정보 아이템 삭제
	        LoyCampaignExecutionInfoItemReqDto mceiir = new LoyCampaignExecutionInfoItemReqDto();
	        mceiir.setSystemColumn(mceir.getSystemColumn());
	        mceiir.setCampaignId(mceir.getCampaignId());
	        cmpMapper.deleteExecutionInfoItemByCampaignId(mceiir);


	        rtnValue.setSuccess(true);

	        return rtnValue;
	    }
	
	    /**
	     * @programId : MKT_MNG_001
	     * @name : addCampaignWorkflowStatus
	     * @date : 2015. 9. 23.
	     * @author : 류동균
	     * @table : mkt.mkt_cmn_wf_cam
	     * @return :
	     * @description : 캠페인 워크플로우 진행현황 등록
	     */
	    public StatusResDto addCampaignWorkflowStatus(LoyCampaignWorkflowStatusReqDto mcwsr) {
	        LogUtil.param(this.getClass(), mcwsr);

	        StatusResDto rtnValue = new StatusResDto();
	        String id = CommonUtil.newRid();
	        mcwsr.setId(id);

	        cmpMapper.insertCampaignWorkflowStatus(mcwsr);

	        rtnValue.setSuccess(true);

	        return rtnValue;
	    }
	    /**
	     * @programId : MKT_MNG_P02
	     * @name : editCampaignWorkflowStatus
	     * @date : 2015. 10. 19.
	     * @author : 류동균
	     * @table : mkt.mkt_cmn_wf_cam
	     * @return :
	     * @description : 캠페인 워크플로우 진행현황 수정
	     */
	    public StatusResDto editCampaignWorkflowStatus(LoyCampaignWorkflowStatusReqDto mcwsr) {
	        LogUtil.param(this.getClass(), mcwsr);

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        cmpMapper.updateCampaignWorkflowStatus(mcwsr);

	        rtnValue.setSuccess(true);

	        return rtnValue;
	    }
	    /**
	     * @programId :
	     * @name : editCampaignWorkflowRel
	     * @date : 2015. 10. 21.
	     * @author : 류동균
	     * @table :
	     * @return :
	     * @description : 캠페인 워크플로우 관계 수정
	     */
	    public StatusResDto editCampaignWorkflowRel(LoyCampaignWorkflowReqDto mcwr) {
	        LogUtil.param(this.getClass(), mcwr);

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        cmpMapper.updateCampaignWorkflowRel(mcwr);

	        rtnValue.setSuccess(true);

	        return rtnValue;
	    }
	    
	    /**
	     * @programId : MKT_MNG_P02
	     * @name : addCampaignWorkflowTemplate
	     * @date : 2016. 1. 5.
	     * @author : "류동균"
	     * @table : mkt.mkt_wf_template_mst
	     * @return :
	     * @description : 캠페인 워크플로우 템플릿 수정
	     */
	    public StatusResDto editCampaignWorkflowTemplate(LoyCampaignWorkflowTemplateReqDto mcwtr) {
	        LogUtil.param(this.getClass(), mcwtr);

	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue.setSuccess(false);

	        cmpMapper.updateCampaignWorkflowTemplate(mcwtr);

	        rtnValue.setSuccess(true);

	        return rtnValue;
	    }
	    
	    /**
	     * @programId : MKT_MNG_P02
	     * @name : getCampaignWorkflowStatusList
	     * @date : 2015. 10. 19.
	     * @author : 류동균
	     * @table : mkt.mkt_cmn_wf_cam
	     * @return :
	     * @description : 캠페인 워크플로우 진행현황 목록
	     */
	    @SuppressWarnings("unchecked")
	    public List<CampaignWorkflowStatusListResDto> getCampaignWorkflowStatusList(LoyCampaignWorkflowStatusReqDto mcwsr) {
	        LogUtil.param(this.getClass(), mcwsr);
	        mcwsr.setSVCAlias("wfc");

	        return cmpMapper.selectCampaignWorkflowStatusList(mcwsr);
	    }
	    
	    /**
	     * @programId : MKT_MNG_P02
	     * @name : getCampaignDefaultInfo
	     * @date : 2015. 10. 16.
	     * @author : 류동균
	     * @table : mkt.mkt_campaign
	     * @return :
	     * @description : 캠페인 기본정보 조회
	     */
	    public LoyPromotionDefaultInfoResDto getCampaignDefaultInfo(LoyCampaignReqDto mcr) {
	        LogUtil.param(this.getClass(), mcr);

	        LoyPromotionDefaultInfoResDto rtnValue = new LoyPromotionDefaultInfoResDto();

	        //mcr.setSVCAlias("mtt");
	        rtnValue = cmpMapper.selectCampaignDefaultInfo(mcr);
	        /*rtnValue.setSuccess(true);*/
	        return rtnValue;
	    }
	    @Transactional
		public StatusResDto saveCampaignWorkflow(LoyCampaignWorkflowReqDto mcwr) {
			LogUtil.param(this.getClass(), mcwr);

			String lang = mcwr.getLang();

			boolean saveFlag = true;
			// 캠페인 상태 저장여부 확인
			if (WORKFLOW_SAVE_TYPE.WF.name().equals(mcwr.getSaveType())) {
				// 확인 후 예외 Exception
				//checkCampaignStatusSaveFlag(mcwr.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());
			} else if (WORKFLOW_SAVE_TYPE.NODE.name().equals(mcwr.getSaveType())) {
				// 확인 후 예외 false 반환
				LoyCampaignReqDto mcr = new LoyCampaignReqDto();
				mcr.setId(mcwr.getCampaignId());
				mcr.setNodeType(CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());

				//saveFlag = checkCampaignStatusSaveFlag(mcr);
			} else {
				saveFlag = false;
			}

			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(true);

			String workflowId = "";

			// 저장여부 확인
			if (saveFlag) {
				if (ObjectUtil.isNotEmpty(mcwr.getWorkflowTask())) {
					// 워크플로우 전체 테스크 저장(헤더/노드/커넥터)
					WorkflowTaskReqDto mwtr = mcwr.getWorkflowTask();
					mwtr.setLang(lang);
					mwtr.setCreateBy(mcwr.getCreateBy());
					mwtr.setModifyBy(mcwr.getModifyBy());

					rtnValue = workflowSubService.saveWorkflowTask(mwtr);
					saveFlag = rtnValue.getSuccess();
					workflowId = rtnValue.getMessage();
					mcwr.setWorkflowId(workflowId);
				} else {
					saveFlag = false;
				}
			}
			rtnValue.setSuccess(false);
			// 저장여부 확인
			if (saveFlag) {
				// this.startTransaction();

				// 캠페인 워크플로우 진핸현황 전체 삭제 처리 후 업데이트한다.
				LoyCampaignWorkflowStatusReqDto mcwsr = new LoyCampaignWorkflowStatusReqDto();
				mcwsr.setLang(lang);
				mcwsr.setCreateBy(mcwr.getCreateBy());
				mcwsr.setModifyBy(mcwr.getModifyBy());
				mcwsr.setCampaignId(mcwr.getCampaignId()); // 캠페인 ID
				mcwsr.setWorkflowId(mcwr.getWorkflowId()); // 워크플로우 ID
				cmpMapper.deleteAllCampaignWorkflowStatusByWorkflowId(mcwsr);
				rtnValue.setSuccess(true);

				for (LoyCampaignWorkflowNodeDataReqDto mcwndr : mcwr.getNodeList()) {

					LogUtil.debug(" --------------------->> NODE : " + mcwndr.getTaskType());
					
					if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.OFFER.name().equals(mcwndr.getTaskType())
							&& ObjectUtil.isNotEmpty(mcwndr.getData().getCampaignOffer())) {
						/*
						 * 캠페인 혜택 저장 OFFER
						 */
						LoyCampaignOfferReqDto mcor = mcwndr.getData().getCampaignOffer();
						mcor.setLang(lang);
						mcor.setCreateBy(mcwr.getCreateBy());
						mcor.setModifyBy(mcwr.getModifyBy());
						mcor.setCampaignId(mcwndr.getActualTaskId());
						mcor.setDataStatus(mcwndr.getTaskDataStatus());

						LogUtil.debug(" --------------------->> 오퍼 걸림 ");

						// 노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
						if (ObjectUtil.isEmpty(mcwndr.getCampaignId())
								|| TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {

							LogUtil.debug(" --------------------->> 오퍼 관계 삭제 ");
							
							// 캠페인 오퍼 전체 삭제
							rtnValue = removeCampaignOfferRelByCampaignId(mcor);
							mcwndr.setActualTaskId(null);
						}

						// 노드의 이전 캠페인 ID와 현재 캠페인 ID가 틀리다면 이전 캠페인 업무 데이터 삭제
						if (ObjectUtil.isNotEmpty(mcwndr.getOldCampaignId())
								&& mcwndr.getOldCampaignId().equals(mcwndr.getCampaignId()) == false) {
							rtnValue = removeCampaignOfferRelByCampaignId(mcor);
						}
					}
					
					/*
					 * RULESET
					 */
					if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.RULESET.name().equals(mcwndr.getTaskType())) {

						LoyRuleSetMstReqDto rsmr = new LoyRuleSetMstReqDto();
						rsmr.setRidMktCamMst(mcwndr.getCampaignId());
						rsmr.setSystemColumn(mcwr.getSystemColumn());

						// 노드의 캠페인ID가 존재하고 데이터 상태가 'D'이면 해당 룰셋 삭제
						if (ObjectUtil.isNotEmpty(mcwndr.getCampaignId())
								&& TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
							ruleSetService.removeLoyRuleSet(rsmr);
						}
					}
					
					if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SMS.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.LMS.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.MMS.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.PUSH.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.EMAIL.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.CALL.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INSTAGRAM.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.FACEBOOK.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TERMINAL.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.WEB.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAO.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAONOTICE.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.RECEIPT.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.APPNOTICE.name().equals(mcwndr.getTaskType())
							|| CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TM.name().equals(mcwndr.getTaskType())
							) {
						/*
						 * 캠페인 채널 관계 저장
						 * SMS, LMS, MMS, PUSH, EMAIL, CALL
						 */
						MktCampaignContentsChnnelRelReqDto mcccrr = new MktCampaignContentsChnnelRelReqDto();
						mcccrr.setLang(lang);
						mcccrr.setCreateBy(mcwr.getCreateBy());
						mcccrr.setModifyBy(mcwr.getModifyBy());
						mcccrr.setCampaignId(mcwndr.getCampaignId());
						mcccrr.setChnnelTypeCode(mcwndr.getTaskType());
						mcccrr.setId(mcwndr.getActualTaskId());

						//노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
						if (ObjectUtil.isEmpty(mcwndr.getCampaignId())
								|| TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {

							//캠페인 콘텐츠 채널 관계 삭제
							rtnValue = removeCampaignContentsChnnelRel(mcccrr);
							mcwndr.setActualTaskId(null);
						}

						//노드의 이전 캠페인 ID와 현재 캠페인 ID가 틀리다면 이전 캠페인 업무 데이터 삭제
						if (ObjectUtil.isNotEmpty(mcwndr.getOldCampaignId())
								&& !mcwndr.getOldCampaignId().equals(mcwndr.getCampaignId())) {

							//캠페인 콘텐츠 채널 관계 삭제
							rtnValue = removeCampaignContentsChnnelRel(mcccrr);
						}
					}

					/*
					 * 캠페인 워크플로우 진행현황 등록
					 */
					if (!TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
						mcwsr.setLang(lang);
						mcwsr.setCampaignId(mcwndr.getCampaignId());
						mcwsr.setTaskId(mcwndr.getTaskId()); // 테스크아이디
						mcwsr.setTaskName(mcwndr.getNodeName()); // 테스크명
						mcwsr.setStatusCode(mcwr.getStatusCode()); // 상태
						mcwsr.setTaskTypeCode(mcwndr.getNodeType()); // 테스크유형
						mcwsr.setActualTaskId(mcwndr.getActualTaskId()); // 실제업무 ID
						mcwsr.setId(mcwndr.getCampaignWfRelId());
						if (ObjectUtil.isEmpty(mcwsr.getId())) {
							rtnValue = addCampaignWorkflowStatus(mcwsr);
						} else {
							rtnValue = editCampaignWorkflowStatus(mcwsr);
						}
					}
				}

				// 캠페인 워크플로우 관계 설정
				rtnValue = editCampaignWorkflowRel(mcwr);

				// 템플릿 설정일경우 워크플로우 관계 설정
				LoyCampaignWorkflowTemplateReqDto mcwtr = new LoyCampaignWorkflowTemplateReqDto();
				mcwtr.setLang(lang);
				// mcwtr.setAppServiceId(appServiceId);
				// mcwtr.setCountry(country);
				mcwtr.setCampaignId(mcwr.getCampaignId());
				mcwtr.setModifyBy(mcwr.getModifyBy());
				mcwtr.setWorkflowId(mcwr.getWorkflowId());
				rtnValue = editCampaignWorkflowTemplate(mcwtr);

				// this.commitTransaction();

			}

			// 캠페인 및 워크플로우 아이디 반환(JSON Text)
			String rtnText = "{'campaignId' : '" + mcwr.getCampaignId() + "', 'workflowId' : '" + workflowId + "'}";
			rtnValue.setMessage(rtnText);

			return rtnValue;
		}

		/**
		 * @programId : MKT_MNG_002
		 * @name : getCampaignWorkflowStatusList
		 * @date : 2015. 10. 19.
		 * @author : 류동균
		 * @table :
		 * @return :
		 * @description : 캠페인 워크플로우 진행현황 및 데이터 조회
		 */

		public List<CampaignWorkflowStatusListResDto> getCampaignWorkflowStatusList(LoyCampaignWorkflowReqDto mcwr) {
			LogUtil.param(this.getClass(), mcwr);

			String lang = mcwr.getLang();

			// 캠페인 진행현황 목록
			List<CampaignWorkflowStatusListResDto> resultList = new ArrayList<CampaignWorkflowStatusListResDto>();

			LoyCampaignWorkflowStatusReqDto mcwsr = new LoyCampaignWorkflowStatusReqDto();
			mcwsr.setLang(lang);
			mcwsr.setCampaignId(mcwr.getCampaignId());
			mcwsr.setWorkflowId(mcwr.getWorkflowId());

			for (CampaignWorkflowStatusListResDto status : getCampaignWorkflowStatusList(mcwsr)) {
				CampaignWorkflowDataResDto data = new CampaignWorkflowDataResDto();
				if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name().equals(status.getTaskTypeCode())) {
					/*
					 * 캠페인 기본정보 INFO
					 */
					LoyCampaignReqDto mcr = new LoyCampaignReqDto();
					mcr.setRid(mcwr.getCampaignId());
					data.setCampaignDefaultInfo(getCampaignDefaultInfo(mcr));

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
						// 제목 설정
						status.setTitle(data.getCampaignDefaultInfo().getPromNm());
						// 내용 설정
						status.setText(data.getCampaignDefaultInfo().getPromNm());
						// 최근 입력시간 설정
						String date = data.getCampaignDefaultInfo().getModifyDate();
						long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
								date, "yyyy-MM-dd HH:mm");
						status.setEnterTime(Long.toString(time));

						// 데이터 설정
						status.setData(data);
					}
				}
			
				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.OFFER.name().equals(status.getTaskTypeCode())) {
					/*
					 * 캠페인 혜택 OFFER
					 */
					LoyCampaignOfferReqDto mcor = new LoyCampaignOfferReqDto();
					mcor.setLang(lang);
					mcor.setCampaignId(mcwr.getCampaignId());
					mcor.setSVCAlias("cor");
					CampaignOfferResDto campaignOffer = new CampaignOfferResDto();
					campaignOffer.setOfferList(cmpMapper.selectCampaignOfferList(mcor));
					data.setCampaignOffer(campaignOffer);

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(data.getCampaignOffer())
							&& ObjectUtil.isNotEmpty(data.getCampaignOffer().getOfferList())) {
						// 내용 설정
						status.setText(data.getCampaignOffer().getOfferList().get(0).getOfferName());
						// 최근 입력시간 설정
						String date = data.getCampaignOffer().getOfferList().get(0).getModifyDate();
						long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
								date, "yyyy-MM-dd HH:mm");
						status.setEnterTime(Long.toString(time));

						// 데이터 설정
						// status.setData(data);
					}
				}
			

				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.APPROVAL.name().equals(status.getTaskTypeCode())) {
					/*
					 * 캠페인 승인 APPROVAL
					 */
					CampaignApprovalReqDto mcar = new CampaignApprovalReqDto();
					mcar.setLang(lang);
					mcar.setCampaignId(mcwr.getCampaignId());
					mcar.setSVCAlias("ea");
					LoyCampaignApprovalResDto campaignApproval = new LoyCampaignApprovalResDto();
					campaignApproval = cmpMapper.selectCampaignApproval(mcar);

					data.setCampaignApproval(campaignApproval);

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(data.getCampaignApproval())) {
						// 제목 설정
						// status.setTitle(data.getCampaignApproval().());
						// 최근 입력시간 설정
						String date = data.getCampaignApproval().getModifyDate();
						long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
								date, "yyyy-MM-dd HH:mm");
						status.setEnterTime(Long.toString(time));

						// 데이터 설정
						// status.setData(data);
					}
				}
				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETACT.name().equals(status.getTaskTypeCode())) {
					/*
					 * 캠페인 기본정보 INFO
					 */
					LoyCampaignReqDto mcr = new LoyCampaignReqDto();
					mcr.setRid(mcwr.getCampaignId());
					data.setPromotionActionInfo(getPromotionActionInfo(mcr));

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(data.getPromotionActionInfo())) {
						// 제목 설정
						status.setTitle(data.getPromotionActionInfo().getQpntTypeCd());
						// 내용 설정
						status.setText(data.getPromotionActionInfo().getQpntTypeCd());
						// 최근 입력시간 설정
						String date = data.getPromotionActionInfo().getModifyDate();
						/*long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
								date, "yyyy-MM-dd HH:mm");
						status.setEnterTime(Long.toString(time));*/

						// 데이터 설정
						status.setData(data);
					}
				}
//				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name().equals(status.getTaskTypeCode())) {
//					/*
//					 * 캠페인 기본정보 INFO
//					 */
//					LoyCampaignReqDto mcr = new LoyCampaignReqDto();
//					mcr.setRid(mcwr.getCampaignId());
//					String promTypeLv2Cd = cmpMapper.selectPromStatCd(mcr);
//					
//					if("SA1GEN".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulSa1GenInfo(getPrulSa1GenInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulSa1GenInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulSa1GenInfo().getPayMethTypeCd());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulSa1GenInfo().getPayMethTypeCd());
//							// 최근 입력시간 설정
//							String date = data.getPromotionRuleInfo().getLoyPrulSa1GenInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//						
//					} 
//					else if("SA1ANI".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulSa1AniInfo(getPrulSa1AniInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulSa1AniInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulSa1AniInfo().getConditionCd());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulSa1AniInfo().getConditionCd());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("SA2CNT".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulSa1SumInfo(getPrulSa2SumInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo().getOfrAmtType());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo().getOfrAmtType());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("SA2AMT".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulSa1SumInfo(getPrulSa2SumInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo().getOfrAmtType());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulSa1SumInfo().getOfrAmtType());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC1JOIN".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulAc1JoinInfo(getPrulAc1JoinInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulAc1JoinInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulAc1JoinInfo().getPrulJoinChnlCd());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulAc1JoinInfo().getPrulJoinChnlCd());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC1FAM".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulAc1FamInfo(getPrulAc1FamInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulAc1FamInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulAc1FamInfo().getPrulFamCd());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulAc1FamInfo().getPrulFamCd());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC1CLB".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulAc1ClbInfo(getPrulAc1ClbInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulAc1ClbInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulAc1ClbInfo().getClubNm());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulAc1ClbInfo().getClubNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					}
//					else if("AC1CARD".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulAc1CardInfo(getPrulAc1CardInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulAc1CardInfo())) {
//							// 제목 설정
//							status.setTitle(data.getPromotionRuleInfo().getLoyPrulAc1CardInfo().getChnlTgtGrpNm());
//							// 내용 설정
//							status.setText(data.getPromotionRuleInfo().getLoyPrulAc1CardInfo().getChnlTgtGrpNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC1FRND".equals(promTypeLv2Cd)) {
//						data.getPromotionRuleInfo().setLoyPrulAc1FrndInfo(getPrulAc1FrndInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getPromotionRuleInfo().getLoyPrulAc1FrndInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC2ON".equals(promTypeLv2Cd)) {
//						data.setLoyPrulAc2OnInfo(getPrulAc2OnInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC2SUR".equals(promTypeLv2Cd)) {
//						data.setLoyPrulAc2SurInfo(getPrulAc2SurInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC2AGR".equals(promTypeLv2Cd)) {
//						data.setLoyPrulAc2AgrInfo(getPrulAc2AgrInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC2CON".equals(promTypeLv2Cd)) {
//						data.setLoyPrulAc2ConInfo(getPrulAc2ConInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					} 
//					else if("AC2ADD".equals(promTypeLv2Cd)) {
//						data.setLoyPrulAc2AddInfo(getPrulAc2AddInfo(mcr));
//						
//						// 상태 정보 설정
//						if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
//							// 제목 설정
//							status.setTitle(data.getCampaignDefaultInfo().getPromNm());
//							// 내용 설정
//							status.setText(data.getCampaignDefaultInfo().getPromNm());
//							// 최근 입력시간 설정
//							String date = data.getCampaignDefaultInfo().getModifyDate();
//							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
//									date, "yyyy-MM-dd HH:mm");
//							status.setEnterTime(Long.toString(time));
//
//							// 데이터 설정
//							status.setData(data);
//						}
//					}

				//}
			
				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.RULESET.name().equals(status.getTaskTypeCode())) {
					/*
					 * RuleSet RULESET
					 */

					// 캠페인 기본정보 조회
					LoyCampaignReqDto mcr = new LoyCampaignReqDto();
					mcr.setId(mcwr.getCampaignId());
					mcr.setSVCAlias("mtt");
					LoyPromotionDefaultInfoResDto defaultInfo = cmpMapper.selectCampaignDefaultInfo(mcr);

					// RuleSet 조회
					LoyRuleSetReqDto rsr = new LoyRuleSetReqDto();
					rsr.setSystemColumn(mcwr.getSystemColumn());
					rsr.setRidMktCamMst(status.getActualTaskId());

					LoyRuleSetResDto ruleSet = ruleSetService.getRuleSet(rsr);
					data.setRuleSet(ruleSet);

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(defaultInfo) && ObjectUtil.isNotEmpty(data.getRuleSet())) {

						String date = defaultInfo.getModifyDate();

						if (ObjectUtil.isNotEmpty(date)) {
							// 최근 입력시간 설정
							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
									date, "yyyy-MM-dd HH:mm");
							status.setEnterTime(Long.toString(time));
						}

						// 데이터 설정
						// status.setData(data);
					}
				}
				else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KPI.name().equals(status.getTaskTypeCode())) {
					/*
					 * RuleSet RULESET
					 */

					// 캠페인 기본정보 조회
					LoyCampaignReqDto mcr = new LoyCampaignReqDto();
					mcr.setId(mcwr.getCampaignId());
					/*mcr.setSVCAlias("mtt");*/
					LoyPromotionDefaultInfoResDto defaultInfo = cmpMapper.selectCampaignDefaultInfo(mcr);

					// RuleSet 조회
					LoyRuleSetReqDto rsr = new LoyRuleSetReqDto();
					rsr.setSystemColumn(mcwr.getSystemColumn());
					rsr.setRidMktCamMst(status.getActualTaskId());

					LoyRuleSetResDto ruleSet = ruleSetService.getRuleSet(rsr);
					data.setRuleSet(ruleSet);

					// 상태 정보 설정
					if (ObjectUtil.isNotEmpty(defaultInfo) && ObjectUtil.isNotEmpty(data.getRuleSet())) {

						String date = defaultInfo.getModifyDate();

						if (ObjectUtil.isNotEmpty(date)) {
							// 최근 입력시간 설정
							long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm",
									date, "yyyy-MM-dd HH:mm");
							status.setEnterTime(Long.toString(time));
						}

						// 데이터 설정
						// status.setData(data);
					}
				}
				resultList.add(status);
			}

			return resultList;
		}

		/**
		 * @programId :
		 * @name : checkCampaignStatusSaveFlagFlag
		 * @date : 2016. 3. 18.
		 * @author : "류동균"
		 * @table : mkt.mkt_cam_mst
		 * @return :
		 * @description : 캠페인 상태에 따른 저장여부 exception 발생
		 */
		public LoyPromotionActionDetailResDto getPromotionActionInfo(LoyCampaignReqDto mcwr) {
	        LogUtil.param(this.getClass(), mcwr);
	        return cmpMapper.selectPromotionActionInfo(mcwr);
		}
		
		/**
		 * @programId :
		 * @name : checkCampaignStatusSaveFlagFlag
		 * @date : 2016. 3. 18.
		 * @author : "류동균"
		 * @table : mkt.mkt_cam_mst
		 * @return :
		 * @description : 캠페인 상태에 따른 저장여부 exception 발생
		 */
		public void checkCampaignStatusSaveFlag(String campaignId, String nodeType) {
			// 캠페인 아이디가 존재할 경우에만 확인
			if (campaignId != null && !"".equals(campaignId)) {
				LoyCampaignReqDto mcr = new LoyCampaignReqDto();
				mcr.setId(campaignId);
				mcr.setNodeType(nodeType);

				//boolean rtnValue = checkCampaignStatusSaveFlag(mcr);

				/*if (!rtnValue) {
					LogUtil.error("The state can not save the campaign.");
					throw new DataBadRequestException();
				}*/
			}
		}

		/**
		 * @programId :
		 * @name : checkCampaignStatusSaveFlagFlag
		 * @date : 2016. 3. 18.
		 * @author : "류동균"
		 * @table : mkt.mkt_cam_mst
		 * @return :
		 * @description : 캠페인 상태에 따른 저장여부
		 */

		public boolean checkCampaignStatusSaveFlag(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			boolean rtnValue = false;

			/**
			 * 1. 캠페인 아이디가 존재할 경우에만 확인 없을 경우 [저장 가능]
			 */
			if (mcr.getRid() != null && !"".equals(mcr.getRid())) {
				String status = cmpMapper.selectCampaignStatus(mcr);
				String chnlType = mcr.getNodeType();

				/**
				 * 2. ROI, MONITORING 모든 상태에서 [저장 가능]
				 */
			/*	if (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.ROI.name().equals(chnlType)
						|| CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.MONITORING.name().equals(chnlType)) {
					return rtnValue = true;
				}*/

				/**
				 * 3. 작성중일 경우 모두 [저장 가능]
				 */
				/* else */ if (CommonUtil.CAMPAIGN_STATUS_TYPE.W.name().equals(status)) {
					return true;
				}

				/**
				 * 4. 완료, 취소, 활성 상태일 경우 [저장 불가]
				 */
				else if (CommonUtil.CAMPAIGN_STATUS_TYPE.E.name().equals(status)
						|| CommonUtil.CAMPAIGN_STATUS_TYPE.C.name().equals(status)
						|| CommonUtil.CAMPAIGN_STATUS_TYPE.A.name().equals(status)
						|| CommonUtil.CAMPAIGN_STATUS_TYPE.S.name().equals(status)) {
					return  false;
				}

				/**
				 * 5. 그외의 경우 해당 노드 유형만 [저장 가능]
				 */
				else {
					for (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION node : CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.values()) {
						if (node.name().equals(chnlType)) {
							return  true;
						}
					}
				}
			} else {
				return true;
			}

			return rtnValue;
		}
		
		/**
		 * @programId :
		 * @name : checkCampaignStatusSaveFlagFlag
		 * @date : 2016. 3. 18.
		 * @author : "류동균"
		 * @table : mkt.mkt_cam_mst
		 * @return :
		 * @description : 캠페인 상태에 따른 저장여부
		 */

		public boolean checkPromotionStatusSaveFlag(LoyPromotionDefaultInfoReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			boolean rtnValue = false;

			/**
			 * 1. 캠페인 아이디가 존재할 경우에만 확인 없을 경우 [저장 가능]
			 */
			if (mcr.getRid() != null && !"".equals(mcr.getRid())) {
				String status = cmpMapper.selectPromotionStatus(mcr);
				String chnlType = mcr.getNodeType();

				/**
				 * 2. ROI, MONITORING 모든 상태에서 [저장 가능]
				 */
			/*	if (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.ROI.name().equals(chnlType)
						|| CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.MONITORING.name().equals(chnlType)) {
					return rtnValue = true;
				}*/

				/**
				 * 3. 작성중일 경우 모두 [저장 가능]
				 */
				/* else */ if (CommonUtil.CAMPAIGN_STATUS_TYPE.W.name().equals(status)) {
					return true;
				}

				/**
				 * 4. 완료, 취소 상태일 경우 [저장 불가]
				 */
				else if (CommonUtil.CAMPAIGN_STATUS_TYPE.E.name().equals(status)
						|| CommonUtil.CAMPAIGN_STATUS_TYPE.C.name().equals(status)) {
					return  false;
				}

				/**
				 * 5. 그외의 경우 해당 노드 유형만 [저장 가능]
				 */
				else {
					for (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION node : CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.values()) {
						if (node.name().equals(chnlType)) {
							return  true;
						}
					}
				}
			} else {
				return true;
			}

			return rtnValue;
		}



		public StatusResDto saveCampaignDefaultInfo(LoyCampaignDefaultInfoReqDto mcdir) {
			LogUtil.param(this.getClass(), mcdir);

			// 캠페인 상태 저장여부 확인
			// checkCampaignStatusSaveFlag(mcdir.getId(),
			// CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());

			// 캠페인 상태 저장여부 확인
			LoyCampaignReqDto mcr = new LoyCampaignReqDto();
			mcr.setId(mcdir.getId());
			mcr.setNodeType(CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());
			//boolean saveFlag = checkCampaignStatusSaveFlag(mcr);

			StatusResDto rtnValue = new StatusResDto();
			// 캠페인 상태 저장여부 true 기본정보 전체 저장
			// 캠페인 상태 정장여부 false 기본정보 비고 수정
			//if (saveFlag) {
				// 캠페인아이디 확인
				if (ObjectUtil.isNotEmpty(mcdir.getId())) {
					// 수정
					rtnValue = editCampaignDefaultInfo(mcdir);
					rtnValue.setMessage(mcdir.getId());
				} else {
					// 등록
					rtnValue = addCampaignDefaultInfo(mcdir);
					mcdir.setId(rtnValue.getMessage());
				}
			//} else {
				// 캠페인 기본정보 비고 수정
				rtnValue = editCampaignDefaultInfoDesc(mcdir);
				rtnValue.setMessage(mcdir.getId());
			//}
			rtnValue.setSuccess(true);
			return rtnValue;
		}

		public StatusResDto editCampaignDefaultInfo(LoyCampaignDefaultInfoReqDto mcdir) {
			LogUtil.param(this.getClass(), mcdir);

			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);

			// 캠페인 유형에 따른 type
			if (mcdir.getCampaignTypeCode().equals("PROMOTION")) {
				mcdir.setType("LOY");
			} else {
				mcdir.setType("MKT");
			}

			cmpMapper.updateCampaignMaster(mcdir);

			rtnValue.setSuccess(true);

			return rtnValue;
		}

		public StatusResDto addCampaignDefaultInfo(LoyCampaignDefaultInfoReqDto mcdir) {
			LogUtil.param(this.getClass(), mcdir);

			// 아이디 생성
			StatusResDto rtnValue = new StatusResDto();
			String id = CommonUtil.newRid();
			mcdir.setId(id);

			// 캠페인 유형에 따른 type
			if (mcdir.getCampaignTypeCode().equals("PROMOTION")) {
				mcdir.setType("LOY");
			} else {
				mcdir.setType("MKT");
			}

			cmpMapper.insertCampaignMaster(mcdir);
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);

			return rtnValue;
		}

		public StatusResDto editCampaignDefaultInfoDesc(LoyCampaignDefaultInfoReqDto mcdir) {
			LogUtil.param(this.getClass(), mcdir);

			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);

			cmpMapper.updateCampaignDefaultInfoDesc(mcdir);

			rtnValue.setSuccess(true);

			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromotionListNew
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 23.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public GridPagingResDto<LoyPromotionListResDto> getPromotionListNew(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return new GridPagingResHelper<LoyPromotionListResDto>().newGridPagingResDto( 
					mcr.init(CommonUtil.getInstance().getDBType()),
					cmpMapper.selectPromotionListNew(mcr),AnnotationType.CommCode);  
		}



		 /*
		  * 1. 메소드명: savePromotionDefaultInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 24.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionDefaultInfo(LoyPromotionDefaultInfoReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			// 캠페인 상태 저장여부 확인
			// checkCampaignStatusSaveFlag(mcdir.getId(),
			// CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());

			// 캠페인 상태 저장여부 확인
			LoyPromotionDefaultInfoReqDto mcr2 = new LoyPromotionDefaultInfoReqDto();
			mcr2.setRid(mcr.getRid());
			mcr2.setNodeType(CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());
			//boolean saveFlag = checkPromotionStatusSaveFlag(mcr2);

			StatusResDto rtnValue = new StatusResDto();
			// 캠페인 상태 저장여부 true 기본정보 전체 저장
			// 캠페인 상태 정장여부 false 기본정보 비고 수정
			//if (saveFlag) {
				// 캠페인아이디 확인
				if (ObjectUtil.isNotEmpty(mcr.getRid())) {
					// 수정
					//cmpMapper.updatePromotionMaster(mcr);
					cmpMapper.updatePromotionMaster(mcr);
					rtnValue.setMessage(mcr.getRid());
					rtnValue.setSuccess(true);
				} else {
					mcr.setRid(CommonUtil.newRid());
					cmpMapper.insertPromotionMaster(mcr);
					//mcr.setRid(rtnValue.getMessage());
					rtnValue.setMessage(mcr.getRid());
					rtnValue.setSuccess(true);
					// 등록
				}
			//} /*else {
				// 캠페인 기본정보 비고 수정
				//rtnValue = editCampaignDefaultInfoDesc(mcr);
				//rtnValue.setMessage(mcr.getRid());
			//}
			//rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getTgtGrpIncList
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 24.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public GridPagingResDto<LoyTgtGrpListResDto> getTgtGrpIncList(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return new GridPagingResHelper<LoyTgtGrpListResDto>().newGridPagingResDto( 
					mcr.init(CommonUtil.getInstance().getDBType()),
					cmpMapper.selectTgtGrpIncList(mcr),AnnotationType.CommCode);  
		}



		 /*
		  * 1. 메소드명: savePromotionKpi
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 26.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionKpi(LoyPromotionKpiDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isNotEmpty(mcr.getRid())) {
				// 수정
				cmpMapper.updatePromotionKpi(mcr);
				rtnValue.setMessage(mcr.getRid());
				rtnValue.setSuccess(true);
			} else {
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionKpi(mcr);
				rtnValue.setMessage(mcr.getRid());
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromKpiInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 26.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionKpiDetailResDto getPromKpiInfo(LoyPromotionKpiDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromKpiInfo(mcr);
		}

		 /*
		  * 1. 메소드명: getActionTierList
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 29.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public List<LoyPromotionActionTierList> getActionTierList(LoyPromotionDefaultInfoReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectActionTierList(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionAction
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 29.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		@Transactional
		public StatusResDto savePromotionAction(LoyPromotionActionDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			if(ObjectUtil.isEmpty(mcr.getRid())) {
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAction(mcr);
			} else {
				cmpMapper.updatePromotionAction(mcr);
			}
			
			//cmpMapper.deletePromotionActionTier(mcr);
			
			if(ObjectUtil.isNotEmpty(mcr.getPromotionTierAction())) {
				for(LoyPromotionTierActionReqDto tierAction : mcr.getPromotionTierAction()) {
					tierAction.setModifyBy(mcr.getModifyBy());
					tierAction.setCreateBy(mcr.getCreateBy());
					tierAction.setPromRid(mcr.getPromRid());
					tierAction.setPromActRid(mcr.getRid());
					
					if(!"".equals(tierAction.getTierGroupRid())
							|| !"".equals(tierAction.getTierRid())
							|| !"".equals(tierAction.getOfrAmtType())
							|| !"".equals(tierAction.getOfrAmt())) {
						if(ObjectUtil.isEmpty(tierAction.getRid())) {
							tierAction.setRid(CommonUtil.newRid());
							cmpMapper.insertPromotionTierAction(tierAction);
						} else {
							cmpMapper.updatePromotionTierAction(tierAction);
						}
					}
				}
			}
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromActionInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 30.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionActionDetailResDto getPromActionInfo(LoyPromotionActionDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			LoyPromotionActionDetailResDto rtnValue = new LoyPromotionActionDetailResDto();
			ArrayList<LoyPromotionTierActionDetailResDto> promTierActionDto = new ArrayList<LoyPromotionTierActionDetailResDto>();
			
			rtnValue = cmpMapper.selectPromActionInfo(mcr);
			
			if(ObjectUtil.isNotEmpty(rtnValue)) {
			mcr.setPromActionRid(rtnValue.getRid());
			promTierActionDto = cmpMapper.selectPromTierAction(mcr);
			rtnValue.setPromotionTierAction(promTierActionDto);
			}
			
			
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: removeActionTier
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 6. 30.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeActionTier(LoyPromotionTierActionReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteActionTier(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromRuleInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionDetailResDto getPromRuleInfo(LoyPromotionTierActionReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromRuleInfo(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionRule(LoyPromotionRuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.updatePromotion(mcr);

			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionSa1Rule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		@Transactional
		public StatusResDto savePromotionSa1Rule(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			if(ObjectUtil.isEmpty(mcr.getRid())) {
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionSa1Rule(mcr);
			} else {
				cmpMapper.updatePromotionSa1Rule(mcr);
			}
			
			if(ObjectUtil.isNotEmpty(mcr.getPromotionSalXmRuleDetail())) {
				for(LoyPromotionSa1XmRuleDetailReqDto Sa1XmRule : mcr.getPromotionSalXmRuleDetail()) {
					Sa1XmRule.setModifyBy(mcr.getModifyBy());
					Sa1XmRule.setCreateBy(mcr.getCreateBy());
					Sa1XmRule.setPromRid(mcr.getPromRid());
					Sa1XmRule.setPaulSa1genRid(mcr.getRid());
					
				if(!"".equals(Sa1XmRule.getStartVal()) 
						|| !"".equals(Sa1XmRule.getEndVal()) 
						|| !"".equals(Sa1XmRule.getEffStrtDayCnt()) 
						|| !"".equals(Sa1XmRule.getOfrAmt()) 
						|| !"".equals(Sa1XmRule.getOfrAmtType())
						|| !"".equals(Sa1XmRule.getOfrRid())) {
					if(ObjectUtil.isEmpty(Sa1XmRule.getRid())) {
						Sa1XmRule.setRid(CommonUtil.newRid());
						cmpMapper.insertPromotionSa1XmRule(Sa1XmRule);
					} else {
						cmpMapper.updatePromotionSa1XmRule(Sa1XmRule);
					}
				}
				}
			}
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getChnlTgtGrpList
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public GridPagingResDto<LoyChnlTgtGrpResDto> getChnlTgtGrpList(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return new GridPagingResHelper<LoyChnlTgtGrpResDto>().newGridPagingResDto( 
					mcr.init(CommonUtil.getInstance().getDBType()),
					cmpMapper.selectChnlTgtGrpList(mcr),AnnotationType.CommCode);  
		}



		 /*
		  * 1. 메소드명: getProdTgtGrpList
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public GridPagingResDto<LoyProdTgtGrpResDto> getProdTgtGrpList(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return new GridPagingResHelper<LoyProdTgtGrpResDto>().newGridPagingResDto( 
					mcr.init(CommonUtil.getInstance().getDBType()),
					cmpMapper.selectProdTgtGrpList(mcr),AnnotationType.CommCode);  
		}



		 /*
		  * 1. 메소드명: getPromSa1RuleInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionSa1RuleDetailResDto getPromSa1RuleInfo(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			LoyPromotionSa1RuleDetailResDto rtnValue = new LoyPromotionSa1RuleDetailResDto();
			ArrayList<LoyPromotionSa1XmRuleDetailResDto> promSa1XmRuleDto = new ArrayList<LoyPromotionSa1XmRuleDetailResDto>();
			
			rtnValue = cmpMapper.selectPromSa1RuleInfo(mcr);
			
			if(ObjectUtil.isNotEmpty(rtnValue)) {
			mcr.setPrulSa1GenRid(rtnValue.getRid());
			promSa1XmRuleDto = cmpMapper.selectPromSa1XmRuleInfo(mcr);
			rtnValue.setPromotionSalXmRuleDetail(promSa1XmRuleDto);
			}
			
			
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: removeRuleSa1Xm
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeRuleSa1Xm(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteRuleSa1Xm(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: removeSa1Rule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 1.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeSa1Rule(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			cmpMapper.updatePromType(mcr);
			
			if("PUR".equals(mcr.getPrePromTypeLv1Cd()) && "PUR_GEN".equals(mcr.getPrePromTypeLv2Cd())) {
				cmpMapper.deleteSa1Rule(mcr);
				cmpMapper.deleteSa1XmRule(mcr);
			}
			else if("MBR".equals(mcr.getPrePromTypeLv1Cd()) && "ANVRS".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteSa1AniRule(mcr);
			else if("ACT".equals(mcr.getPrePromTypeLv1Cd()) && "CNTCT_CHG".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc2ConRule(mcr);
			else if("MBR".equals(mcr.getPrePromTypeLv1Cd()) && "MKT_AGRE".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc2AgrRule(mcr);
			else if("ACT".equals(mcr.getPrePromTypeLv1Cd()) && "SURVEY".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc2SurRule(mcr);
			else if("PUR".equals(mcr.getPrePromTypeLv1Cd()) && "PUR_CMLTV".equals(mcr.getPrePromTypeLv2Cd())) {
				cmpMapper.deleteSa2SumRule(mcr);
			}
			else if("PUR".equals(mcr.getPrePromTypeLv1Cd()) && "PUR_CMLTV".equals(mcr.getPrePromTypeLv2Cd())) {
				cmpMapper.deleteSa2SumRule(mcr);
			}
			else if("PUR".equals(mcr.getPrePromTypeLv1Cd()) && "PUR_PTR_CMLTV".equals(mcr.getPrePromTypeLv2Cd())) {
				cmpMapper.deleteSa2SumRule(mcr);
			}
			else if("PUR".equals(mcr.getPrePromTypeLv1Cd()) && "PUR_PTR_GEN".equals(mcr.getPrePromTypeLv2Cd())) {
				cmpMapper.deleteSa1Rule(mcr);
				cmpMapper.deleteSa1XmRule(mcr);
			}
			else if("AC2".equals(mcr.getPrePromTypeLv1Cd()) && "AC2ON".equals(mcr.getPrePromTypeLv2Cd())){
				cmpMapper.deleteAc2OnRule(mcr);
			}
			else if("MBR".equals(mcr.getPrePromTypeLv1Cd()) && "ADD_INF".equals(mcr.getPrePromTypeLv2Cd())){
				cmpMapper.deleteAc2AddRule(mcr);
			}
			else if("MBR".equals(mcr.getPrePromTypeLv1Cd()) && "MBR_JOIN".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc1JoinRule(mcr);
			else if("MBR".equals(mcr.getPrePromTypeLv1Cd()) && "RCMNDED".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc1FrndRule(mcr);
//			else if("ACT".equals(mcr.getPrePromTypeLv1Cd()) && "RCMND".equals(mcr.getPrePromTypeLv2Cd()))
//				cmpMapper.deleteAc1FrndRule(mcr);
			else if("FML".equals(mcr.getPrePromTypeLv1Cd()) && "FML_JOIN".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc1FamRule(mcr);
			else if("AC1".equals(mcr.getPrePromTypeLv1Cd()) && "AC1CARD".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc1CardRule(mcr);
			else if("CLB".equals(mcr.getPrePromTypeLv1Cd()) && "CLUB_JOIN".equals(mcr.getPrePromTypeLv2Cd()))
				cmpMapper.deleteAc1ClbRule(mcr);
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionSa1AniRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionSa1AniDetailResDto getPromSa1AniDetail(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromSa1AniDetail(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionSa1AniRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionSa1AniRule(LoyPromotionSa1AniDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionSa1AniRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionSa1AniRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc2ConRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc2ConRule(LoyPromotionAc2ConDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc2ConRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc2ConRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc2AgrRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc2AgrRule(LoyPromotionAc2AgrDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc2AgrRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc2AgrRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromAc2ConDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc2ConDetailResDto getPromAc2ConDetail(LoyPromotionAc2ConDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc2ConDetail(mcr);
		}



		 /*
		  * 1. 메소드명: getPromAc2AgrDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc2AgrDetailResDto getPromAc2AgrDetail(LoyPromotionAc2AgrDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc2AgrDetail(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionAc2SurRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc2SurRule(LoyPromotionAc2SurDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc2SurRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc2SurRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionSa2SumRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionSa2SumRule(ArrayList<LoyPromotionSa2SumDetailReqDto> mcr,LoginResDto loginInfo) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if(ObjectUtil.isNotEmpty(mcr)) {
				for(LoyPromotionSa2SumDetailReqDto Sa2SumRule : mcr) {
					Sa2SumRule.setModifyBy(loginInfo.getId());
					Sa2SumRule.setCreateBy(loginInfo.getId());
					
					if(!"".equals(Sa2SumRule.getStartVal()) 
							|| !"".equals(Sa2SumRule.getEndVal()) 
							|| !"".equals(Sa2SumRule.getEffStrtDayCnt()) 
							|| !"".equals(Sa2SumRule.getOfrAmt()) 
							|| !"".equals(Sa2SumRule.getOfrAmtType())
							|| !"".equals(Sa2SumRule.getOfrRid())) {
						if(ObjectUtil.isEmpty(Sa2SumRule.getRid())) {
							Sa2SumRule.setRid(CommonUtil.newRid());
							cmpMapper.insertPromotionSa2SumRule(Sa2SumRule);
						} else {
							cmpMapper.updatePromotionSa2SumRule(Sa2SumRule);
						}
					}
				}
			}
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc2OnRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @param loginInfo
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc2OnRule(ArrayList<LoyPromotionAc2OnDetailReqDto> mcr,
			LoginResDto loginInfo) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if(ObjectUtil.isNotEmpty(mcr)) {
				for(LoyPromotionAc2OnDetailReqDto Ac2OnRule : mcr) {
					Ac2OnRule.setModifyBy(loginInfo.getId());
					Ac2OnRule.setCreateBy(loginInfo.getId());
					
					if(!"".equals(Ac2OnRule.getEffStrtDayCnt()) 
							|| !"".equals(Ac2OnRule.getOfrAmt()) 
							|| !"".equals(Ac2OnRule.getOfrAmtType())
							|| !"".equals(Ac2OnRule.getOnlActCd())
							|| !"".equals(Ac2OnRule.getOfrRid())) {
						if(ObjectUtil.isEmpty(Ac2OnRule.getRid())) {
							Ac2OnRule.setRid(CommonUtil.newRid());
							cmpMapper.insertPromotionAc2OnRule(Ac2OnRule);
						} else {
							cmpMapper.updatePromotionAc2OnRule(Ac2OnRule);
						}
					}

				}
			}
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromSa2SumRuleInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public ArrayList<LoyPromotionSa2SumDetailResDto> getPromSa2SumRuleInfo(LoyPromotionSa2SumDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			ArrayList<LoyPromotionSa2SumDetailResDto> rtnValue = new ArrayList<LoyPromotionSa2SumDetailResDto>();
			rtnValue = cmpMapper.selectPromSa2SumRuleInfo(mcr);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromAc2OnRuleInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public ArrayList<LoyPromotionAc2OnDetailResDto> getPromAc2OnRuleInfo(LoyPromotionAc2OnDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			ArrayList<LoyPromotionAc2OnDetailResDto> rtnValue = new ArrayList<LoyPromotionAc2OnDetailResDto>();
			rtnValue = cmpMapper.selectPromAc2OnRuleInfo(mcr);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromAc2AddRuleInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public ArrayList<LoyPromotionAc2AddDetailResDto> getPromAc2AddRuleInfo(LoyPromotionAc2AddDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			ArrayList<LoyPromotionAc2AddDetailResDto> rtnValue = new ArrayList<LoyPromotionAc2AddDetailResDto>();
			rtnValue = cmpMapper.selectPromAc2AddRuleInfo(mcr);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc2AddRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 2.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @param loginInfo
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc2AddRule(ArrayList<LoyPromotionAc2AddDetailReqDto> mcr,
				LoginResDto loginInfo) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if(ObjectUtil.isNotEmpty(mcr)) {
				for(LoyPromotionAc2AddDetailReqDto Ac2AddRule : mcr) {
					Ac2AddRule.setModifyBy(loginInfo.getId());
					Ac2AddRule.setCreateBy(loginInfo.getId());

					if(!"".equals(Ac2AddRule.getAddInfoCd())) {
						if(ObjectUtil.isEmpty(Ac2AddRule.getRid())) {
							Ac2AddRule.setRid(CommonUtil.newRid());
							cmpMapper.insertPromotionAc2AddRule(Ac2AddRule);
						} else {
							cmpMapper.updatePromotionAc2AddRule(Ac2AddRule);
						}
					}
				}
			}
			
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc1JoinRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @param loginInfo
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc1JoinRule(LoyPromotionAc1JoinDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc1JoinRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc1JoinRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: savePromotionAc1FrndRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @param loginInfo
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc1FrndRule(LoyPromotionAc1FrndDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc1FrndRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc1FrndRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromAc1FrndDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc1FrndDetailResDto getPromAc1FrndDetail(LoyPromotionAc1FrndDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc1FrndDetail(mcr);
		}



		 /*
		  * 1. 메소드명: getPromAc1JoinDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc1JoinDetailResDto getPromAc1JoinDetail(LoyPromotionAc1JoinDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc1JoinDetail(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionAc1FamRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc1FamRule(LoyPromotionAc1FamDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc1FamRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc1FamRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromAc1FamDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc1FamDetailResDto getPromAc1FamDetail(LoyPromotionAc1FamDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc1FamDetail(mcr);

		}



		 /*
		  * 1. 메소드명: getPromAc1CardDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc1CardDetailResDto getPromAc1CardDetail(LoyPromotionAc1CardDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc1CardDetail(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionAc1CardRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc1CardRule(LoyPromotionAc1CardDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc1CardRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc1CardRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;		
			}



		 /*
		  * 1. 메소드명: getPromAc1ClbDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc1ClbDetailResDto getPromAc1ClbDetail(LoyPromotionAc1ClbDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc1ClbDetail(mcr);
		}



		 /*
		  * 1. 메소드명: savePromotionAc1ClbRule
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto savePromotionAc1ClbRule(LoyPromotionAc1ClbDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			
			if (ObjectUtil.isEmpty(mcr.getRid())) {
				// 수정
				mcr.setRid(CommonUtil.newRid());
				cmpMapper.insertPromotionAc1ClbRule(mcr);
				rtnValue.setSuccess(true);
			} else {
				cmpMapper.updatePromotionAc1ClbRule(mcr);
				rtnValue.setSuccess(true);
				// 등록
			}
			return rtnValue;		
		}



		 /*
		  * 1. 메소드명: getPromAc2SurDetail
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionAc2SurDetailResDto getPromAc2SurDetail(LoyPromotionAc2SurDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPromAc2SurDetail(mcr);
		}



		 /*
		  * 1. 메소드명: removeRuleAc2Add
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeRuleAc2Add(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteRuleAc2Add(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: removeRuleSa2Sum
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeRuleSa2Sum(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteRuleSa2Sum(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: removeRuleAc2On
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 3.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeRuleAc2On(LoyPromotionSa1RuleDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteRuleAc2On(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}
		
		public LoyPromotionSa1RuleDetailResDto getPrulSa1GenInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulSa1GenInfo(mcr);
		}
		
		public LoyPromotionSa1AniDetailResDto getPrulSa1AniInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulSa1AniInfo(mcr);
		}
		public LoyPromotionSa2SumDetailResDto getPrulSa2SumInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulSa2SumInfo(mcr);
		}		
		public LoyPromotionAc1JoinDetailResDto getPrulAc1JoinInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulAc1JoinInfo(mcr);
		}
		public LoyPromotionAc1FamDetailResDto getPrulAc1FamInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulAc1FamInfo(mcr);
		}
		public LoyPromotionAc1ClbDetailResDto getPrulAc1ClbInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulAc1ClbInfo(mcr);
		}
		public LoyPromotionAc1CardDetailResDto getPrulAc1CardInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulAc1CardInfo(mcr);
		}
		
		public LoyPromotionAc1FrndDetailResDto getPrulAc1FrndInfo(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			return cmpMapper.selectPrulAc1FrndInfo(mcr);
		}



		 /*
		  * 1. 메소드명: removeActionTierItem
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 9.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public StatusResDto removeActionTierItem(LoyPromotionTierActionReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			StatusResDto rtnValue = new StatusResDto();
			cmpMapper.deleteActionTierItem(mcr);
			rtnValue.setSuccess(true);
			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getPromotionListPop
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 16.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public GridPagingResDto<LoyPromotionListResDto> getPromotionListPop(LoyCampaignReqtDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return new GridPagingResHelper<LoyPromotionListResDto>().newGridPagingResDto( 
					mcr.init(CommonUtil.getInstance().getDBType()),
					cmpMapper.selectPromotionListPop(mcr),AnnotationType.CommCode);  
		}



		 /*
		  * 1. 메소드명: saveLoyaltyContentsChnnelRel
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2021. 2. 5.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcccrr
		 *   @return	
		 */
		
		public StatusResDto saveLoyaltyContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
			LogUtil.param(this.getClass(), mcccrr);

			//캠페인 상태 저장여부 확인
			checkCampaignStatusSaveFlag(mcccrr.getCampaignId(), mcccrr.getChnnelTypeCode());

			StatusResDto rtnValue = new StatusResDto();

			//캠페인 콘텐츠 채널 관계 삭제 By Campaign ID
			rtnValue = removeLoyaltyContentsChnnelRel(mcccrr);

			if ((TASK_DATA_STATUS.I.name().equals(mcccrr.getDataStatus())
					|| TASK_DATA_STATUS.U.name().equals(mcccrr.getDataStatus()))
					&& ObjectUtil.isNotEmpty(mcccrr.getCampaignId())) {
				if (ObjectUtil.isNotEmpty(mcccrr.getId())) {
					//캠페인 콘텐츠 채널 관계 수정
					rtnValue = editLoyaltyContentsChnnelRel(mcccrr);
					rtnValue.setMessage(mcccrr.getId());
				} else {
					//캠페인 콘텐츠 채널 관계 등록
					rtnValue = addCampaignContentsChnnelRel(mcccrr);
				}
			}

			return rtnValue;
		}
		
		public StatusResDto removeLoyaltyContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
			LogUtil.param(this.getClass(), mcccrr);

			StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);

			//콘텐츠 채널 관계 삭제
			cmpMapper.deleteCampaignContentsChnnelRel(mcccrr);

			//콘텐츠 삭제
			//cmpMapper.deleteCampaignContents(mcccrr);

			rtnValue.setSuccess(true);

			return rtnValue;
		}
		
		public StatusResDto editLoyaltyContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
			LogUtil.param(this.getClass(), mcccrr);

			StatusResDto rtnValue = new StatusResDto(false, "");

			//콘텐츠 채널 관계 수정
			cmpMapper.updateCampaignContentsChnnelRel(mcccrr);

			//콘텐츠 수정
			cmpMapper.updateCampaignContents(mcccrr);

			rtnValue.setSuccess(true);

			return rtnValue;
		}
		
		public StatusResDto addCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
			LogUtil.param(this.getClass(), mcccrr);

			StatusResDto rtnValue = new StatusResDto(false, "");
			String id = CommonUtil.newRid();
			mcccrr.setId(id);

			cmpMapper.insertCampaignContentsChnnelRel(mcccrr);
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);


			return rtnValue;
		}



		 /*
		  * 1. 메소드명: getCampaignContentsChnnelRel
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2021. 2. 5.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcccrr
		 *   @return	
		 */
		
		public MktCampaignContentsChnnelRelResDto getLoyaltyContentsChnnelRel(
				MktCampaignContentsChnnelRelReqDto mcccrr) {
			LogUtil.param(this.getClass(), mcccrr);

			return cmpMapper.selectCampaignContentsChnnelRel(mcccrr);
		}
		

		public MktCampaignContentsChnnelRelResDto getBuyNotiYn(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return cmpMapper.selectBuyNotiYn();  
		}
		
		public MktCampaignContentsChnnelRelResDto getPromBuyNotiYn(LoyCampaignReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);

			return cmpMapper.selectPromBuyNotiYn();  
		}



		 /*
		  * 1. 메소드명: getPromInfo
		  * 2. 클래스명: LoyCampaignService
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2021. 3. 23.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param mcr
		 *   @return	
		 */
		
		public LoyPromotionActionDetailResDto getPromInfo(LoyPromotionActionDetailReqDto mcr) {
			LogUtil.param(this.getClass(), mcr);
			LoyPromotionActionDetailResDto rtnValue = new LoyPromotionActionDetailResDto();
			ArrayList<LoyPromotionTierActionDetailResDto> promTierActionDto = new ArrayList<LoyPromotionTierActionDetailResDto>();
			
			rtnValue = cmpMapper.selectPromInfo(mcr);
			
		
			return rtnValue;
		}		

		
}
