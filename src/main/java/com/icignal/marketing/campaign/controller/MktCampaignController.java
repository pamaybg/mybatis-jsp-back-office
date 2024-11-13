package com.icignal.marketing.campaign.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.marketing.campaign.dto.request.*;
import com.icignal.marketing.campaign.dto.response.*;
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
import com.icignal.marketing.campaign.service.MktCampaignService;


/**
 * @name : MktCampaignController.java
 * @date : 2017. 6. 22.
 * @author : sn.lee
 * @description :
 */
@Controller
@RequestMapping("/marketing/campaign")
public class MktCampaignController extends BaseController {
	
	@Autowired
	public MktCampaignService MktCampaignService;

    /**
     * @programId : Mkt_MNG_001
     * @name : getCampaignList
     * @date : 2015. 9. 23.
     * @author : "dg.ryu"
     * @table :
     * @return :
     * @description : 캠페인 목록
     */
    @RequestMapping(value="/getCampaignList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktCampaignListResDto> getCampaignList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.getCampaignList(param);
    }

    /**
     * @programId :
     * @name : selectCampaignAuth
     * @date : 2022. 1. 19.
     * @author : "sj.jung"
     * @table :
     * @return :
     * @description : 캠페인 권한
     */
    @RequestMapping(value="/selectCampaignAuth.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<MktCampaignListResDto> selectCampaignAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.selectCampaignAuth(param);
    }

    /**
     * @programId : Mkt_MNG_001
     * @name : getCampaignList
     * @date : 2021. 01. 05.
     * @author : "sj.jung"
     * @table :
     * @return :
     * @description : 캠페인 결재 목록
     */
    @RequestMapping(value="/getCampaignApprList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<MktCampaignListResDto> getCampaignApprList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.getCampaignApprList(param);
    }

    /**
     * @programId : Mkt_MNG_001
     * @name : setCampaignCancel
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 상태 - 취소
     */
    @RequestMapping(value="/setCampaignCancel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCampaignCancel(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcdir.setLoginInfo(loginInfo);

        return MktCampaignService.setCampaignCancel(mcdir);
    }

    /**
     * @programId : Mkt_MNG_001
     * @name : setCampaignComplete
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 상태 - 활성(완료)
     */
    @RequestMapping(value="/setCampaignComplete.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCampaignComplete(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        mcdir.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.setCampaignComplete(mcdir);
    }

    /**
     * @programId : Mkt_MNG_001
     * @name : setCampaignComplete
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 상태 - 중지
     */
    @RequestMapping(value="/setCampaignStop.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCampaignStop(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        mcdir.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.setCampaignStop(mcdir);
    }

    /**
     * @programId : Mkt_MNG_P01
     * @name : getTempNodeList
     * @date : 2015. 11. 24.
     * @author : 안형욱
     * @table :
     * @return :
     * @description : 템플렛 헤더 노드 리스트 조회
     */
    @RequestMapping(value="/getTempNodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignGetTempNodeListResDto> getTempNodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignGetTempNodeListReqDto dto) {
        LogUtil.param(this.getClass(), dto);

        dto.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getTempNodeList(dto);
    }

    /**
     * @programId : Mkt_MNG_P01
     * @name : getTemp
     * @date : 2015. 11. 24.
     * @author : 안형욱
     * @table : mkt.mkt_wf_template_ms,com.comm_code;
     * @return :
     * @description : 템플릿 조회
     */
    @RequestMapping(value="/getTemp.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignGetTempNodeListResDto> getTemp(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignGetTempNodeListReqDto dto) {
        LogUtil.param(this.getClass(), dto);

        dto.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getTemp(dto);
    }

    /**
     * @programId : Mkt_MNG_002
     * @name : saveCampaignWorkflow
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 워크플로우 진행현황 및 데이이터 저장
     */
    @RequestMapping(value="/saveCampaignWorkflow.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignWorkflow(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcwr.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignWorkflow(mcwr);
    }

