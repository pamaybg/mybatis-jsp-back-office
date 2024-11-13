package com.icignal.loyalty.promotion.campaign.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.promotion.campaign.dto.request.CampaignApprovalReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignDefaultInfoReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetConidByCamidReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignGetTempNodeListReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignOfferReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignProgramReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignRemoveReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignReqtDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignTgtChnlChkReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignWorkflowReqDto;
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
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionSa2SumDetailReqDto;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyPromotionTierActionReqDto;
import com.icignal.loyalty.promotion.campaign.dto.response.CampaignWorkflowStatusListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LOYCampaignListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignApprovalResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetConidByCamidResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignGetTempNodeListResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyCampaignOfferResDto;
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
import com.icignal.loyalty.promotion.campaign.dto.response.LoyPromotionSa2SumDetailResDto;
import com.icignal.loyalty.promotion.campaign.dto.response.LoyTgtGrpListResDto;
import com.icignal.loyalty.promotion.campaign.service.LoyCampaignService;
import com.icignal.marketing.campaign.dto.request.MktCampaignContentsChnnelRelReqDto;
import com.icignal.marketing.campaign.dto.response.MktCampaignContentsChnnelRelResDto;



/**
 * @name : infavor.loyalty.campaign.controller.LOYCampaignController
 * @date : 2017. 7. 11.
 * @author : jh.kim
 * @description : 로얄티 캠페인 Controller 
 */
@Controller
@RequestMapping("/loyalty/campaign")
public class LoyCampaignController extends BaseController {

	
	
	
	@Autowired
	private LoyCampaignService loyCampaignService;

	/**
	 * @programId :
	 * @name : getPromotionList
	 * @date : 2018. 11. 19.
	 * @author : hy.jun
	 * @table :
	 * @return : GridPagingResponseDTO
	 * @description :
	 */
	@RequestMapping(value="/getPromotionList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LOYCampaignListResDto> getPromotionList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqtDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyCampaignService.getPromotionList(param);
	}
	
