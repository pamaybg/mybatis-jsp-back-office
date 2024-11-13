/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrController.java
 * 2. Package	: com.icignal.loyalty.blackMbr.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 10. 오후 3:38:18
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackMbr.controller;

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
import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrDetailReqDto;
import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrListReqDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrDetailResDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrListResDto;
import com.icignal.loyalty.blackMbr.service.LoyBlackMbrService;

/*
 * 1. 클래스명	: LoyBlackMbrController
 * 2. 파일명	: LoyBlackMbrController.java
 * 3. 패키지명	: com.icignal.loyalty.blackMbr.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/blackListMbr")
public class LoyBlackMbrController extends BaseController{
	
	@Autowired
	private LoyBlackMbrService loyBlackMbrService;
	
	@Autowired
	private AuthHelper authHelper;
	
	@RequestMapping(value="/getBlackMbrList.do", method = RequestMethod.POST)
    public @ResponseBody   GridPagingResDto<LoyBlackMbrListResDto> getBlackMbrList( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrListReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.getBlackMbrList(reqDto);

    }
	
	@RequestMapping(value="/getBlackMbrDetail.do", method = RequestMethod.POST)
    public @ResponseBody  LoyBlackMbrDetailResDto getBlackMbrDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrListReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.getBlackMbrDetail(reqDto);

    }
	
	@RequestMapping(value="/saveBlackMbrDetail.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto saveBlackMbrDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.saveBlackMbrDetail(reqDto);

    }
	
	@RequestMapping(value="/modifyBlackMbrDetail.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto modifyBlackMbrDetail( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.modifyBlackMbrDetail(reqDto);

    }
	
	@RequestMapping(value="/clearMaskBlackMbr.do", method = RequestMethod.POST)
    public @ResponseBody  LoyBlackMbrListResDto clearMaskBlackMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.clearMaskBlackMbr(reqDto);
    }
	
	@RequestMapping(value="/removeBlackListMbr.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto removeBlackListMbr( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyBlackMbrDetailReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyBlackMbrService.removeBlackListMbr(reqDto);

    }
}
