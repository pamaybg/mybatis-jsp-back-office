package com.icignal.kepler.analysis.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListByCustTierReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListByCustTypeReqDto;
import com.icignal.kepler.analysis.service.KprCustomerAnalysisService;


/*
 * 1. 클래스명	: KPRCustomerAnalysisController
 * 2. 파일명	: KPRCustomerAnalysisController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/customerAnalysis" })
public class KprCustomerAnalysisController extends CommonController {
	
	@Autowired
    private KprCustomerAnalysisService kprCustomerAnalysisService;
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getAnalysisListByCustType
	  * 2. 클래스명: KPRCustomerAnalysisController
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
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
	 */
	@RequestMapping(value = { "/getAnalysisListByCustType.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List getAnalysisListByCustType(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisListByCustTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		return kprCustomerAnalysisService.getAnalysisListByCustType(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getAnalysisListByCustTier
	  * 2. 클래스명: KPRCustomerAnalysisController
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
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
	 */
	@RequestMapping(value = { "/getAnalysisListByCustTier.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List getAnalysisListByCustTier(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisListByCustTierReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		return kprCustomerAnalysisService.getAnalysisListByCustTier(reqDto);
	}

}