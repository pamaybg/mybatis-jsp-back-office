package com.icignal.systemmanagement.pushmsg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMemberListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgDetailReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgInsertReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemTestPushResultListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMemberListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgDetailResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemTestPushResultListResDto;
import com.icignal.systemmanagement.pushmsg.service.SystemPushMsgMgtService;

/*
 * 1. 클래스명	: PushMsgMgtController
 * 2. 파일명	: PushMsgMgtController.java
 * 3. 패키지명	: com.icignal.systemmanagement.pushmsg.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - push message 관리 Controller
 * </PRE>
 */
@Controller
@RequestMapping("/system/pushMsg")
public class SystemPushMsgMgtController extends BaseController {

	@Autowired
	private SystemPushMsgMgtService syspushMsgMgtService;
	
	@Autowired
	AuthHelper authHelper;

	/*
	 * 1. 메소드명: getPushMsgList 
	 * 2. 클래스명: PushMsgMgtController 
	 * 3. 작성자명: mjpyo 
	 * 4. 작성일자: 2017. 04. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 리스트
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDTO
	 * @return
	 */
	@RequestMapping(value = "/getPushMsgList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemPushMsgListResDto> getPushMsgList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		return syspushMsgMgtService.getPushMsgList(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertPushMsg
	  * 2. 클래스명: PushMsgMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/insertPushMsg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertPushMsg(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemPushMsgInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		HttpSession session = request.getSession(true);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return syspushMsgMgtService.insertPushMsg(reqDTO, session);
	}

	 /*
	  * 1. 메소드명: getPushMsgDetail
	  * 2. 클래스명: PushMsgMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getPushMsgDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemPushMsgDetailResDto getPushMsgDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return syspushMsgMgtService.getPushMsgDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: getPushMemberList
	  * 2. 클래스명: PushMsgMgtController
	  * 3. 작성자명:  km1.park 
	  * 4. 작성일자: 2017. 7. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 발송 대상 선정을 위한 회원 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value = "/getPushMemberList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemPushMemberListResDto> getPushMemberList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemPushMemberListReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
//		reqDto.setCountry(loginInfo.getCountry());
//		reqDto.setAppServiceId(loginInfo.getAppServiceId());

		// Service Execution
		GridPagingResDto<SystemPushMemberListResDto> rtnValue = new GridPagingResDto<SystemPushMemberListResDto>();
		rtnValue = syspushMsgMgtService.getPushMemberList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTestPushResultList
	  * 2. 클래스명: PushMsgMgtController
	  * 3. 작성자명: km1.park
	  * 4. 작성일자: 2017. 7. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		테스트 푸시 발송 결과 조회(푸시 발송 대상자들의 발송 상태)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value = "/getTestPushResultList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemTestPushResultListResDto> getTestPushResultList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemTestPushResultListReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		//Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
//		reqDto.setCountry(loginInfo.getCountry());
//		reqDto.setAppServiceId(loginInfo.getAppServiceId());

		// Service Execution
		GridPagingResDto<SystemTestPushResultListResDto> rtnValue = new GridPagingResDto<SystemTestPushResultListResDto>();
		rtnValue = syspushMsgMgtService.getTestPushResultList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPushMsgCancel
	  * 2. 클래스명: PushMsgMgtController
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 취소
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/getPushMsgCancel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getPushMsgCancel(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		return syspushMsgMgtService.getPushMsgCancel(reqDTO);
	}
}
