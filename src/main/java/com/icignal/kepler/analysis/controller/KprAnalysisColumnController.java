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
import com.icignal.kepler.analysis.dto.request.KprAnalysisColumnDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisColumnDetailResDto;


/*
 * 1. 클래스명	: KPRAnalysisColumnController
 * 2. 파일명	: KPRAnalysisColumnController.java
 * 3. 패키지명	: com.icignal.kepler.analysis.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/analysisColumn" })
public class KprAnalysisColumnController extends KprAnalysisCommonController {
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getAnalysisColumnList
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisColumnList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisColumnDetailResDto> getAnalysisColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.getAnalysisColumnList(reqDto);
	}

	 /*
	  * 1. 메소드명: getAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisColumnDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisColumnDetailResDto getAnalysisColumnDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.getAnalysisColumnDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: addAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/addAnalysisColumnDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisColumnDetailResDto> addAnalysisColumnDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.addAnalysisColumnDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisColumnDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisColumnDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.editAnalysisColumnDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnAllSequence
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisColumnAllSequence.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisColumnAllSequence(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.editAnalysisColumnAllSequence(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnTypeCodeChange
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisColumnTypeCodeChange.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisColumnTypeCodeChange(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.editAnalysisColumnTypeCodeChange(reqDto);
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnCombTypeChange
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisColumnCombTypeChange.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisColumnCombTypeChange(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.editAnalysisColumnCombTypeChange(reqDto);
	}

	 /*
	  * 1. 메소드명: removeAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/removeAnalysisColumnDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto removeAnalysisColumnDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.removeAnalysisColumnDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getAnalysisSameTableColumnList
	  * 2. 클래스명: KPRAnalysisColumnController
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisSameTableColumnList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisColumnDetailResDto> getAnalysisSameTableColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return this.kprAnalysisColumnService.getAnalysisSameTableColumnList(reqDto);
	}
}