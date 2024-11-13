package com.icignal.systemmanagement.intact.controller;

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
import com.icignal.systemmanagement.intact.dto.request.SystemIntactCheckReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactDetailReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactListReqDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactCheckResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactDetailResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactListResDto;
import com.icignal.systemmanagement.intact.service.SystemIntactService;

/*
 * 1. 클래스명	: SystemIntactController
 * 2. 파일명	: SystemIntactController.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.controller
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 관리 Controller
 * </PRE>
 */
@Controller
@RequestMapping("/system/intact")
public class SystemIntactController extends BaseController {

	@Autowired
	public SystemIntactService systemIntactService;
	
	@Autowired
	AuthHelper authHelper;

	 /*
	  * 1. 메소드명: getIntactList
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 관리 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getIntactList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemIntactListResDto> getIntactList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemIntactListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.getLoyIntactList(param);
	}

	 /*
	  * 1. 메소드명: getUnstrucItem
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getIntactItem.do", method = RequestMethod.POST)
	public @ResponseBody SystemIntactDetailResDto getUnstrucItem(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemIntactDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.getLoyIntactItem(param);
	}

	 /*
	  * 1. 메소드명: checkCampaignsUsingIntect
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형을 사용하는 캠페인이 있는지 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/checkCampaignsUsingIntect.do", method = RequestMethod.POST)
	public @ResponseBody SystemIntactCheckResDto checkCampaignsUsingIntect(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemIntactCheckReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.checkCampaignsUsingIntect(param);
	}

	 /*
	  * 1. 메소드명: checkDuplicationIntactType
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 중복 체크 체크컬럼 : loy.loy_intact_type.intact_type_1_cd (유형)
	 *		loy.loy_intact_type.intact_type_2_cd (유형상세)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/checkDuplicationIntactType.do", method = RequestMethod.POST)
	public @ResponseBody SystemIntactCheckResDto checkDuplicationIntactType(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemIntactCheckReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.checkDuplicationIntactType(param);
	}

	 /*
	  * 1. 메소드명: addIntactItem
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/addIntactItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addIntactItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemIntactDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.addIntactItem(param);
	}

	 /*
	  * 1. 메소드명: editIntactItem
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/editIntactItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editIntactItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemIntactDetailReqDto param) {
		LogUtil.param(this.getClass(), param); 
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.editIntactItem(param);
	}

	 /*
	  * 1. 메소드명: removeIntactItem
	  * 2. 클래스명: LoyIntactController
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		인터렉션 유형 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/removeIntactItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeIntactItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemIntactDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemIntactService.removeIntactItem(param);
	}
}
