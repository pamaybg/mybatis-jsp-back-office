/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMemberCardController.java
 * 2. Package	: com.icignal.loyalty.membershipcard.membercard.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 6. 오전 11:20:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmember.controller;

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
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import com.icignal.loyalty.membershipcard.cardmember.service.LoyMemberCardService;

/*
 * 1. 클래스명	: LoyMemberCardController
 * 2. 파일명	: LoyMemberCardController.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.membercard.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/membershipcard/cardmember")
public class LoyMemberCardController extends BaseController{
	
	@Autowired
	private LoyMemberCardService loyMemberCardService;
	
	@Autowired
	private AuthHelper authHelper;
	
	@RequestMapping(value="/getCardList.do", method = RequestMethod.POST)
	   public @ResponseBody GridPagingResDto<LoyIssuedCardResDto> getCardList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCardListReqDto param) {
	       LogUtil.param(this.getClass(), param);
	       param.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMemberCardService.getCardList(param);
	}
}
