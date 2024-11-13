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
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.controller.KprAnalysisCommonController;
import com.icignal.kepler.analysis.dto.request.KprAnalysisFilterDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDataResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisFilterDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisFilterController
 * 2. 파일명	: KPRAnalysisFilterController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/analysisFilter" })
public class KprAnalysisFilterController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getAnalysisFilterBase
	  * 2. 클래스명: KPRAnalysisFilterController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	 *   @param afr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisFilterBase.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisFilterDetailResDto getAnalysisFilterBase(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisController.class, afr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		afr.setEmpId(userInfo.getId());

		return this.kprAnalysisFilterService.getAnalysisFilterBase(afr);
	}

	 /*
	  * 1. 메소드명: getAnalysisFilterList
	  * 2. 클래스명: KPRAnalysisFilterController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	 *   @param afr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisFilterList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisFilterDetailResDto> getAnalysisFilterList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisController.class, afr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		afr.setEmpId(userInfo.getId());

		return this.kprAnalysisFilterService.getAnalysisFilterList(afr);
	}

	 /*
	  * 1. 메소드명: getAnalysisFilterDetailBase
	  * 2. 클래스명: KPRAnalysisFilterController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	 *   @param afr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisFilterDetailBase.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisFilterDetailResDto getAnalysisFilterDetailBase(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisController.class, afr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		afr.setEmpId(userInfo.getId());

		return this.kprAnalysisFilterService.getAnalysisFilterDetailBase(afr);
	}

	 /*
	  * 1. 메소드명: selectAnalysisFilterCheck
	  * 2. 클래스명: KPRAnalysisFilterController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	 *   @param afr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisFilterCheck.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDataResDto selectAnalysisFilterCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisController.class, afr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		afr.setEmpId(userInfo.getId());

		return this.kprAnalysisFilterService.getAnalysisFilterCheck(afr);
	}

	 /*
	  * 1. 메소드명: saveAnalysisFilterList
	  * 2. 클래스명: KPRAnalysisFilterController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
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
	 *   @param afr
	 *   @return	
	 */
	@RequestMapping(value = { "/saveAnalysisFilterList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto saveAnalysisFilterList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisController.class, afr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		afr.setEmpId(userInfo.getId());

		return this.kprAnalysisFilterService.saveAnalysisFilterList(afr);
	}
}