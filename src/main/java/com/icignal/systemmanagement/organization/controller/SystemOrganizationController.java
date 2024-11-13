package com.icignal.systemmanagement.organization.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.icignal.systemmanagement.organization.dto.request.SystemModifyOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationDetailReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationInfoListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganziationNodeListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemSetOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationDetailResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationInfoListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationNodeListResDto;
import com.icignal.systemmanagement.organization.service.SystemOrganizationService;


/*
 * 1. 클래스명	: SystemOrganizationController
 * 2. 파일명	: SystemOrganizationController.java
 * 3. 패키지명	: com.icignal.systemmanagement.organization.controller
 * 4. 작성자명	: jun.lee
 * 5. 작성일자	: 2017. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		조직관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/organization")
public class SystemOrganizationController extends BaseController{
	
		@Autowired
		private SystemOrganizationService systemOrganizationService;
		
		@Autowired
		AuthHelper authHelper;
	 
		/**
		 * @name : getOrganizationList
		 * @date : 2017. 2. 20.
		 * @author : jun.lee
		 * @return : GridPagingResDto
		 * @description : 조직관리 리스트 조회 
		 */
		@RequestMapping(value="/getOrganizationList.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<SystemOrganizationListResDto> getOrganizationList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemOrganizationListReqDto dto) {
			LogUtil.param(SystemOrganizationController.class,dto);	
			
			LoginResDto loginInfo =  authHelper.checkLoginSession(request, response);
	        dto.setLoginInfo(loginInfo);
	        
			return systemOrganizationService.getOrganizationList(dto);
		}
			
		
		/**
		 * @name : getOrganizationDetailList
		 * @date : 2017. 2. 20.
		 * @author : jun.lee
		 * @return : SystemOrganizationDetailResDto
		 * @description : 조직관리 상세 조회 
		 */
		@RequestMapping(value="/getOrganizationDetail.do", method = RequestMethod.POST)
		public @ResponseBody
		SystemOrganizationDetailResDto getOrganizationDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemOrganizationDetailReqDto dto) {
	        LogUtil.param(SystemOrganizationController.class, dto);
	        
	        LoginResDto loginInfo =  authHelper.checkLoginSession(request, response);
	        dto.setLoginInfo(loginInfo);
	        
	        return systemOrganizationService.getOrganizationDetail(dto);
	    }
		
		/**
		 * @name : insertOrganization
		 * @date : 2017. 2. 21.
		 * @author : jun.lee
		 * @return : StatusResDto
		 * @description : 조직관리 추가 
		 */
		@RequestMapping(value="/insertOrganization.do", method = RequestMethod.POST)
		public @ResponseBody
		StatusResDto insertOrganization(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetOrganizationReqDto dto) {
	        LogUtil.param(SystemOrganizationController.class, dto);
	         
	        LoginResDto loginInfo =  authHelper.checkLoginSession(request, response);
	        dto.setLoginInfo(loginInfo);
	        
	        return systemOrganizationService.insertOrganization(dto);
	    }
		
		
		/**
		 * @name : updateOrganization
		 * @date : 2017. 2. 21.
		 * @author : jun.lee
		 * @return : StatusResDto
		 * @description : 조직관리 수정 
		 */
		@RequestMapping(value="/updateOrganization.do", method = RequestMethod.POST)
		public @ResponseBody
		StatusResDto updateOrganization(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemModifyOrganizationReqDto dto) {
	        LogUtil.param(SystemOrganizationController.class, dto);
	         
	        LoginResDto loginInfo =  authHelper.checkLoginSession(request, response);
	        dto.setLoginInfo(loginInfo);
	        
	        return systemOrganizationService.updateOrganization(dto);
	    }
		
		/**
		 * @name : getOrganizationInfoList
		 * @date : 2017. 2. 27.
		 * @author : jun.lee
		 * @return : GridPagingResDto
		 * @description : 조직정보 리스트 조회 
		 */
		@RequestMapping(value="/getOrganizationInfoList.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<SystemOrganizationInfoListResDto> getOrganizationInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemOrganizationInfoListReqDto dto) {
			LogUtil.param(SystemOrganizationController.class,dto);	
			
			LoginResDto loginInfo =  authHelper.checkLoginSession(request, response);
	        dto.setLoginInfo(loginInfo);
	        
			return systemOrganizationService.getOrganizationInfoList(dto);
		}
		
		 /*
		  * 1. 메소드명: getNodeList
		  * 2. 클래스명: SystemOrganizationController
		  * 3. 작성자명: 
		  * 4. 작성일자: 2020. 3. 5.
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
		 *   @param nlr
		 *   @return	
		 */
		@RequestMapping(value = "/getOrganizationNodeList.do", method = RequestMethod.POST)
		public @ResponseBody
		SystemOrganizationNodeListResDto getNodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemOrganziationNodeListReqDto nlr) {
			LogUtil.param(SystemOrganizationController.class, nlr);

			LoginResDto userInfo =  authHelper.checkLoginSession(request, response);
			nlr.setEmpId(userInfo.getId());

			return systemOrganizationService.getNodeList(nlr);
		}

}