    @RequestMapping(value="/getConidByCamid.do", method = RequestMethod.POST)
	public @ResponseBody
	List<LoyCampaignGetConidByCamidResDto> getConidByCamid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignGetConidByCamidReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);

        return loyCampaignService.getConidByCamid(param);
    }

	

	/**
	 * @programId : MKT_MNG_P01
	 * @name : getTemp
	 * @date : 2015. 11. 24.
	 * @author : 안형욱
	 * @table : mkt.mkt_wf_template_ms,com.comm_code;
	 * @return :
	 * @throws Exception 
	 * @description : 템플릿 조회
	 */
	@RequestMapping(value="/getTemp.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyCampaignGetTempNodeListResDto> getTemp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignGetTempNodeListReqDto dto) throws Exception {
		LogUtil.param(this.getClass(), dto);

		dto.setLoginInfo(this.checkLoginSession(request, response));

		return loyCampaignService.getTemp(dto);
	}
	/**
	 * @programId : MKT_MNG_P01
	 * @name : getTempNodeList
	 * @date : 2015. 11. 24.
	 * @author : 안형욱
	 * @table :
	 * @return :
	 * @description : 템플렛 헤더 노드 리스트 조회
	 */
	@RequestMapping(value="/getTempNodeList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyCampaignGetTempNodeListResDto> getTempNodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignGetTempNodeListReqDto dto) {
		LogUtil.param(this.getClass(), dto);

		dto.setLoginInfo(this.checkLoginSession(request, response));

		return loyCampaignService.getTempNodeList(dto);
	}
	/**
	 * @programId : MKT_MNG_001
	 * @name : setCampaignComplete
	 * @date : 2015. 10. 29.
	 * @author : dg.ryu
	 * @table : mkt.mkt_cam_mst
	 * @return :
	 * @description : 캠페인 상태 - 중지
	 */
	@RequestMapping(value="/setCampaignStop.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setCampaignStop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignDefaultInfoReqDto mcdir) {
		LogUtil.param(this.getClass(), mcdir);

		mcdir.setLoginInfo(this.checkLoginSession(request, response));

		return loyCampaignService.setCampaignStop(mcdir);
	}
	/**
	 * @programId : MKT_MNG_001
	 * @name : setCampaignComplete
	 * @date : 2015. 10. 29.
	 * @author : dg.ryu
	 * @table : mkt.mkt_cam_mst
	 * @return :
	 * @description : 캠페인 상태 - 중지
	 */
	@RequestMapping(value="/setCampaignActive.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setCampaignActive(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignDefaultInfoReqDto mcdir) {
		LogUtil.param(this.getClass(), mcdir);

		mcdir.setLoginInfo(this.checkLoginSession(request, response));

		return loyCampaignService.setCampaignActive(mcdir);
	}
	/**
	 * @programId : MKT_MNG_P13
	 * @name : removeCampaignProgramList
	 * @date : 2015. 10. 27.
	 * @author : dg.ryu
	 * @table : mkt.mkt_prog
	 * @return :
	 * @description : 캠페인 프로그램 삭제
	 */
	@RequestMapping(value="/removeCampaignProgram.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeCampaignProgram(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignProgramReqDto mcpr) {
		LogUtil.param(this.getClass(), mcpr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcpr.setLoginInfo(loginInfo);

		return loyCampaignService.removeCampaignProgram(mcpr);
	}

	/**
	 * @programId :
	 * @name : getTgtChnlChk
	 * @date : 2016. 12. 06.
	 * @author : 이원준
	 * @table : mkt_cam_mst, mkt_conts_chnl_rel, mkt_exe_info, mkt_exe_info_item, mkt_tgt_dtl, mkt_conts_mst
	 * @return : MKTCampaignTgtChnlChkResponseDTO
	 * @description : 캠페인 기획완료 체크
	 */
	@RequestMapping(value="/getTgtChnlChk.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyCampaignTgtChnlChkResDto getTgtChnlChk(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignTgtChnlChkReqDto ccrsr) {
		LogUtil.param(this.getClass(), ccrsr);

		ccrsr.setLoginInfo(this.checkLoginSession(request, response));
		return loyCampaignService.getTgtChnlChk(ccrsr);
	}

	/**
	 * @programId : MKT_MNG_002
	 * @name : saveCampaignWorkflowTemplateUse
	 * @date : 2016. 3. 21.
	 * @author : "dg.ryu"
	 * @table : mkt.mkt_templet_mst
	 * @return :
	 * @description : 캠페인 템플릿 사용여부 저장
	 */
	@RequestMapping(value="/saveCampaignWorkflowTemplateUse.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveCampaignWorkflowTemplateUse(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignWorkflowTemplateReqDto mcwtr) {
		LogUtil.param(this.getClass(), mcwtr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mcwtr.setLoginInfo(loginInfo);

		return loyCampaignService.saveCampaignWorkflowTemplateUse(mcwtr);
	}

	/**
	 * @programId : MKT_MNG_P04
	 * @name : getCampaignOffer
	 * @date : 2015. 10. 29.
	 * @author : dg.ryu
	 * @table : mkt.mkt_cam_offer_rel
	 * @return :
	 * @description : 캠페인 오퍼 조회
	 */
    /**
     * @programId : MKT_MNG_P04
     * @name : getCampaignOffer
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_offer_rel
     * @return :
     * @description : 캠페인 오퍼 조회
     */
    @RequestMapping(value="/getCampaignOffer.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyCampaignOfferResDto getCampaignOffer(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignOfferReqDto mcor) {
        LogUtil.param(this.getClass(), mcor);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcor.setLoginInfo(loginInfo);

        return loyCampaignService.getCampaignOffer(mcor);
    }
	/**
	 * @name : callProcCamCopy
	 * @date : 2018. 2. 24.
	 * @author : dg.ryu
	 * @return : StatusResponseDTO
	 * @description : 캠페인 복사 프로시저 호춢
	 */
    @RequestMapping(value="/callProcCamCopy.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto callProcCamCopy(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return loyCampaignService.callProcCamCopy(param);
    }

    
    /**
     * @programId : MKT_MNG_P04
     * @name : saveCampaignOfferRel
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_offer_rel
     * @return :
     * @description : 캠페인 오퍼 저장
     */
    @RequestMapping(value="/saveCampaignOfferRel.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveCampaignOfferRel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignOfferReqDto mcor) {
        LogUtil.param(this.getClass(), mcor);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcor.setLoginInfo(loginInfo);

        return loyCampaignService.saveCampaignOfferRel(mcor);
    }
    
    /**
     * 캠페인 삭제
     *
     * @programId :
     * @name : removeCampaign
     * @date : 2017. 11. 29.
     * @author : jh.kim
     * @table :
     * @return : StatusResponseDTO
     * @description :
     */
    @RequestMapping(value="/removeCampaign.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeCampaign(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignRemoveReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return loyCampaignService.removeCampaign(param);
    }
    
    /**
     * @programId : MKT_MNG_001
     * @name : setCampaignComplete
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 상태 - 활성(완료)
     */
    @RequestMapping(value="/setCampaignComplete.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setCampaignComplete(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        mcdir.setLoginInfo(this.checkLoginSession(request, response));

        return loyCampaignService.setCampaignComplete(mcdir);
    }
    
    
	/**
	 * @name : checkCampaignStatus
	 * @date : 2016. 03. 28.
	 * @author : 장용
	 * @table : mkt_cam_mst
	 * @return : StatusResponseDTO
	 * @description : 캠페인 상태 조회
	 */
	@RequestMapping(value="/campaignStatusCheck.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto campaignStatusCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignStatusCheckReqDto cscr) {

		LogUtil.param(this.getClass(),cscr);

		this.checkLoginSession(request, response);

		return loyCampaignService.campaignStatusCheck(cscr);
	}

    /**
     * @programId : MKT_MNG_P10
     * @name : getCampaignApproval
     * @date : 2015. 12. 7.
     * @author : "dg.ryu"
     * @table : mkt.mkt_elec_aprv
     * @return :
     * @description : 캠페인 전자결재
     */
    @RequestMapping(value="/getCampaignApproval.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyCampaignApprovalResDto getCampaignApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignApprovalReqDto mcar) {
        LogUtil.param(this.getClass(), mcar);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcar.setLoginInfo(loginInfo);

        return loyCampaignService.getCampaignApproval(mcar);
    }
	
	 /**
     * @programId : MKT_MNG_002
     * @name : saveCampaignWorkflow
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 워크플로우 진행현황 및 데이이터 저장
     */
    @RequestMapping(value="/saveCampaignWorkflow.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveCampaignWorkflow(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcwr.setLoginInfo(loginInfo);

        return loyCampaignService.saveCampaignWorkflow(mcwr);
    }
    
    /**
     * @programId : MKT_MNG_002
     * @name : getCampaignWorkflowStatusList
     * @date : 2015. 10. 21.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 워크플로우 진행현황 및 데이터
     */
    @RequestMapping(value="/getCampaignWorkflowStatusList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<CampaignWorkflowStatusListResDto> getCampaignWorkflowStatusList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcwr.setLoginInfo(loginInfo);

        return loyCampaignService.getCampaignWorkflowStatusList(mcwr);
    }
    
    /**
     * @programId : MKT_MNG_P02
     * @name : saveCampaignDefaultInfo
     * @date : 2015. 10. 28.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인기본정보 저장
     */
    @RequestMapping(value="/saveCampaignDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveCampaignDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);
        
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcdir.setLoginInfo(loginInfo);

        return loyCampaignService.saveCampaignDefaultInfo(mcdir);
    }
    
    /**
     * @programId :
     * @name : checkCampaignStatusSaveFlag
     * @date : 2016. 3. 18.
     * @author : "dg.ryu"
     * @table :
     * @return :
     * @description : 캠페인 상태에 따른 저장여부
     */
    @RequestMapping(value="/checkCampaignStatusSaveFlag.do", method = RequestMethod.POST)
    public @ResponseBody boolean checkCampaignStatusSaveFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.checkCampaignStatusSaveFlag(mcr);
    }
    
    /**
     * @programId : MKT_MNG_P02
     * @name : getCampaignDefaultInfo
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 기본 정보
     */
    @RequestMapping(value="/getCampaignDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyPromotionDefaultInfoResDto getCampaignDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getCampaignDefaultInfo(mcr);
    }
    
    @RequestMapping(value="/getPromotionListNew.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyPromotionListResDto> getPromotionListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);
        mcr.setAuthAlias("lp");

        return loyCampaignService.getPromotionListNew(mcr);
    }
    
    @RequestMapping(value="/savePromotionDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto savePromotionDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionDefaultInfoReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.savePromotionDefaultInfo(mcr);
    }
    
    @RequestMapping(value="/getTgtGrpIncList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyTgtGrpListResDto> getTgtGrpIncList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getTgtGrpIncList(mcr);
    }
    
    @RequestMapping(value="/savePromotionKpi.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto savePromotionKpi(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionKpiDetailReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.savePromotionKpi(mcr);
    }
    
    @RequestMapping(value="/getPromKpiInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyPromotionKpiDetailResDto getPromKpiInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionKpiDetailReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getPromKpiInfo(mcr);
    }
    
    @RequestMapping(value="/getActionTierList.do", method = RequestMethod.POST)
   	public @ResponseBody
   	List<LoyPromotionActionTierList> getActionTierList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionDefaultInfoReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getActionTierList(mcr);
       }
    
    @RequestMapping(value="/savePromotionAction.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAction(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionActionDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionAction(mcr);
       }
    
    @RequestMapping(value="/getPromActionInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionActionDetailResDto getPromActionInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionActionDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromActionInfo(mcr);
       }
    
    @RequestMapping(value="/getPromInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionActionDetailResDto getPromInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionActionDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromInfo(mcr);
       }
    
    @RequestMapping(value="/removeActionTier.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeActionTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionTierActionReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           //mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeActionTier(mcr);
    }
    
    @RequestMapping(value="/getPromRuleInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionDetailResDto getPromRuleInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionTierActionReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           //mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromRuleInfo(mcr);
    }
    
    @RequestMapping(value="/savePromotionRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionRuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionRule(mcr);
    }
    
    @RequestMapping(value="/savePromotionSa1Rule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionSa1Rule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionSa1Rule(mcr);
    }
    
    @RequestMapping(value="/getChnlTgtGrpList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyChnlTgtGrpResDto> getChnlTgtGrpList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getChnlTgtGrpList(mcr);
    }
    
    @RequestMapping(value="/getProdTgtGrpList.do", method = RequestMethod.POST)
   	public @ResponseBody
   	GridPagingResDto<LoyProdTgtGrpResDto> getProdTgtGrpList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getProdTgtGrpList(mcr);
    }
    
    @RequestMapping(value="/getPromSa1RuleInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionSa1RuleDetailResDto getPromSa1RuleInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromSa1RuleInfo(mcr);
    }
    
    @RequestMapping(value="/removeRuleSa1Xm.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeRuleSa1Xm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeRuleSa1Xm(mcr);
    }
    
    @RequestMapping(value="/removeSa1Rule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeSa1Rule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeSa1Rule(mcr);
    }
    
    @RequestMapping(value="/getPromSa1AniDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionSa1AniDetailResDto getPromSa1AniDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromSa1AniDetail(mcr);
    }
    
    @RequestMapping(value="/savePromotionSa1AniRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionSa1AniRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1AniDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionSa1AniRule(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc2ConRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc2ConRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2ConDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionAc2ConRule(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc2AgrRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc2AgrRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2AgrDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionAc2AgrRule(mcr);
    }
    @RequestMapping(value="/getPromAc2ConDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc2ConDetailResDto getPromAc2ConDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2ConDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromAc2ConDetail(mcr);
    }
    
    @RequestMapping(value="/getPromAc2AgrDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc2AgrDetailResDto getPromAc2AgrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2AgrDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromAc2AgrDetail(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc2SurRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc2SurRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2SurDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.savePromotionAc2SurRule(mcr);
    }
    
    @RequestMapping(value="/savePromotionSa2SumRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionSa2SumRule(HttpServletRequest request, HttpServletResponse response, @RequestBody ArrayList<LoyPromotionSa2SumDetailReqDto> mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           
   
           
           return loyCampaignService.savePromotionSa2SumRule(mcr,loginInfo);
    }
    
    @RequestMapping(value="/savePromotionAc2OnRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc2OnRule(HttpServletRequest request, HttpServletResponse response, @RequestBody ArrayList<LoyPromotionAc2OnDetailReqDto> mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           
   
           
           return loyCampaignService.savePromotionAc2OnRule(mcr,loginInfo);
    }
    
    @RequestMapping(value="/getPromSa2SumRuleInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	ArrayList<LoyPromotionSa2SumDetailResDto> getPromSa2SumRuleInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa2SumDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromSa2SumRuleInfo(mcr);
    }
    
    @RequestMapping(value="/getPromAc2OnRuleInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	ArrayList<LoyPromotionAc2OnDetailResDto> getPromAc2OnRuleInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2OnDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromAc2OnRuleInfo(mcr);
    }
    
    @RequestMapping(value="/getPromAc2AddRuleInfo.do", method = RequestMethod.POST)
   	public @ResponseBody
   	ArrayList<LoyPromotionAc2AddDetailResDto> getPromAc2AddRuleInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2AddDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromAc2AddRuleInfo(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc2AddRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc2AddRule(HttpServletRequest request, HttpServletResponse response, @RequestBody ArrayList<LoyPromotionAc2AddDetailReqDto> mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
   
           return loyCampaignService.savePromotionAc2AddRule(mcr,loginInfo);
    }
    
    @RequestMapping(value="/savePromotionAc1JoinRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc1JoinRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1JoinDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.savePromotionAc1JoinRule(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc1FrndRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc1FrndRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1FrndDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);   
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.savePromotionAc1FrndRule(mcr);
    }
    
    @RequestMapping(value="/getPromAc1FrndDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc1FrndDetailResDto getPromAc1FrndDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1FrndDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc1FrndDetail(mcr);
    }
    
    @RequestMapping(value="/getPromAc1JoinDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc1JoinDetailResDto getPromAc1JoinDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1JoinDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc1JoinDetail(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc1FamRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc1FamRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1FamDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);      
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.savePromotionAc1FamRule(mcr);
    }
    
    @RequestMapping(value="/getPromAc1FamDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc1FamDetailResDto getPromAc1FamDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1FamDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc1FamDetail(mcr);
    }

    @RequestMapping(value="/getPromAc1CardDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc1CardDetailResDto getPromAc1CardDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1CardDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc1CardDetail(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc1CardRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc1CardRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1CardDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);      
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.savePromotionAc1CardRule(mcr);
    }
    
    @RequestMapping(value="/getPromAc1ClbDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc1ClbDetailResDto getPromAc1ClbDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1ClbDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc1ClbDetail(mcr);
    }
    
    @RequestMapping(value="/savePromotionAc1ClbRule.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto savePromotionAc1ClbRule(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc1ClbDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);      
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.savePromotionAc1ClbRule(mcr);
    }
    
    @RequestMapping(value="/getPromAc2SurDetail.do", method = RequestMethod.POST)
   	public @ResponseBody
   	LoyPromotionAc2SurDetailResDto getPromAc2SurDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionAc2SurDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);  
           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);
           return loyCampaignService.getPromAc2SurDetail(mcr);
    }
    
    @RequestMapping(value="/removeRuleAc2Add.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeRuleAc2Add(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeRuleAc2Add(mcr);
    }
    
    @RequestMapping(value="/removeRuleSa2Sum.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeRuleSa2Sum(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeRuleSa2Sum(mcr);
    }
    
    @RequestMapping(value="/removeRuleAc2On.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeRuleAc2On(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionSa1RuleDetailReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeRuleAc2On(mcr);
    }
    
    @RequestMapping(value="/removeActionTierItem.do", method = RequestMethod.POST)
   	public @ResponseBody
   	StatusResDto removeActionTierItem(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromotionTierActionReqDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.removeActionTierItem(mcr);
    }
    
    @RequestMapping(value="/getPromotionListPop.do", method = RequestMethod.POST)
   	public @ResponseBody
   	GridPagingResDto<LoyPromotionListResDto> getPromotionListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqtDto mcr) {
           LogUtil.param(this.getClass(), mcr);

           LoginResDto loginInfo = this.checkLoginSession(request, response);
           mcr.setLoginInfo(loginInfo);

           return loyCampaignService.getPromotionListPop(mcr);
    }
    
    /**
     * @programId : Mkt_MNG_P05
     * @name : saveCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "서정환"
     * @table : mkt.mkt_conts_chnl_rel
     * @return :
     * @description : 프로모션 콘텐츠 채널 관계 저장
     */
    @RequestMapping(value="/saveLoyaltyContentsChnnelRel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignContentsChnnelRel(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcccrr.setLoginInfo(loginInfo);

        return loyCampaignService.saveLoyaltyContentsChnnelRel(mcccrr);
    }
    
    /**
     * @programId : Mkt_MNG_P05
     * @name : getCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "서정환"
     * @table : mkt.mkt_conts_chnl_rel
     * @return :
     * @description : 프로모션 콘텐츠 채널 관계 조회
     */
    @RequestMapping(value="/getLoyaltyContentsChnnelRel.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignContentsChnnelRelResDto getCampaignContentsChnnelRel(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcccrr.setLoginInfo(loginInfo);

        return loyCampaignService.getLoyaltyContentsChnnelRel(mcccrr);
    }
    
    @RequestMapping(value="/getBuyNotiYn.do", method = RequestMethod.POST)
	public @ResponseBody
	MktCampaignContentsChnnelRelResDto getBuyNotiYn(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getBuyNotiYn(mcr);
    }
    
    @RequestMapping(value="/getPromBuyNotiYn.do", method = RequestMethod.POST)
	public @ResponseBody
	MktCampaignContentsChnnelRelResDto getPromBuyNotiYn(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return loyCampaignService.getPromBuyNotiYn(mcr);
    }
}


