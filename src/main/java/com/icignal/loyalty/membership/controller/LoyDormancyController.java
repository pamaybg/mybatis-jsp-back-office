/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyDormancyController.java
 * 2. Package	: com.icignal.loyalty.membership.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 26. 오후 2:53:18
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 26.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.membership.dto.request.LoyDormancyActiveReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyPredUserReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyReqDto;
import com.icignal.loyalty.membership.dto.response.LoyDormancyActiveResDto;
import com.icignal.loyalty.membership.dto.response.LoyDormancyPredResDto;
import com.icignal.loyalty.membership.dto.response.LoyDormancyResDto;
import com.icignal.loyalty.membership.service.LoyMbrService;

/*
 * 1. 클래스명	: LoyDormancyController
 * 2. 파일명	: LoyDormancyController.java
 * 3. 패키지명	: com.icignal.loyalty.membership.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/dormancy")
public class LoyDormancyController extends BaseController {
	@Autowired
	private LoyMbrService loyMbrService;

	@Autowired
	private AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getDormancyList
	  * 2. 클래스명: LoyDormancyController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value="/getDormancyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyDormancyResDto> getDormancyList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyDormancyReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
		encrypor.setPassword("9pwc3dke");

		return loyMbrService.getDormancyList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getDormancyPredUser
	  * 2. 클래스명: LoyDormancyController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value="/getDormancyPredUser.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyDormancyPredResDto> getDormancyPredUser(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyDormancyPredUserReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);

		StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
		encrypor.setPassword("9pwc3dke");


		return loyMbrService.getDormancyPredUser(reqDto);
//
	}
	
	 /*
	  * 1. 메소드명: activeDorMbr
	  * 2. 클래스명: LoyDormancyController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value="/activeDorMbr.do", method = RequestMethod.POST)
	public @ResponseBody LoyDormancyActiveResDto activeDorMbr(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyDormancyActiveReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setUri(request.getRequestURI());

		return loyMbrService.activeDorMbr(reqDto);
	}
	
	 /*
	  * 1. 메소드명: selectCustNm
	  * 2. 클래스명: LoyDormancyController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value="/selectCustNm.do", method = RequestMethod.POST)
	public @ResponseBody LoyDormancyResDto selectCustNm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyDormancyReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setUri(request.getRequestURI());

		return loyMbrService.selectCustNm(reqDto);
	}
}
