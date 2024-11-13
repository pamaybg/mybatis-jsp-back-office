/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemResponseInfoController.java
 * 2. Package	: com.icignal.systemmanagement.responseinfo.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 6. 오후 2:37:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.responseinfo.controller;

import java.util.Arrays;

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
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemDelResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemGetResponseInfoDetailReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemModifyResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemSetResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemGetResponseInfoDetailResDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemResponseInfoResDto;
import com.icignal.systemmanagement.responseinfo.service.SystemResponseInfoService;



/*
 * 1. 클래스명	: SystemResponseInfoController
 * 2. 파일명	: SystemResponseInfoController.java
 * 3. 패키지명	: com.icignal.systemmanagement.responseinfo.controller
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
@RequestMapping("system/responseInfo")
public class SystemResponseInfoController extends BaseController{
	
	@Autowired
	private SystemResponseInfoService systemResponseInfoService;
	
	@Autowired
	private AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;

    	String result = authHelper.checkUserInfoInclude(request, response, respUrl);
    	return result;
	}
	
	/**
	 * @name : getResponseInfoList
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : GridPagingResDto<>
	 * @description : 반응정보 목록 조회
	 */
	@RequestMapping(value="/getResponseInfoList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemResponseInfoResDto>  getResponseInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemResponseInfoReqDto rir) {
		LogUtil.param(this.getClass(),rir);	
		
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		return systemResponseInfoService.getResponseInfoList(rir);
		
	}
	 /**
	 * @name : getResponseInfoDetail
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : MKTResponseInfoDetailResponseDTO
	 * @description : 반응정보 목록 세부사항
	 */
	@RequestMapping(value="/getResponseInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetResponseInfoDetailResDto getResponseInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetResponseInfoDetailReqDto grir) {
		LogUtil.param(this.getClass(),grir);	
		
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		return systemResponseInfoService.getResponseInfoDetail(grir);
	}	
	 /**
	 * @name : insertResponseInfo
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 반응정보 추가
	 */
	@RequestMapping(value="/insertResponseInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto insertResponseInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetResponseInfoReqDto srir) {
		LogUtil.param(this.getClass(),srir);	
			
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		srir.setCreateBy(loginInfo.getEmpId());
		srir.setModifyBy(loginInfo.getEmpId());
		
		return systemResponseInfoService.insertResponseInfo(srir);
	}
	 /**
	 * @name : updateResponseInfo
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 반응정보 목록 수정
	 */
	@RequestMapping(value="/updateResponseInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto updateResponseInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemModifyResponseInfoReqDto mrir) {
		LogUtil.param(this.getClass(),mrir);	

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mrir.setModifyBy(loginInfo.getEmpId());
		
		return systemResponseInfoService.updateResponseInfo(mrir);
	}
	
	 /**
	 * @name : deleteResponseInfo
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 반응정보 목록 삭제
	 */
	@RequestMapping(value="/deleteResponseInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto deleteResponseInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDelResponseInfoReqDto drir) {
		LogUtil.param(this.getClass(),drir);	
			
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		drir.setModifyBy(loginInfo.getEmpId());
		
		
		return systemResponseInfoService.deleteResponseInfo(drir);
	}
	
}
