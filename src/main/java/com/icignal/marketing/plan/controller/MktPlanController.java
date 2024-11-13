package com.icignal.marketing.plan.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.marketing.plan.service.MktPlanService;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
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


/*
 * 1. 클래스명	: MktPlanController
 * 2. 파일명	: MktPlanController.java
 * 3. 패키지명	: com.icignal.marketing.plan.controller
 * 4. 작성자명	: GyeongYoung.LEE
 * 5. 최초 작성일자	: 2020. 6. 11.
 * 5. 최종 작성일자	: 2020. 6. 24. 
 */

@Controller
@RequestMapping("/marketing/plan")
public class MktPlanController extends BaseController {
	
	@Autowired
	public MktPlanService MktPlanService;
	
	//마케팅 플랜 리스트 전체 조회
    @RequestMapping(value="/getPlanList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktPlanListResDto> getPlanList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktPlanService.getPlanList(param);
    }
  //마케팅 플랜 리스트 선택 삭제 및 노드 데이터 삭제
    @RequestMapping(value= "/removePlan.do",method = RequestMethod.POST)
    public @ResponseBody 
    StatusResDto removePlan(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanRemoveReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.removePlan(param);
    }
  //마케팅 플랜 디테일 삽입
    @RequestMapping(value="/addPlanDtl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto addPlanDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanInsertReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return MktPlanService.addPlanDtl(param);
    }
  //마케팅 플랜 리스트 엑셀 다운로드
	@RequestMapping(value = "/getPlanListExport.do", method = RequestMethod.POST)
	public  
	String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanListReqDto reqDto, ModelMap model) {
		
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		GridPagingResDto<MktPlanListResDto> data = MktPlanService.getPlanList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "Plan_List");

		return "ExcelView";
	}
 //마케팅 플랜 리스트 특정 조회
    @RequestMapping(value="/selectIdPlanList.do", method = RequestMethod.POST)
	public @ResponseBody
	MktPlanIdListResDto selectIdPlanList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanIdListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);

        return MktPlanService.selectIdPlanList(param);
    }
  //마케팅 플랜 디테일 선택 수정  
    @RequestMapping(value="/updatePlan.do",method = RequestMethod.POST)
    public @ResponseBody StatusResDto updatePlan(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanUpdateListDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.updatePlan(param);
    }
  //마케팅 플랜 디테일 신규 버튼 리스트 전체 조회
    @RequestMapping(value="/selectCampaignPlanList.do",method = RequestMethod.POST)
    public @ResponseBody 
	GridPagingResDto<MktPlanCampaignListResDto> selectCampaignPlanList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktPlanCampaignListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.selectCampaignPlanList(param);
    }
    //마케팅 플랜 디테일 워크플로우 캠페인 노드 생성을 위한 삽입
    @RequestMapping(value="/planNodeInsert.do",method = RequestMethod.POST)
    public @ResponseBody 
    StatusResDto planNodeInsert(HttpServletRequest request, HttpServletResponse response, @RequestBody MktplanNodeInsertReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.planNodeInsert(param);
    }
    //마케팅 플랜 디테일 워크플로우 캠페인 노드 조회
    @RequestMapping(value="/planNodeSelect.do",method = RequestMethod.POST)
    public @ResponseBody
    List<MktWorkFlowPlanListResDto> planNodeSelect(HttpServletRequest request, HttpServletResponse response, @RequestBody MktWorkFlowPlanListReqDto param){
        LogUtil.param(this.getClass(), param);
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.planNodeSelect(param);
    }
    //마케팅 플랜 디테일 워크플로우 수정  
    @RequestMapping(value="/planNodeUpdate.do",method = RequestMethod.POST)
    public @ResponseBody StatusResDto planNodeUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody MktplanNodeUpdateReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.planNodeUpdate(param);
    }
    //마케팅 플랜 디테일 워크플로우 노드 삭제
    @RequestMapping(value="/planNodeDelete.do",method = RequestMethod.POST)
    public @ResponseBody StatusResDto planNodeUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody MktplanNodeDeleteReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.planNodeDelete(param);
    }

    //마케팅 플랜 디테일 워크플로우 수정  
    @RequestMapping(value="/planAllNodeUpdate.do",method = RequestMethod.POST)
    public @ResponseBody StatusResDto planAllNodeUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody MktplanAllNodeUpdateReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);

        return MktPlanService.planAllNodeUpdate(param);
    }
    
}
