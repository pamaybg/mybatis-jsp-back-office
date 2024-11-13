package com.icignal.marketing.fatigue.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.marketing.fatigue.dto.response.MktFatigueChnlItemResDto;
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
import com.icignal.marketing.fatigue.dto.request.MktDeleteFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueModifyReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueDetailReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueSetReqDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueDetailResDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueResDto;
import com.icignal.marketing.fatigue.service.MktFatigueService;






/**
 * @name : 피로도 Controller
 * @date : 2015. 11. 30.
 * @author 안형욱
 * @description : 피로도 컨트롤러
 */

@Controller
@RequestMapping("/marketing/fatigue")
public class MktFatigueController extends BaseController{
	@Autowired
	private MktFatigueService fatigueService;
	

	 /**
	 * @name : getFatigueList
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : MKTFatigueResponseDTO
	 * @description : 피로도 목록 조회
	 */
	@RequestMapping(value="/getFatigueList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktFatigueResDto> getFatigueList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);	
		
		LoginResDto loginInfo = this.checkLoginSession(request, response);	
		//dto.setAccountId(loginInfo.getAccountOrgId());
		
		return fatigueService.getFatigueList(dto);
	}
	
	 /**
	 * @name : getFatigueDetail
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : MKTFatigueDetailResponseDTO
	 * @description : 선택된 피로도 세부사항
	 */
	@RequestMapping(value="/getFatigueDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	MktFatigueDetailResDto getFatigueDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueDetailReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);
		return fatigueService.getFatigueDetail(dto);
	}	
	
	 /**
	 * @name : InsertFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 피로도추가
	 */
	@RequestMapping(value="/insertFatigue.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto insertFatigue(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueSetReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);	
		
		LoginResDto loginInfo = this.checkLoginSession(request, response);	
		dto.setLoginInfo(loginInfo);
		//dto.setAccountId(loginInfo.getAccountOrgId());
		
		return fatigueService.insertFatigue(dto);
	}		

	 /**
	 * @name : updateFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return :StautsResponseDTO
	 * @description : 피로도 수정
	 */
	@RequestMapping(value="/updateFatigue.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto updateFatigue(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueModifyReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);	

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		dto.setLoginInfo(loginInfo);
		//dto.setAccountId(loginInfo.getAccountOrgId());
		
		return fatigueService.updateFatigue(dto);
	}		

	 /**
	 * @name : deleteFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return :StautsResponseDTO
	 * @description : 피로도 삭제
	 */
	@RequestMapping(value="/deleteFatigue.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto deleteFatigue(HttpServletRequest request, HttpServletResponse response, @RequestBody MktDeleteFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);	

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		dto.setLoginInfo(loginInfo);
		//dto.setAccountId(loginInfo.getAccountOrgId());
		
		return fatigueService.deleteFatigue(dto);
	}


	/**
	 * @name : applyFatigue
	 * @date : 2022. 01. 21.
	 * @author : 윤법공
	 * @return : StatusResDto
	 * @description : 피로도 적용
	 */
	@RequestMapping(value="/applyFatigue.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto applyFatigue(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueModifyReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		dto.setLoginInfo((loginInfo));

		return fatigueService.applyFatigue(dto);
	}


	/**
	 * @name : unApplyFatigue
	 * @date : 2022. 01. 21.
	 * @author : 윤법공
	 * @return : StatusResDto
	 * @description : 피로도 적용해제
	 */
	@RequestMapping(value="/unApplyFatigue.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto unApplyFatigue(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueModifyReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		dto.setLoginInfo((loginInfo));

		return fatigueService.unApplyFatigue(dto);
	}

	/**
	 * @name : getFatigueChnlItemList
	 * @date : 2022. 01. 24.
	 * @author : hr.noh
	 * @return : GridPagingResDto<MktFatigueResDto>
	 * @description : 피로도 상세 채널 아이템 리스트
	 */
	@RequestMapping(value="/getFatigueChnlItemList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktFatigueResDto> getFatigueChnlItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);
		return fatigueService.getFatigueChnlItemList(dto);
	}

	/**
	 * @name : getFatigueItemDetail
	 * @date : 2022. 01. 24.
	 * @author : hr.noh
	 * @return : MktFatigueChnlItemResDto
	 * @description : 피로도 채널 아이템 상세팝업
	 */
	@RequestMapping(value="/getFatigueItemDetail.do", method = RequestMethod.POST)
	public @ResponseBody MktFatigueChnlItemResDto getFatigueItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		return fatigueService.getFatigueItemDetail(dto);
	}

	/**
	 * @name : addFatiItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 insert
	 */
	@RequestMapping(value="/addFatiItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addFatiItem(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		return fatigueService.addFatiItem(dto);
	}

	/**
	 * @name : editFatiItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 update
	 */
	@RequestMapping(value="/editFatiItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editFatiItem(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		return fatigueService.editFatiItem(dto);
	}

	/**
	 * @name : removeFatigueChnlItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 delete
	 */
	@RequestMapping(value="/removeFatigueChnlItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeFatigueChnlItem(HttpServletRequest request, HttpServletResponse response, @RequestBody MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueController.class,dto);

		return fatigueService.removeFatigueChnlItem(dto);
	}

}