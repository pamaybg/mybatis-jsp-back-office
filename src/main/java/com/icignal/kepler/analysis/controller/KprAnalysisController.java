package com.icignal.kepler.analysis.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analysis.common.controller.KprAnalysisCommonController;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonGridReqDto;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisDetailReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisExternalReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisExternalResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisListResDto;


/*
 * 1. 클래스명	: KPRAnalysisController
 * 2. 파일명	: KPRAnalysisController.java
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
@RequestMapping({ "/kepler/analysis" })
public class KprAnalysisController extends KprAnalysisCommonController {

	@Autowired
	AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
			HttpServletResponse response,Model model) {		
		
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;
		
		
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}

	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;
	
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}

	 /*
	  * 1. 메소드명: getAnalysisList
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param alr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST})
	@ResponseBody
	public GridPagingResDto<KprAnalysisListResDto> getAnalysisList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisListReqDto alr) {
		LogUtil.param(KprAnalysisController.class, alr);
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		return this.kprAnalysisService.getAnalysisList(alr);
	}

	 /*
	  * 1. 메소드명: getAnalysisDetail
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDetailResDto getAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.getAnalysisDetail(adr);
	}

	 /*
	  * 1. 메소드명: getAnalysisName
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisName.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisDetailResDto getAnalysisName(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.getAnalysisName(adr);
	}

	 /*
	  * 1. 메소드명: addAnalysisDetail
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/addAnalysisDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto addAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.addAnalysisDetail(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailSave
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisDetailSave.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisDetailSave(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisDetailSave(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailSaveAs
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisDetailSaveAs.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisDetailSaveAs(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisDetailSaveAs(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisDetailCopy
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisDetailCopy.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisDetailCopy(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisDetailCopy(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisLogicalCompId
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisLogicalCompId.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisLogicalCompId(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisLogicalCompId(adr);
	}

	 /*
	  * 1. 메소드명: resetAnalysisDetail
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/resetAnalysisDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto resetAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.resetAnalysisDetail(adr);
	}

	 /*
	  * 1. 메소드명: removeAnalysisDetail
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/removeAnalysisDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto removeAnalysisDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.removeAnalysisDetail(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnGroupFlag
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisColumnGroupFlag.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisColumnGroupFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisColumnGroupFlag(adr);
	}

	 /*
	  * 1. 메소드명: editAnalysisChartTypeChange
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param adr
	 *   @return	
	 */
	@RequestMapping(value = { "/editAnalysisChartTypeChange.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public StatusResDto editAnalysisChartTypeChange(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisDetailReqDto adr) {
		LogUtil.param(KprAnalysisController.class, adr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		adr.setEmpId(userInfo.getId());

		return this.kprAnalysisService.editAnalysisChartTypeChange(adr);
	}

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnDetail
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param agc
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisAtribGroupColumnDetail.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public List<KprAnalysisAtribGroupColumnDetailResDto> getAnalysisAtribGroupColumnDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody KprAnalysisCommonReqDto agc) {
		LogUtil.param(KprAnalysisController.class, agc);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		return this.kprAnalysisService.getAnalysisAtribGroupColumnDetail(agc);
	}

	 /*
	  * 1. 메소드명: getAnalysisExtenalRequestBase
	  * 2. 클래스명: KPRAnalysisController
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
	 *   @param aer
	 *   @return	
	 */
	@RequestMapping(value = { "/getAnalysisExtenalRequestBase.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public KprAnalysisExternalResDto getAnalysisExtenalRequestBase(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisExternalReqDto aer) {
		LogUtil.param(KprAnalysisController.class, aer);

		return this.kprAnalysisService.getAnalysisExtenalRequestBase(aer);
	}

	 /*
	  * 1. 메소드명: getAnalysisAtribGroupColumnValueList
	  * 2. 클래스명: KPRAnalysisController
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
	@RequestMapping(value = { "/getAnalysisAtribGroupColumnValueList.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public GridPagingResDto<Object>  getAnalysisAtribGroupColumnValueList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisCommonGridReqDto reqDto) {
		LogUtil.param(KprAnalysisController.class, reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		return this.kprAnalysisService.getAnalysisAtribGroupColumnValueList(reqDto);
	}
}