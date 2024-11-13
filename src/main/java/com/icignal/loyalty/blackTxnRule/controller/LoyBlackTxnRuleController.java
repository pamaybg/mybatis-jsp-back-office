/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackTxnRuleController.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 4:49:06
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckMbrDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleListReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBlackRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBalckMbrDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackMbrListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleListResDto;
import com.icignal.loyalty.blackTxnRule.service.LoyBlackTxnRuleService;

/*
 * 1. 클래스명	: LoyBlackTxnRuleController
 * 2. 파일명	: LoyBlackTxnRuleController.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/blackTxnRule")
public class LoyBlackTxnRuleController extends BaseController{
	
	@Autowired
	private LoyBlackTxnRuleService loyBlackTxnRuleService;
	
	@Autowired
	private AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getBlackRuleList
	  * 2. 클래스명: LoyBlackTxnRuleController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	이상거래 정책 조회		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value="/getBlackRuleList.do", method = RequestMethod.POST)
    public @ResponseBody   GridPagingResDto<LoyBlackTxnRuleListResDto> getBlackRuleList( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleListReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.getBlackRuleList(reqDto);
    }
	
	@RequestMapping(value="/getBlackRuleMstDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyBlackTxnRuleDetailResDto getBlackRuleMstDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleListReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.selectBlackRuleMstDetail(reqDto);
    }
	
	@RequestMapping(value="/saveBlackRuleDetail.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveBlackRuleDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.saveBlackRuleDetail(reqDto);
    }
	
	@RequestMapping(value="/modifyBlackRuleDetail.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto modifyBlackRuleDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.modifyBlackRuleDetail(reqDto);
    }
	
	@RequestMapping(value="/getBlackRuleListTab.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyBlackRuleListResDto> getBlackRuleListTab( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.getBlackRuleListTab(reqDto);
    }
	
	@RequestMapping(value="/removeBlackRule.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeBlackRule( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.removeBlackRule(reqDto);
    }
	
	@RequestMapping(value="/removeBlackMst.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeBlackMst( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.removeBlackMst(reqDto);
    }
	
	@RequestMapping(value="/getBlackRuleDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyBlackRuleDetailResDto getBlackRuleDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.getBlackRuleDetail(reqDto);
    }
	
	@RequestMapping(value="/saveBlackRule.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveBlackRule( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.saveBlackRule(reqDto);
    }
	
	@RequestMapping(value="/modifyBlackRule.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto modifyBlackRule( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.modifyBlackRule(reqDto);
    }
	
	@RequestMapping(value="/getBlackMbrListTab.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyBlackMbrListResDto> getBlackMbrListTab( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.getBlackMbrListTab(reqDto);
    }
	
	@RequestMapping(value="/saveBlackMbr.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveBlackMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.saveBlackMbr(reqDto);
    }
	
	@RequestMapping(value="/modifyBlackMbr.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto modifyBlackMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.modifyBlackMbr(reqDto);
    }
	
	@RequestMapping(value="/getBlackMbrDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyBalckMbrDetailResDto getBlackMbrDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.getBlackMbrDetail(reqDto);
    }
	
	@RequestMapping(value="/modifyBlStat.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto modifyBlStat( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.modifyBlStat(reqDto);
    }
	
	@RequestMapping(value="/clearMaskBlackMbr.do", method = RequestMethod.POST)
    public @ResponseBody LoyBlackMbrListResDto clearMaskBlackMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.clearMaskBlackMbr(reqDto);
    }
	
	@RequestMapping(value="/removeBlackMbr.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeBlackMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBalckTxnRuleDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackTxnRuleService.removeBlackMbr(reqDto);
    }
}