    /**
     * @programId : Mkt_MNG_002
     * @name : getCampaignWorkflowStatusList
     * @date : 2015. 10. 21.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 워크플로우 진행현황 및 데이터
     */
    @RequestMapping(value="/getCampaignWorkflowStatusList.do", method = RequestMethod.POST)
	public @ResponseBody List<MktCampaignWorkflowStatusListResDto> getCampaignWorkflowStatusList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcwr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignWorkflowStatusList(mcwr);
    }

    /**
     * @programId : Mkt_MNG_P02
     * @name : getCampaignDefaultInfo
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 기본 정보
     */
    @RequestMapping(value="/getCampaignDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignDefaultInfoResDto getCampaignDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignDefaultInfo(mcr);
    }

    /**
     * @programId : Mkt_MNG_P02
     * @name : saveCampaignDefaultInfo
     * @date : 2015. 10. 28.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인기본정보 저장
     */
    @RequestMapping(value="/saveCampaignDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcdir.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignDefaultInfo(mcdir);
    }

    /**
     * @programId : Mkt_MNG_P13
     * @name : getCampaignProgramList
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return :
     * @description : 캠페인 프로그램 목록 조회
     */
    @RequestMapping(value="/getCampaignProgramList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignProgramListResDto> getCampaignProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignProgramReqDto mcpr) {
        LogUtil.param(this.getClass(), mcpr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcpr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignProgramList(mcpr);
    }

    /**
     * @programId : Mkt_MNG_P13
     * @name : addCampaignWorkflowStatus
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return :
     * @description : 캠페인 프로그램 등록
     */
    @RequestMapping(value="/addCampaignProgram.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCampaignProgram(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignProgramReqDto mcpr) {
        LogUtil.param(this.getClass(), mcpr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcpr.setLoginInfo(loginInfo);

        return MktCampaignService.addCampaignProgram(mcpr);
    }

    /**
     * @programId : Mkt_MNG_P13
     * @name : removeCampaignProgramList
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return :
     * @description : 캠페인 프로그램 삭제
     */
    @RequestMapping(value="/removeCampaignProgram.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCampaignProgram(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignProgramReqDto mcpr) {
        LogUtil.param(this.getClass(), mcpr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcpr.setLoginInfo(loginInfo);

        return MktCampaignService.removeCampaignProgram(mcpr);
    }

    /**
     * @programId : Mkt_MNG_P05
     * @name : getCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return :
     * @description : 캠페인 콘텐츠 채널 관계 조회
     */
    @RequestMapping(value="/getCampaignContentsChnnelRel.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignContentsChnnelRelResDto getCampaignContentsChnnelRel(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcccrr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignContentsChnnelRel(mcccrr);
    }

    /**
     * @programId : Mkt_MNG_P05
     * @name : saveCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return :
     * @description : 캠페인 콘텐츠 채널 관계 저장
     */
    @RequestMapping(value="/saveCampaignContentsChnnelRel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignContentsChnnelRel(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcccrr.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignContentsChnnelRel(mcccrr);
    }
    
    /**
     * @programId : Mkt_MNG_P05
     * @name : saveCampaignTarget
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_tgt_had
     * @return :
     * @description : 캠페인 타겟 저장
     */
    @RequestMapping(value="/saveCampaignTarget.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignTarget(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTgtHadReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignTarget(param);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetTotalCount
     * @date : 2015. 11. 16.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return :
     * @description : 대상자 헤더 대상 전체 건수
     */
    @RequestMapping(value="/getCampaignTargetTotalCount.do", method = RequestMethod.POST)
	public @ResponseBody
	MktCampaignTargetTotalCountResDto getCampaignTargetTotalCount(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignTargetTotalCount(mctr);
    }
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTarget
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return :
     * @description : 대상자 헤더
     */
    @RequestMapping(value="/getCampaignTarget.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignTargetResDto getCampaignTarget(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignTarget(mctr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return :
     * @description : 대상자 헤더 목록
     */
    @RequestMapping(value="/getCampaignTargetList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignTargetListResDto> getCampaignTargetList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignTargetList(mctr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetDtlList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return :
     * @description : 대상자 상세 목록
     */
    @RequestMapping(value="/getCampaignTargetDtlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignTargetDtlReqDto> getCampaignTargetDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetDtlReqDto mctdr) {
        LogUtil.param(this.getClass(), mctdr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctdr.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignTargetDtlList(mctdr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : removeCampaignProgram
     * @date : 2015. 11. 16.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 대상자 삭제
     */
    @RequestMapping(value="/removeCampaignTarget.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCampaignTarget(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctr.setLoginInfo(loginInfo);

        return MktCampaignService.removeCampaignTarget(mctr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : setControlGroup
     * @date : 2015. 11. 30.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 대상자 제어그룹 설정
     */
    @RequestMapping(value="/setControlGroup.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setControlGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctr.setLoginInfo(loginInfo);

        return MktCampaignService.setControlGroup(mctr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : removeCampaignTargetDtl
     * @date : 2015. 11. 17.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 대상자 제외
     */
    @RequestMapping(value="/removeCampaignTargetDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCampaignTargetDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetDtlReqDto mctdr) {
        LogUtil.param(this.getClass(), mctdr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctdr.setLoginInfo(loginInfo);

        return MktCampaignService.removeCampaignTargetDtl(mctdr);
    }

    /**
     * @programId : Mkt_MNG_P06
     * @name : removeCancelCampaignTargetDtl
     * @date : 2015. 11. 17.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 대상자 제외 취소
     */
    @RequestMapping(value="/removeCancelCampaignTargetDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCancelCampaignTargetDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTargetDtlReqDto mctdr) {
        LogUtil.param(this.getClass(), mctdr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mctdr.setLoginInfo(loginInfo);

        return MktCampaignService.removeCancelCampaignTargetDtl(mctdr);
    }

    /**
     * @programId : Mkt_MNG_P08
     * @name : getCampaignExecutionInfo
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info, mkt.mkt_exe_info_item
     * @return :
     * @description : 캠페인 실행정보 조회
     */
    @RequestMapping(value="/getCampaignExecutionInfo.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignExecutionInfoResDto getCampaignExecutionInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mceir.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignExecutionInfo(mceir);
    }

    /**
     * 캠페인의 마지막 실행 일자 조회
     *
     * @programId :
     * @name : getCampaignLastExeDate
     * @date : 2017. 12. 15.
     * @author : jh.kim
     * @table :
     * @return : String
     * @description :
     */
    @RequestMapping(value="/getCampaignLastExeDate.do", method = RequestMethod.POST)
    public @ResponseBody MktCampaignExecutionInfoItemListResDto getCampaignLastExeDate(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        mceir.setLoginInfo(this.checkLoginSession(request, response));

        MktCampaignExecutionInfoItemListResDto rtnDto = new MktCampaignExecutionInfoItemListResDto();
        String resultValue = MktCampaignService.getCampaignLastExeDate(mceir);
        rtnDto.setExeDate(resultValue);

        return rtnDto;
    }
    /**
     * @programId : Mkt_MNG_P08
     * @name : saveCampaignExecutionInfo
     * @date : 2015. 11. 19.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info, mkt.mkt_exe_info_item
     * @return :
     * @description : 캠페인 실행정보 저장
     */
    @RequestMapping(value="/saveCampaignExecutionInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCampaignExecutionInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mceir.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignExecutionInfo(mceir);
    }

    /**
     * @programId : Mkt_MNG_P10
     * @name : getCampaignApproval
     * @date : 2015. 12. 7.
     * @author : "dg.ryu"
     * @table : mkt.mkt_elec_aprv
     * @return :
     * @description : 캠페인 전자결재
     */
    @RequestMapping(value="/getCampaignApproval.do", method = RequestMethod.POST)
	public @ResponseBody MktCampaignApprovalResDto getCampaignApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignApprovalReqDto mcar) {
        LogUtil.param(this.getClass(), mcar);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcar.setLoginInfo(loginInfo);

        return MktCampaignService.getCampaignApproval(mcar);
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
    public @ResponseBody boolean checkCampaignStatusSaveFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return MktCampaignService.checkCampaignStatusSaveFlag(mcr);
    }

    /**
     * @programId : Mkt_MNG_002
     * @name : saveCampaignWorkflowTemplateUse
     * @date : 2016. 3. 21.
     * @author : "dg.ryu"
     * @table : mkt.mkt_templet_mst
     * @return :
     * @description : 캠페인 템플릿 사용여부 저장
     */
    @RequestMapping(value="/saveCampaignWorkflowTemplateUse.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveCampaignWorkflowTemplateUse(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWorkflowTemplateReqDto mcwtr) {
        LogUtil.param(this.getClass(), mcwtr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcwtr.setLoginInfo(loginInfo);

        return MktCampaignService.saveCampaignWorkflowTemplateUse(mcwtr);
    }

    /**
     * @programId : Mkt_MNG_004
     * @name : getCampaignStatusList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table :
     * @return :
     * @description : 캠페인 현황 목록
     */
    @RequestMapping(value="/getCampaignStatusList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignStatusReqDto> getCampaignStatusList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStatusReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.getCampaignStatusList(param);
    }

    /**
     * @programId : Mkt_MNG_004
     * @name : getCampaignStatusDetailList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table :
     * @return :
     * @description : 캠페인 현황 실행 목록
     */
    @RequestMapping(value="/getCampaignStatusDetailList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignStatusReqDto> getCampaignStatusDetailList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStatusReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.getCampaignStatusDetailList(param);
    }

    /**
     * @programId :
     * @name : getTgtChnlChk
     * @date : 2016. 12. 06.
     * @author : 이원준
     * @table : mkt_cam_mst, mkt_conts_chnl_rel, mkt_exe_info, mkt_exe_info_item, mkt_tgt_dtl, mkt_conts_mst
     * @return : MktCampaignTgtChnlChkResDto
     * @description : 캠페인 기획완료 체크
     */
    @RequestMapping(value="/getTgtChnlChk.do", method = RequestMethod.POST)
    public @ResponseBody MktCampaignTgtChnlChkResDto getTgtChnlChk(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignTgtChnlChkReqDto ccrsr) {
    	LogUtil.param(this.getClass(), ccrsr);
    	
    	LoginResDto loginInfo = this.checkLoginSession(request, response);
    	ccrsr.setLoginInfo(loginInfo);
    	
    	return MktCampaignService.getTgtChnlChk(ccrsr);
    }

    /**
     * @name : getConidByCamid
     * @date : 2017. 6. 22.
     * @author : jun.lee
     * @return : MktGetConidByCamidResDto
     * @description : camid로 conid 조회
     */
    @RequestMapping(value="/getConidByCamid.do", method = RequestMethod.POST)
	public @ResponseBody List<MktCampaignGetConidByCamidResDto> getConidByCamid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignGetConidByCamidReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktCampaignService.getConidByCamid(param);
    }

    /**
     * 캠페인 삭제
     *
     * @programId :
     * @name : removeCampaign
     * @date : 2017. 11. 29.
     * @author : jh.kim
     * @table :
     * @return : StatusResDto
     * @description :
     */
    @RequestMapping(value="/removeCampaign.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeCampaign(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignRemoveReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktCampaignService.removeCampaign(param);
    }

	/**
	 * @name : callProcCamCopy
	 * @date : 2018. 2. 24.
	 * @author : dg.ryu
	 * @return : StatusResDto
	 * @description : 캠페인 복사 프로시저 호춢
	 */
    @RequestMapping(value="/callProcCamCopy.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto callProcCamCopy(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktCampaignService.callProcCamCopy(param);
    }

    @RequestMapping(value="/getCampaignListExcludeMyCam.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<MktCampaignListResDto> getCampaignListExcludeMyCam(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktCampaignService.getCampaignListExcludeMyCam(param);
    }
    
    
    /**
     * @programId : PLOY_061_P01
     * @name : getETCampaignCondNode
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_cond_val, anl.anl_lgc_comp_mst, anl.anl_atrib_group_column
     * @return :
     * @description : et 조건 조회
     */
    @RequestMapping(value="/getETCampaignCond.do", method = RequestMethod.POST)
	public @ResponseBody
	MktETCampaignNodeResDto getETCampaignCond(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        ecnr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETCampaignCond(ecnr);
    }

    /**
     * @programId : PLOY_061_P01
     * @name : saveETCampaignCondNode
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_cond_val
     * @return :
     * @description : et 조건값 저장
     */
    @RequestMapping(value="/saveETCampaignCond.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveETCampaignCond(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        ecnr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.saveETCampaignCond(ecnr);
    }

    /**
     * @programId : PLOY_065_P01
     * @name : getETCampaignAct
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_act_val, mkt.mkt_offer_mst
     * @return :
     * @description : et 활동 조회
     */
    @RequestMapping(value="/getETCampaignAct.do", method = RequestMethod.POST)
	public @ResponseBody
	MktETCampaignNodeResDto getETCampaignAct(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        ecnr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETCampaignAct(ecnr);
    }

    /**
     * @programId : PLOY_065_P01
     * @name : saveETCampaignAct
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_act_val
     * @return :
     * @description : et 활동값 저장
     */
    @RequestMapping(value="/saveETCampaignAct.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveETCampaignCondNode(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        ecnr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.saveETCampaignAct(ecnr);
    }

    /**
     * @programId : PLOY_060_P01
     * @name : getETIntactTypeList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.loy_intact_type
     * @return :
     * @description : et 인터랙션 유형 목록 조회
     */
    @RequestMapping(value="/getETIntactTypeList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktETIntactTypeListResDto> getETIntactTypeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETIntactTypeListReqDto eitlr) {
        LogUtil.param(this.getClass(), eitlr);

        eitlr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETIntactTypeList(eitlr);
    }

    /**
     * @programId : PLOY_061_P02
     * @name : getETLogicalComponentList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @return :
     * @description : et 로지컬 컴포넌트 목록 조회
     */
    @RequestMapping(value="/getETLogicalComponentList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktETLogicalComponentListResDto> getETLogicalComponentList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETLogicalComponentListReqDto elclr) {
        LogUtil.param(this.getClass(), elclr);

        elclr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETLogicalComponentList(elclr);
    }

    /**
     * @programId : PLOY_061_P01
     * @name : getETLogicalComponentColumnList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @return :
     * @description : et 로지컬 컴포넌트 컬럼 목록
     */
    @RequestMapping(value="/getETLogicalComponentColumnList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<MktETLogicalComponentColumnListResDto> getETLogicalComponentColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETLogicalComponentColumnListReqDto elcclr) {
        LogUtil.param(this.getClass(), elcclr);

        elcclr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETLogicalComponentColumnList(elcclr);
    }

    /**
     * @programId : PLOY_062_P02
     * @name : getETFunctionList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_node_type, loy.et_node_sub_type
     * @return :
     * @description : et function 목록 조회
     */
    @RequestMapping(value="/getETFunctionList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktETFunctionListResDto> getETFunctionList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktETFunctionListReqDto eflr) {
        LogUtil.param(this.getClass(), eflr);

        eflr.setLoginInfo(this.checkLoginSession(request, response));

        return MktCampaignService.getETFunctionList(eflr);
    }

    /**
     * @programId :
     * @name : campaignStatusCheck
     * @date : 
     * @author : 
     * @table : 
     * @return :
     * @description : 
     */
   @RequestMapping(value="/campaignStatusCheck.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto campaignStatusCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignStatusCheckReqDto eflr) {
       LogUtil.param(this.getClass(), eflr);

       eflr.setLoginInfo(this.checkLoginSession(request, response));

       return MktCampaignService.campaignStatusCheck(eflr);
   }
    
   /**
    * 캠페인 프로모션 시작&종료일시 조회
    *
    * @programId :
    * @name : getCampaignPromotonDate
    * @date : 2018. 1. 11.
    * @author : jh.kim
    * @table :
    * @return : MKTCampaignPromotionDateResponseDTO
    * @description :
    */
   @RequestMapping(value="/getCampaignPromotionDate.do", method = RequestMethod.POST)
   public @ResponseBody MktCampaignPromotionDateResDto getCampaignPromotonDate(
           HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignPromotionDateReqDto param) {
       LogUtil.param(this.getClass(), param);

       param.setLoginInfo(this.checkLoginSession(request, response));
       MktCampaignPromotionDateResDto rtnDto = MktCampaignService.getCampaignPromotionDate(param);

       return rtnDto;
   }
   
   /**
    * @programId :
    * @name : getCampaignWait
    * @date : 2020. 5. 7.
    * @author : dg.ryu
    * @table :
    * @description : 캠페인 Wait 조회
    */
   @RequestMapping(value="/getCampaignWait.do", method = RequestMethod.POST)
   public @ResponseBody MktCampaignWaitResDto getCampaignWait(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWaitReqDto param) {
       LogUtil.param(this.getClass(), param);

       param.setLoginInfo(this.checkLoginSession(request, response));

       return MktCampaignService.getCampaignWait(param);
   }
   
   /**
    * @programId :
    * @name : saveCampaignWait
    * @date : 2020. 5. 7.
    * @author : dg.ryu
    * @table :
    * @description : 캠페인 Wait 저장
    */
   @RequestMapping(value="/saveCampaignWait.do", method = RequestMethod.POST)
   public @ResponseBody StatusResDto saveCampaignWait(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWaitReqDto param) {
       LogUtil.param(this.getClass(), param);

       param.setLoginInfo(this.checkLoginSession(request, response));

       return MktCampaignService.saveCampaignWait(param);
   }
   
   /**
    * @programId :
    * @name : removeCampaignWait
    * @date : 2020. 5. 7.
    * @author : dg.ryu
    * @table :
    * @description : 캠페인 Wait 삭제
    */
   @RequestMapping(value="/removeCampaignWait.do", method = RequestMethod.POST)
   public @ResponseBody StatusResDto removeCampaignWait(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignWaitReqDto param) {
       LogUtil.param(this.getClass(), param);

       param.setLoginInfo(this.checkLoginSession(request, response));

       return MktCampaignService.removeCampaignWait(param);
   }
   
  
   /**
    * @programId :
    * @name : getProdList
    * @date : 2020. 7. 14.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 리스트
    */
   @RequestMapping(value="/getProdList.do", method = RequestMethod.POST)
   public @ResponseBody GridPagingResDto<MktCampaignProdResDto> getProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.getProdList(param);
   }
   
   
   /**
    * @programId :
    * @name : getProdTreeList
    * @date : 2020. 7. 14.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 트리 
    */
   @RequestMapping(value="/getProdTreeList.do", method = RequestMethod.POST)
   public @ResponseBody 
   List<MktCampaignProdResDto> getProdTreeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.getProdTreeList(param);
   }
   
   /**
    * @programId :
    * @name : saveCampaignProd
    * @date : 2020. 7. 14.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 저장
    */
   @RequestMapping(value="/saveCampaignProd.do", method = RequestMethod.POST)
   public @ResponseBody StatusResDto saveCampaignProd(HttpServletRequest request, HttpServletResponse response, 
		   @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.saveCampaignProd(param);
   }
   
   
   /**
    * @programId :
    * @name : getProdTreeSearchList
    * @date : 2020. 7. 15.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 검색
    */
   @RequestMapping(value="/getProdTreeSearchList.do", method = RequestMethod.POST)
   public @ResponseBody List<MktCampaignProdResDto> getProdTreeSearchList(HttpServletRequest request, HttpServletResponse response, 
		   @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.getProdTreeSearchList(param);
   }
   
   /**
    * @programId :
    * @name : removeProd
    * @date : 2020. 7. 15.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 삭제
    */
   @RequestMapping(value="/removeProd.do", method = RequestMethod.POST)
   public @ResponseBody StatusResDto removeProd(HttpServletRequest request, HttpServletResponse response, 
		   @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.removeProd(param);
   }
   
   /**
    * @programId :
    * @name : removeAllProd
    * @date : 2020. 7. 15.
    * @author : yj.choi
    * @table :
    * @description : 반응상품 전체 삭제
    */
   @RequestMapping(value="/removeAllProd.do", method = RequestMethod.POST)
   public @ResponseBody StatusResDto removeAllProd(HttpServletRequest request, HttpServletResponse response, 
		   @RequestBody MktCampaignProdReqDto param) {
	   LogUtil.param(this.getClass(), param);
	   
	   param.setLoginInfo(this.checkLoginSession(request, response));
	   
	   return MktCampaignService.removeAllProd(param);
   }

    /**
     * 캠페인 오퍼수 조회
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/getCampaignOfferCount.do", method = RequestMethod.POST)
    public @ResponseBody Integer getCampaignOfferCount(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.getCampaignOfferCount(param);
    }

    /**
     * 캠페인 불러오기시 오퍼에 쿠폰이 있는지에 대한 여부 체크
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/getCampaignLoadOfferCount.do", method = RequestMethod.POST)
    public @ResponseBody Integer getCampaignLoadOfferCount(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.getCampaignLoadOfferCount(param);
    }

    /**
     * 캠페인 컨텐츠 오퍼 팝업시 쿠폰 체크
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/getCampaignLoadOfferPopCount.do", method = RequestMethod.POST)
    public @ResponseBody Integer getCampaignLoadOfferPopCount(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignContentsChnnelRelReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.getCampaignLoadOfferPopCount(param);
    }

    /**
     * 캠페인 실행 가능 시간 조회
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/getSchedulingPermitTime.do", method = RequestMethod.POST)
    public @ResponseBody
    MktSchePermitResDto getSchedulingPermitTime(HttpServletRequest request, HttpServletResponse response, @RequestBody MktSchePermitReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.getSchedulingPermitTime(param);
    }

    /**
     * 캠페인 오퍼 발급 완료 체크
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/getOfferDataCheck.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto getOfferDataCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.getOfferDataCheck(param);
    }

    /**
     * 캠페인 오퍼 발급
     * @param request
     * @param response
     * @param param
     * @return
     */
    @RequestMapping(value="/camOfferRequest.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto camOfferRequest(HttpServletRequest request, HttpServletResponse response, @RequestBody MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        this.checkLoginSession(request, response);

        return MktCampaignService.camOfferRequest(param);
    }


}
