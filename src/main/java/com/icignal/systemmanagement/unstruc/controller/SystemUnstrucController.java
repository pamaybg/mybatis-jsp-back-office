package com.icignal.systemmanagement.unstruc.controller;

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
import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucDetailReqDto;
import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucListReqDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucDetailResDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucListResDto;
import com.icignal.systemmanagement.unstruc.service.SystemUnstrucService;

/*
 * 1. 클래스명	: SystemUnstrucController
 * 2. 파일명	: SystemUnstrucController.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.controller
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 함수 유형 관리형 Controller
 * </PRE>
 */
@Controller
@RequestMapping("/system/unstruc")
public class SystemUnstrucController extends BaseController {

	@Autowired
	public SystemUnstrucService systemUnstrucService;
	
	@Autowired
	AuthHelper authHelper;


	 /*
	  * 1. 메소드명: getLoyUnstrucList
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim
	  * 4. 작성일자: 2017. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		 이벤트 정형/비정형 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getUnstrucList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemUnstrucListResDto> getLoyUnstrucList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemUnstrucListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemUnstrucService.getLoyUnstrucList(param);
	}

	 /*
	  * 1. 메소드명: getUnstrucItem
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getUnstrucItem.do", method = RequestMethod.POST)
	public @ResponseBody SystemUnstrucDetailResDto getUnstrucItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemUnstrucService.getLoyUnstrucItem(param);
	}

	 /*
	  * 1. 메소드명: getUsingByCampaignChk
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형을 사용하고 있는 캠페인 체크 (수정, 삭제 불가 조건)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return Integer
	 */
	@RequestMapping(value = "/getUnstrucUsingByCampaignChk.do", method = RequestMethod.POST)
	public @ResponseBody SystemUnstrucDetailResDto getUsingByCampaignChk(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return systemUnstrucService.getUsingByCampaignChk(param);
	}

	 /*
	  * 1. 메소드명: getUnstrucChk
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getUnstrucChk.do", method = RequestMethod.POST)
	public @ResponseBody SystemUnstrucDetailResDto getUnstrucChk(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemUnstrucService.getUnstrucChk(param);
	}

	 /*
	  * 1. 메소드명: addUnstrucItem
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/addUnstrucItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addUnstrucItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemUnstrucService.addUnstrucItem(param);

	}

	 /*
	  * 1. 메소드명: editUnstrucItem
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/editUnstrucItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editUnstrucItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemUnstrucService.editUnstrucItem(param);
	}

	 /*
	  * 1. 메소드명: removeUnstrucItem
	  * 2. 클래스명: LoyUnstrucController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/removeUnstrucItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeUnstrucItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemUnstrucService.removeUnstrucItem(param);
	}
}
