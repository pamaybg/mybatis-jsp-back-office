/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromReactionController.java
 * 2. Package	: com.icignal.loyalty.promreaction.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 10:03:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.loyalty.promreaction.dto.request.LoyPromReactionListReqDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcExcelListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionDetailResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionListResDto;
import com.icignal.loyalty.promreaction.service.LoyPromReactionService;

/*
 * 1. 클래스명	: LoyPromReactionController
 * 2. 파일명	: LoyPromReactionController.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/promreaction")
public class LoyPromReactionController extends BaseController{
	@Autowired
	private LoyPromReactionService loyPromReactionService;

	@Autowired
	private AuthHelper authHelper;
	
	@RequestMapping(value="/getPromReactionList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyPromReactionListResDto> getPromReactionList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyPromReactionService.getPromReactionList(bccr);
	}
	
	@RequestMapping(value="/getPromReactDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyPromReactionDetailResDto getPromReactDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyPromReactionService.getPromReactDetail(bccr);
	}
	
	@RequestMapping(value="/getPromMbrCalcList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyPromMbrCalcListResDto> getPromMbrCalcList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyPromReactionService.getPromMbrCalcList(bccr);
	}
	
	@RequestMapping(value = "/promMbrCalcExcelListGrid.do", method = RequestMethod.POST)
	public String promMbrCalcExcelListGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromReactionListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyPromMbrCalcExcelListResDto> data = loyPromReactionService.getPromMbrCalcExcelList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "반응고객 목록");

		return "ExcelView";
	}
}
