/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: testCampaginController.java
 * 2. Package	: com.icignal.marketing.campaignhome.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 27. 오후 1:17:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.mobile.testCampagin.controller;
/*
 * 1. 클래스명	: CampaignHomeController
 * 2. 파일명	: testCampaginController.java
 * 3. 패키지명	: com.icignal.marketing.campaignhome.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 27.
 */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icignal.common.base.controller.BaseController;

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/mobileTest")
public class testCampaginController extends BaseController {

	@RequestMapping(value = "/mobile/{name:.+}", method = RequestMethod.GET)
	public String mobileMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		return this.checkUserInfoInclude(request, response, "mobile/" + name + ".mobileDefault-tiles");
	}	

}
