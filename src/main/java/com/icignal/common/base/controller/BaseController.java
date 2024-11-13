 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.base.controller;


import java.io.IOException;
import java.util.Arrays;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.common.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icignal.auth.dto.response.AuthorityResDto;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.auth.service.AuthCommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;


/**
 * 1. FileName	: ICignalCommonController.java
 * 2. Package	: com.icignal.common.controller
 * 3. Comments	:
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 4. 오후 7:30:31
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 4.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: ICignalCommonController
 * 2. 파일명	: ICignalCommonController.java
 * 3. 패키지명	: com.icignal.common.controller
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class BaseController extends BaseExceptionController {

   @Autowired AuthHelper authHelper;
   
   @Autowired AuthCommonService authCommonService;

	 /*
	  * 1. 메소드명: NavigateMenu
	  * 2. 클래스명: CommonController
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param name
	 *   @param request
	 *   @param response
	 *   @return
	 *   @throws NoSuchMethodException
	 *   @throws SecurityException	
	 */
	@RequestMapping(value = "/{name:.+}", method = RequestMethod.GET)
	public String NavigateMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) throws NoSuchMethodException, SecurityException {
		// LogUtil.debug(this.getClass().getName() + " NavigateMenu Method start...");
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		HttpSession session = request.getSession();
		String deviceInfo = null;
		if(session.getAttribute("deviceInfo") != null){
			deviceInfo = session.getAttribute("deviceInfo").toString();
		} else {
			deviceInfo = ".default-tiles";
		}

		//타일즈 타입 지정
		String tileTypeBuild = null;
		if (deviceInfo.equals("mobile") || deviceInfo.equals("tablet")) {
			tileTypeBuild = ".mobileDefault-tiles";
		} else {
			tileTypeBuild = ".default-tiles";
		}

		final String tileType = tileTypeBuild;
		
		 return Optional.ofNullable(annotationClass).map(o -> {
				String requestPath =  Arrays.asList(o.value()).stream().findFirst().get();
				String respUrl = requestPath + "/" + name +   tileType;
				if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfo(request, response, respUrl);
				return null;				 
			}).orElse("");
	
	}

	public boolean checkProgramAuth( String realReqPath, HttpServletRequest request, 
			HttpServletResponse response, Model model ) {
		
		HttpSession session = request.getSession(true);
		String loginRid = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		
		boolean checkAuth = BeansUtil.getApplicationProperty("icignal.auth.program-check", Boolean.class , false);
		if(!checkAuth) return true;
		String path = realReqPath;
		if(realReqPath.indexOf('.')!=-1) {
		path = realReqPath.substring(0,realReqPath.lastIndexOf('.'));
		}
		ProgramCache pc = authCommonService.getProgramAuth(loginRid,path);
		
       try {
		   if (authHelper.checkUserInfo(request, response)/* && checkACL(request, session)*/ && authHelper.checkPrivacyPage(request, session)) {
			   //접근권한이 없으면 메시지 출력
			   if (!pc.getSuccess()) {
				   JavaScriptStringUtil.setRPrintPopupWriter(response);
				   return false;
			   }
		   } else {
			   if(StringUtil.isEmpty(pc.getUrl())){
				   pc.setUrl("/login");
			   }
		   }
        } catch (IOException e) { LogUtil.error(e); return false; }
        model.addAttribute("pgmObject",pc.getObjectCache());
        model.addAttribute("pgmChild",pc.getProgramChild());
       
        return true;
		
	}
	
	public boolean checkIncludeProgramAuth( String realReqPath, HttpServletRequest request, 
			HttpServletResponse response, Model model ) {
		
		HttpSession session = request.getSession(true);
		String loginRid = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		
		boolean checkAuth = BeansUtil.getApplicationProperty("icignal.auth.program-check", Boolean.class , false);
		if(!checkAuth) return true;
		String path = realReqPath;
		if(realReqPath.indexOf('.')!=-1) {
			path = realReqPath.substring(0,realReqPath.lastIndexOf('.'));
				
		}
		
		ProgramCache pc = authCommonService.getProgramAuth(loginRid,path);
        model.addAttribute("pgmObject",pc.getObjectCache());
        model.addAttribute("pgmChild",pc.getProgramChild());
       
        return true;
		
	}
	
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
			HttpServletResponse response,Model model) {
		//System.out.println("NavigatePopMenu start.....");
		
		
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		//Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name + ".modal-tiles";
		
		//checkProgramAuth(respUrl, request ,response , model);
		
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}
	
	
	@RequestMapping(value = "/npopup/{name:.+}", method = RequestMethod.GET)
	public String NavigateNPopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();		
		String respUrl = requestPath + "/npopup/" + name;
		
		return respUrl;
	}
	


	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".include-tiles";
	
		if( checkIncludeProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}
	
	@RequestMapping(value = "/load/{name:.+}", method = RequestMethod.GET)
	public String NavigateLoadMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/" + name + ".modal-tiles";;
		String dprespUrl = requestPath + "/load/" + name + ".modal-tiles";;
	
		if( this.checkProgramAuth(dprespUrl, request ,response , model) ) return this.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}	
	
	public String checkUserInfoInclude(HttpServletRequest request, HttpServletResponse response, String respUrl) {
		return authHelper.checkUserInfoInclude(request, response, respUrl);
	}
	
	public LoginResDto checkLoginSession(HttpServletRequest request, HttpServletResponse response) {
		return authHelper.checkLoginSession(request, response);
	}
	
	public AuthorityResDto getAuthorityInfo(HttpSession session, String dataTypeCd) {
		return authHelper.getAuthorityInfo(session, dataTypeCd);
	}
	
	public AuthorityResDto getSessionAuthority(HttpServletRequest request) {
		return authHelper.getSessionAuthority(request);
	}

}

