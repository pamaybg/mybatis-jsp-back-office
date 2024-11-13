package com.icignal.kepler.targetGroup.targetSimple.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.targetGroup.targetGroup.controller.KprTargetGroupController;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewSaveReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListTagetGroupReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListUpdateTagetGroupReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleGroupNameResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTagetGroupResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTargetGroupValueResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGridExcelListResDto;
import com.icignal.kepler.targetGroup.targetSimple.service.KprTargetSimpleService;


@Controller
@RequestMapping("/kepler/targetSimple")
public class KprTargetSimpleController extends BaseController {
	@Autowired
	public KprTargetSimpleService KprTargetSimpleService;
	@Autowired
	private AuthHelper authHelper;

	//그룹 컬럼 이름 조회
    @RequestMapping(value="/getTargetSimpleList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprGetTargetSimpleListResDto> getTargetSimpleList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

        return KprTargetSimpleService.aleadySelectGroupColName(param);
    }
    
	//그룹 이름 조회
    @RequestMapping(value="/getTargetSimpleGroupName.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprGetTargetSimpleGroupNameResDto> getTargetSimpleGroupName(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

        return KprTargetSimpleService.aleadySelectGroupName(param);
    }

	//신규 그룹 컬럼 이름 조회
    @RequestMapping(value="/getTargetSimpleListColNameCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprGetTargetSimpleListResDto> getTargetSimpleListColNameCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListNewReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

        return KprTargetSimpleService.selectGroupColNameCondition(param);
    }

	//신규 그룹 이름 조회
    @RequestMapping(value="/getTargetSimpleGroupTopNameCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprGetTargetSimpleGroupNameResDto> getTargetSimpleGroupTopNameCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListNewReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.selectGroupTopNameCondition(param);
    }
	//신규 심플 타겟팅 조건 삽입
    @RequestMapping(value="/setTargetSimpleGroupNameTargetingGroupCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setTargetSimpleGroupNameTargetingGroupCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListNewSaveReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.insertGroupNameTargetingGroupCondition(param);
    }
	//타겟 그룹 조회
    @RequestMapping(value="/getTargetGroupOfSimple.do", method = RequestMethod.POST)
	public @ResponseBody
	KprGetTargetSimpleListTagetGroupResDto getTargetGroupOfSimple(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListTagetGroupReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.selectTargetGroup(param);
    }
	//타겟 그룹 헤당 심플타겟팅 값 조회
    @RequestMapping(value="/getTargetSimpleGroupValue.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprGetTargetSimpleListTargetGroupValueResDto> getTargetSimpleGroupValue(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListTagetGroupReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.aleadySelectGroupValue(param);
    }
	//타겟 그룹 수정
    @RequestMapping(value="/getTargetSimpleGroupUpdate.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto getTargetSimpleGroupUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListUpdateTagetGroupReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.tarGetGroupValueUpdate(param);
    }
	//타겟팅 버튼
    @RequestMapping(value="/setTargetingCountBtn.do", method = RequestMethod.POST)
	public @ResponseBody
	KprGetTargetSimpleListNewSaveReqDto setTargetingCountBtn(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTargetSimpleListNewSaveReqDto  param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.insertTargetingCountBtn(param);
    }
    //심플디테일 그리드
    @RequestMapping(value="/getSimpleTargetList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto getTargetGroupTargetList(
            HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupTargetListReqDto param) {

		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return KprTargetSimpleService.selectSimpleTargetingGridList(param);
    }
    //리스트 엑셀 다운로드
  	@RequestMapping(value = "/getSimpleGridListExport.do", method = RequestMethod.POST)
  	public  
  	String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupTargetListReqDto reqDto, ModelMap model) {

		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<KprGridExcelListResDto> data = KprTargetSimpleService.selectSimpleTargetingGridList(reqDto);

  		model.addAttribute("result", data);
  		model.addAttribute("excelHeader", reqDto.getExcelHeader());
  		model.addAttribute("fileName", "Simple_Targeting");

  		return "ExcelView";
  	}
	//워크플로우 조건추출 목록 조회
    @RequestMapping(value="/getSimpleList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprTargetGroupListResDto> getSimpleList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupListReqDto tglr) {
		LogUtil.param(this.getClass(), tglr);
		tglr.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<KprTargetGroupListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = KprTargetSimpleService.selectSimpleList(tglr);

        return rtnValue;
    }

	/**
	 * @author : 이경영
	 * @description : 타겟그룹 컬럼 목록 모두 조회
	 */
	@RequestMapping(value="/getSimpleTargetGroupColumnAllList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprTargetGroupColumnListResDto>  getSimpleTargetGroupColumnAllList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupColumnListReqDto tgclr) {

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		//tgclr.setAccountId(loginInfo.getAccountOrgId());

		return KprTargetSimpleService.getSimpleTargetGroupColumnAllList(tgclr);
	}

	/**
	 * @author : 이경영
	 * @description : 타겟그룹 컬럼 목록 모두 조회
	 */
	@RequestMapping(value="/getSimpleTargetGroupColumnList.do", method = RequestMethod.POST)
	public @ResponseBody
	List<KprTargetGroupColumnListResDto>  getSimpleTargetGroupColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupColumnListReqDto tgclr) {

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		//tgclr.setAccountId(loginInfo.getAccountOrgId());

		return KprTargetSimpleService.getSimpleTargetGroupColumnList(tgclr);
	}
}
