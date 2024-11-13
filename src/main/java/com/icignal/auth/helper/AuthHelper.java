 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

 package com.icignal.auth.helper;

 import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.icignal.auth.dto.request.AuthorityReqDto;
import com.icignal.auth.dto.request.LoginReqDto;
import com.icignal.auth.dto.response.AuthorityGroupListResDto;
import com.icignal.auth.dto.response.AuthorityMenuListResDto;
import com.icignal.auth.dto.response.AuthorityResDto;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.exception.LoginWrongUserInfoException;
import com.icignal.auth.service.AuthCommonService;
import com.icignal.auth.service.LoginService;
import com.icignal.common.base.dto.response.CookieResDto;
import com.icignal.common.base.dto.response.ScrollPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.cache.ehcache.CacheCommon;
import com.icignal.common.cache.service.CacheManagerService;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.session.SessionUtility;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.AUTH_GROUP_TYPE_CD;
import com.icignal.common.util.CookieUtil;
import com.icignal.common.util.HttpUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.exception.DataUnauthrizedException;

import net.sf.ehcache.CacheManager;


/**
 * 1. FileName	: AuthorityHelper.java
 * 2. Package	: com.icignal.common.auth.helper
 * 3. Comments	:
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 18. 오후 1:03:03
 * 6. History	:
 * <p>
 * -----------------------------------------------------------------
 * <p>
 * Date		 |	Name			|	Comment
 * <p>
 * -------------  -----------------   ------------------------------
 * <p>
 * 2020. 2. 18.		 | knlee			|	최초작성
 * <p>
 * -----------------------------------------------------------------
 */

 /*
  * 1. 클래스명	: AuthorityHelper
  * 2. 파일명	: AuthorityHelper.java
  * 3. 패키지명	: com.icignal.common.auth.helper
  * 4. 작성자명	: knlee
  * 5. 작성일자	: 2020. 2. 18.
  */

 /**
  * <PRE>
  * 1. 설명
  *
  * </PRE>
  */
 @Component
 public class AuthHelper {

     @Autowired
     CacheManagerService cacheManagerService;

     @Autowired
     CacheManager cachemanager;

     @Autowired
     private LoginService loginService;

     @Autowired
     AuthCommonService authCommonService;


     /**
      * @return :
      * @programId :
      * @name : checkUserInfo
      * @date : 2016. 6. 27.
      * @author : 류동균
      * @table :
      * @description : 사용자 정보 확인
      */
     public String checkUserInfo(HttpServletRequest request, HttpServletResponse response, String redirectUri) {

         String rtnValue = "base/login/login.defaultFull-tiles";
         // 현 URL Session 담기
         HttpSession session = request.getSession(true);
         //기기별 세션 가져와서 tiles 분기
         String deviceInfo = null;
         if(session.getAttribute("deviceInfo") != null){
             deviceInfo = session.getAttribute("deviceInfo").toString();
         }
         // 접근허용프로그램 체크 로직(checkACL) 추가. knlee
         // 2019.01.31 hy.jun 다이소 요청으로 개인정보처리메뉴 접근제한 추가
         if (this.checkUserInfo(request, response)/* && checkACL(request, session)*/ && checkPrivacyPage(request, session)) {
                 // 세션이 있고 로그인페이지 일 경우 현재 세션의 첫번째 화면으로 이동
             if ("base/login/login.defaultFull-tiles".equals(redirectUri)) {

                 @SuppressWarnings("unchecked")
                 List<AuthorityMenuListResDto> menuList = (List<AuthorityMenuListResDto>) session.getAttribute("menuDump");

                 String url = "";
                 for (AuthorityMenuListResDto menu : menuList) {
                     if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                         url = menu.getProgPath().replaceAll(".jsp", "");
                         break;
                     }
                 }

                 rtnValue = "base/login/goPage.defaultFull-tiles";

                 session.setAttribute("URL", url);
                 session.setAttribute("URL_INCLUDE", "");
             } else if("base/login/mlogin.mobileFull-tiles".equals(redirectUri)){

                 @SuppressWarnings("unchecked")
                 List<AuthorityMenuListResDto> menuList = (List<AuthorityMenuListResDto>) session.getAttribute("menuDump");

                 String url = "";
                 for (AuthorityMenuListResDto menu : menuList) {
                     if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                         url = menu.getProgPath().replaceAll(".jsp", "");
                         break;
                     }
                 }

                 rtnValue = "base/login/goPage.mobileFull-tiles";

                 session.setAttribute("URL", url);
                 session.setAttribute("URL_INCLUDE", "");
             }
             else {
                 rtnValue = redirectUri;

                 session.setAttribute("URL", rtnValue);
                 session.setAttribute("URL_INCLUDE", "");
             }
         }

         // 세션이 없고 로그인 페이지 호출시 defaultFull
         else if ("base/login/login.defaultFull-tiles".equals(redirectUri)) {
             rtnValue = "base/login/login.defaultFull-tiles";
         }
         //mobileFull
         else if ("base/login/mlogin.mobileFull-tiles".equals(redirectUri)){
             rtnValue = "base/login/mlogin.mobileFull-tiles";
         }
         // 세션이 없고 로그인 페이지가 아닐 경우
         else {
             if(StringUtil.isNotEmpty(deviceInfo)) {
                 if (deviceInfo.equals("mobile") || deviceInfo.equals("tablet")) {
                     rtnValue = "base/login/mlogin.mobileFull-tiles";
                 } else {
                     rtnValue = "base/login/loginEmpty.defaultFull-tiles";
                 }
             } else {
                 rtnValue = "base/login/loginEmpty.defaultFull-tiles";
             }
         }

         return rtnValue;
     }

     /**
      * @return :
      * @programId :
      * @name : checkUserInfo
      * @date : 2016. 6. 27.
      * @author : 류동균
      * @table :
      * @description : 사용자 정보 확인
      */
     public boolean checkUserInfo(HttpServletRequest request, HttpServletResponse response) {
         boolean rtnValue = false;

         HttpSession session = request.getSession(true);
         if (Boolean.parseBoolean(BeansUtil.getApplicationProperty("icignal.login.sso.check")) && request.getCookies() != null) {
             Cookie currCookie = CookieUtil.getSSOCookie(request);

             if (currCookie != null) rtnValue = true;


             if (currCookie != null && session.getAttribute(CommonUtil.USER_INFO_PROP) == null) {
                 CookieResDto cr = CookieUtil.getUserData(currCookie);

                 if (cr != null) {
                     // 자동 로그인 처리 & location 변경
                     LoginReqDto lr = new LoginReqDto();
                     lr.setLang(cr.getLang());
                     lr.setId(cr.getId());

                     this.loginConfirm(lr, request, response);

                     LoginResDto result = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
                     result.setSuccess(true);
                     CookieUtil.createCookie(request, response, result.getId(), "", "", result.getLang());

                 }
             } else if (currCookie == null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
                 this.initSession(session);
             }
         } else {
             if (ObjectUtil.isNotEmpty(session.getAttribute(CommonUtil.USER_INFO_PROP)) && ObjectUtil.isNotEmpty(SessionUtility.getSession(session.getId(), true))) {
                 rtnValue = true;
             }
         }

         return rtnValue;
     }

     public StatusResDto loginConfirm(LoginReqDto lr, HttpServletRequest request, HttpServletResponse response) {
         LogUtil.param(this.getClass(), lr);

         StatusResDto rtnValue = new ScrollPagingResDto();
         HttpSession session = request.getSession(true);
         Map<String, String> map = new HashMap<>();
         CacheCommon cacheCommon = new CacheCommon();

         lr.setSessnId(session.getId());

         InetAddress inetAddress2 = null;
         try {
             inetAddress2 = InetAddress.getLocalHost();
         } catch (UnknownHostException e) {
             LogUtil.error(e);
         }

         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         Calendar c1 = Calendar.getInstance();

         String strIpAdress = inetAddress2.getHostAddress();
         lr.setIp(strIpAdress);

         lr.setLastLoginDate(loginService.getLastLoginDate(lr));

         String deviceInfo = null;
         if(StringUtil.isNotEmpty(session.getAttribute("deviceInfo"))) {
             deviceInfo = session.getAttribute("deviceInfo").toString();
         }

         LoginResDto result = loginService.loginConfirm(lr);  // 로그인 요청 정보(이메일, 패스워드 등)가 실제 DB데이터와 일치하는지 확인하고 일치하면 해당 유저의 상세 정보 반환

         result.setDeviceInfo(deviceInfo);

         if (result.getSuccess()) { // 성공일 경우 세션에 사용자 정보 추가
             boolean isDuplicatedLogin = false;
             if (BeansUtil.getApplicationProperty("icignal.login.dupl-login-limit", Boolean.class)
                     && !lr.isDoubleAuthCheckPassUser()) isDuplicatedLogin = true;
             if (!result.getUserId().equals("mktmaster@quintet.co.kr") && !result.getUserId().equals("loymaster@quintet.co.kr") && isDuplicatedLogin) {  //중복로그인 체크
                 HttpSession prevSession = SessionUtility.getSession(result.getId(), false);
                 if (ObjectUtil.isNotEmpty(prevSession)) {
                     boolean preSessionAbortYn = lr.isPreSessionAbortYn();

                     //기존 로그인 세션 종료 여부 체크
                     if (preSessionAbortYn) {
                         String ip = (String) session.getAttribute(SessionCommon.SESSION_IP);
                         String ipDate = (String) session.getAttribute(SessionCommon.SESSION_IP_DATE);
                         session.getAttribute(CommonUtil.USER_INFO_PROP);
                         //기존 로그인 세션 종료
                         map.put("duplicatedLogin", "false");
                         SessionUtility.removeSession(prevSession);
                         session = request.getSession(true);
						/*rtnValue.setMessage("다른 컴퓨터 Ip주소: "+ip+ "가 \n이미 로그인(로그인시간: "+ipDate+")되어있습니다\n 기존 세션을 삭제하겠습니다 다시 로그인버튼을 눌러주세요");
						return rtnValue;*/
                         //rtnValue.setMessage("다른 컴퓨터 Ip:~~~~~~~~~~ 가 이미 계정으로 로그인(로그인시간~~~~~~)되어있습니다. 기존 계정세션을 삭제하고 새로 로그인하겠습니다.);
                     } else {
                         //기존 로그인 세션 종료 여부 확인
                         map.put("duplicatedLogin", "true");

                         rtnValue.setSuccess(true);
                         rtnValue.setMessage(HttpUtil.covertJsonString(map));

                         return rtnValue;
                     }
                 } else {
                     map.put("duplicatedLogin", "false");
                 }
             } else {
                 map.put("duplicatedLogin", "false");
             }

             //세션 Utility에서 사용자별로 세션 관리를 위해 키값을 추가
             result.setSessionId(session.getId());
             if (result.getLang() == null || result.getLang().length() == 0) {
                 result.setLang(CommonUtil.DEFAULT_LANG);
             }


             session.setAttribute(SessionCommon.SESSIONID_PROP, session.getId());
             session.setAttribute(CommonUtil.USER_INFO_PROP, result);
             session.setAttribute(CommonUtil.LANG, lr.getLang());
             //소스 리펙토링 후 적용 소스
             session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());


             //DB에서 로그인한 사용자가 등록된 권한그룹의 프로그램과 오브젝트(버튼)목록을 조회
             List<ProgramCache> proResDto = authCommonService.getLoginAuthList(result.getId());
             //가져온 프로그램과 오브젝트(버튼)목록을 캐시에 저장
             cacheCommon.createCache(cachemanager, result.getId(), proResDto, "ProgramCache");

             //권한 Request
             AuthorityReqDto authReq = new AuthorityReqDto();
             authReq.setEmpId(result.getEmpId());
             authReq.setRidUser(result.getId());
             authReq.setLang(lr.getLang());
             authReq.setDeviceInfo(deviceInfo);

             //권한 조회
             AuthorityResDto auth = authCommonService.getAuthority(authReq);
             auth.setRidDivision(result.getOrgId());

             session.setAttribute(CommonUtil.SESSIONID_AUTH, auth);
             List<AuthorityMenuListResDto> moMenuData = new ArrayList<>();

             //세션에 들어 갈 권한 메뉴 목록 분기
             for (AuthorityMenuListResDto menuData : auth.getAuthMenuList()) {
                 if(StringUtil.isNotEmpty(deviceInfo)) {
                     if (deviceInfo.equals("mobile") || deviceInfo.equals("tablet")) {
                         if (menuData.getMobileYn().equals("Y")) {
                             moMenuData.add(menuData);
                         }
                     } else {
                         if (menuData.getMobileYn().equals("N")) {
                             moMenuData.add(menuData);
                         }
                     }
                 } else {
                     if (menuData.getMobileYn().equals("N")) {
                         moMenuData.add(menuData);
                     }
                 }
             }
             auth.setAuthMenuList(moMenuData);

             //세션에 권한 메뉴 목록 담기
             session.setAttribute("menuDump", auth.getAuthMenuList());

             if (result.getMessage().contains("pwChangeExp")) {
                 map.put("pwChangeExp", "true");
             } else {
                 map.put("pwChangeExp", "false");
             }

             /*
              * URL
              * 메뉴 목록 확인 및 첫번째 메뉴의 URL 확인
              * 권한그룹 유형 VOC 일 경우 : /voc
              * 그외 첫번째 메뉴 URL
              */
             if (ObjectUtil.isNotEmpty(auth.getAuthMenuList())) {

                 boolean vocFlag = false;
                 for (AuthorityGroupListResDto authGroup : auth.getAuthGroupList()) {
                     if (AUTH_GROUP_TYPE_CD.VOC.toString().equals(authGroup.getType())) {
                         vocFlag = true;
                     }
                 }

                 //첫 로그인일 경우 비밀번호 변경 필수
                 if (result.getFirstLoginFlag().equals("1")) {
                     map.put("pwChangeFirst", "true");
                 } else {
                     map.put("pwChangeFirst", "false");
                 }

                 if (vocFlag) {
                     map.put("url", "voc");
                 } else {

                     //URL을 가진 Menu 확인
                     String url = "";
                     for (AuthorityMenuListResDto menu : auth.getAuthMenuList()) {
                         if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                             url = menu.getProgPath();
                             break;
                         }
                     }

                     map.put("url", url.replaceAll(".jsp", ""));
                 }

                 rtnValue.setSuccess(true);
                 rtnValue.setMessage(HttpUtil.covertJsonString(map));

                 //신규 로그인 세션 추가
                 session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());
                 SessionUtility.addSession(session);
             } else {
                 rtnValue.setSuccess(false);
             }
         } else {
             //기존 세션이 있는 경우 제거
             SessionUtility.removeSession(session);

//        	rtnValue.setSuccess(false);
//        	//로그인 30분 제한 풀림까지 남은시간 반환 (분)
             if (ObjectUtil.isNotEmpty(result.getMessage())) {
                 rtnValue.setMessage(result.getMessage());
             } else {
                 throw new LoginWrongUserInfoException("idPwd");
             }
//			rtnValue.setMessage("remainingTime/"+result.getRemainingTime());
         }

         if (rtnValue.getSuccess()) {
             LoginResDto loginResponse = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);

             CookieUtil.createCookie(request, response, loginResponse.getId(), "", "", loginResponse.getLang());
         }

         LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
         if (localeResolver != null) {
             Locale locale = new Locale(lr.getLang());
             localeResolver.setLocale(request, response, locale);
         }
         return rtnValue;
     }

     /**
      * @return :
      * @programId :
      * @name : checkLoginSession
      * @date : 2016. 6. 27.
      * @author : 류동균
      * @table :
      * @description : 로그인 세션 확인
      */
     public LoginResDto checkLoginSession(HttpServletRequest request, HttpServletResponse response) {
         LoginResDto rtnValue = null;
         HttpSession session = request.getSession(true);

         if (StringUtil.compareLoozy(BeansUtil.getApplicationProperty("icignal.login.sso.check"), "true")) {

             Cookie currCookie = CookieUtil.getSSOCookie(request);

             if (currCookie != null && session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
                 rtnValue = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
                 rtnValue.setSuccess(true);

                 CookieResDto cr = CookieUtil.getUserData(currCookie);
                 if (!cr.getId().equals(rtnValue.getId())) {
                     this.initSession(session);

                     throw new DataUnauthrizedException();
                 }
                 CookieUtil.createCookie(request, response, cr.getId(), "", "", cr.getLang());

                 LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
                 if (localeResolver != null) {
                     Locale locale = new Locale(cr.getLang());
                     localeResolver.setLocale(request, response, locale);
                 }
             } else if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null && currCookie == null) {

                 this.initSession(session);
                 throw new DataUnauthrizedException();
             } else if (currCookie != null && session.getAttribute(CommonUtil.USER_INFO_PROP) == null) {
                 CookieResDto cr = CookieUtil.getUserData(currCookie);

                 if (cr != null) {
                     // 자동 로그인 처리 & location 변경
                     LoginReqDto lr = new LoginReqDto();
                     lr.setLang(cr.getLang());
                     lr.setId(cr.getId());

                     loginConfirm(lr, request, response);

                     rtnValue = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
                     rtnValue.setSuccess(true);

                     CookieUtil.createCookie(request, response, rtnValue.getId(), "", "", rtnValue.getLang());

                 }
             } else {
                 throw new DataUnauthrizedException();
             }
         } else {
             rtnValue = this.checkLoginSession(session);
         }


         if (rtnValue == null) return new LoginResDto();

         rtnValue.setUrl((String) session.getAttribute("URL"));
         rtnValue.setUrlInclude((String) session.getAttribute("URL_INCLUDE"));
         return rtnValue;
     }

     /**
      * @throws DataUnauthrizedException
      * @name : checkLoginSession
      * @date : 2013. 12. 5.
      * @author : 류동균
      * @description : 현재 사용자의 웹 로그인 여부를 체크하는 함수 로그인 되어있을 경우 message에 사용자의 아이디가
      * 매핑됨.
      */
     public LoginResDto checkLoginSession(HttpSession session) {
         LoginResDto rtnValue = null;


         if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
             rtnValue = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);

             if (rtnValue != null) {
                 rtnValue.setSuccess(true);
             }
         } else {
             throw new DataUnauthrizedException();
         }

         //세션풀 내 세션 존재 여부 체크 (MKTSessionPool)
         if (ObjectUtil.isEmpty(SessionUtility.getSession(session.getId(), true))) {
             throw new DataUnauthrizedException();
         }

         return rtnValue;
     }

     /**
      * @return :
      * @programId :
      * @name : checkAuthGroupType
      * @date :
      * @author :
      * @table :
      * @description : 로그인 권한 그룹 유형 확인
      */
     public boolean checkAuthGroupType(HttpServletRequest request, AUTH_GROUP_TYPE_CD authGroupTypeCd) {

         HttpSession session = request.getSession(true);

         boolean rtnValue = false;

         AuthorityResDto auth = (AuthorityResDto) session.getAttribute(CommonUtil.SESSIONID_AUTH);

         if (ObjectUtil.isNotEmpty(auth.getAuthGroupList())) {

             for (AuthorityGroupListResDto authGroup : auth.getAuthGroupList()) {
                 if (authGroupTypeCd.toString().equals(authGroup.getType())) {
                     rtnValue = true;
                 }
             }
         }

         return rtnValue;
     }

     /**
      * 접근 허용된 프로그램 Request 인지 검사
      * @param request
      * @param session
      * @author knlee
      * @return
      */
	/*public boolean checkACL(HttpServletRequest request, HttpSession session ){
		return checkACL(request, session, request.getRequestURI());
	}*/

     /**
      * 접근 허용된 프로그램 Request 인지 검사
      * @param request
      * @param session
      * @author knlee
      * @return
      */
	/*public boolean checkACL(HttpServletRequest request, HttpSession session, String uri ){
		
		boolean uriChk = false;
		if (session != null && session.getAttribute(CommonUtil.SESSIONID_AUTH) != null) {
			Object result = session.getAttribute(CommonUtil.SESSIONID_AUTH);
			if (result != null) {
				AuthorityResDto authRes = (AuthorityResDto) result;
				List<AuthorityProgramListResDto> list =  authRes.getAuthProgList();
				
				if(uri.lastIndexOf('/') != -1 && uri.lastIndexOf('/') != 0) {
					String search_str =  uri.substring(1,uri.lastIndexOf('/'));
					for(AuthorityProgramListResDto pgm : list) {
						String progPath =  pgm.getProgPath();
						String progPathSub =  progPath.substring(0, progPath.lastIndexOf('/'));
						if(progPathSub.equals(search_str)) {
							uriChk = true;
							break;
						}
					}
				}else uriChk = true;
				
			}
		}
		
		return uriChk;
	}*/

     /**
      * @return : boolean
      * @programId :
      * @name : checkPrivacyPage
      * @date : 2019. 1. 31.
      * @author : hy.jun
      * @table :
      * @description : 개인정보 처리 메뉴인 경우 AWS Workspace IP 만 허용한다. (*운영서버 한정)
      */
     public boolean checkPrivacyPage(HttpServletRequest request, HttpSession session) {
         return checkPrivacyPage(request, session, request.getRequestURI().substring(1));
     }

     /**
      * @return : boolean
      * @programId :
      * @name : checkPrivacyPage
      * @date : 2019. 1. 31.
      * @author : hy.jun
      * @table :
      * @description : 개인정보 처리 메뉴인 경우 AWS Workspace IP 만 허용한다. (*운영서버 한정)
      */
     @SuppressWarnings("unchecked")
     public boolean checkPrivacyPage(HttpServletRequest request, HttpSession session, String uri) {

         boolean isValid = true;

         //운영환경 체크
//		if(CommonUtil.getServerType().equals(CommonUtil.SERVER_TYPE.Real)) {
         if (ObjectUtil.isNotEmpty(uri)) {
             //세션 내 메뉴목록 조회
             List<AuthorityMenuListResDto> menuList = (List<AuthorityMenuListResDto>) session.getAttribute("menuDump");
             //개인정보 처리 메뉴 여부 체크
             boolean isPrivacy = menuList.stream()
                     .anyMatch(x -> ObjectUtil.isNotEmpty(x.getProgPath()) && x.getProgPath().indexOf(uri) > -1 && x.getPrivacyFlg() == 1);
             //개인정보 처리 메뉴인 경우 클라이언트IP 제한
             if (isPrivacy) {
                 String clientIp = CommonUtil.getClientIP(request);
                 if (!(clientIp.startsWith("192.168.253") || clientIp.startsWith("192.168.254"))) {
                     isValid = false;
                 }
             }
         }
//		}

         return isValid;
     }

     /**
      * @return :
      * @programId :
      * @name : checkUserInfoInclude
      * @date : 2016. 6. 27.
      * @author : 류동균
      * @table :
      * @description : 사용자 정보 확인
      */
     public String checkUserInfoInclude(HttpServletRequest request, HttpServletResponse response, String redirectUri) {
         //String rtnValue = "base/login/login.defaultFull-tiles";
         String rtnValue = "base/login/goLogin";

         if (this.checkUserInfo(request, response))
             rtnValue = redirectUri;
         // 현 URL Session 담기
         HttpSession session = request.getSession(true);
         session.setAttribute("URL_INCLUDE", redirectUri);
         return rtnValue;
     }

     /**
      * @name : initSession
      * @date : 2013. 6. 24.
      * @author : 류동균
      * @description : 세션 초기화
      */
     private void initSession(HttpSession session) {
         session.invalidate(); // 세션 초기화 하는 함수
         // SessionUtility.removeSession(session); //모든 세션을 종료
     }

     /**
      * @return : MKTAuthorityResponseDTO
      * @name : getSessionAuthority
      * @date : 2017. 3. 14.
      * @author : new one
      * @description : 권한 세션 추출
      */
     public AuthorityResDto getSessionAuthority(HttpSession session) {
         AuthorityResDto rtnValue = new AuthorityResDto();

         if (session != null && session.getAttribute(CommonUtil.SESSIONID_AUTH) != null) {
             Object result = session.getAttribute(CommonUtil.SESSIONID_AUTH);

             if (result != null) {
                 rtnValue = (AuthorityResDto) result;
             }
         }

         return rtnValue;
     }

     /**
      * @return : MKTAuthorityResponseDTO
      * @name : getSessionAuthority
      * @date : 2017. 3. 14.
      * @author : new one
      * @description : 권한 세션 추출
      */
     public AuthorityResDto getSessionAuthority(HttpServletRequest request) {
         HttpSession session = request.getSession(true);

         AuthorityResDto rtnValue = new AuthorityResDto();
         if (session != null && session.getAttribute(CommonUtil.SESSIONID_AUTH) != null) {
             Object result = session.getAttribute(CommonUtil.SESSIONID_AUTH);

             if (result != null) {
                 rtnValue = (AuthorityResDto) result;
             }
         }

         return rtnValue;
     }

     /**
      * @return : MKTAuthorityResponseDTO
      * @name : getAuthorityInfo
      * @date : 2017. 3. 14.
      * @author : new one
      * @description : 권한 정보 추출
      */
     public AuthorityResDto getAuthorityInfo(HttpSession session, String dataTypeCd) {

         // 권한 정보 세션 추출
         AuthorityResDto rtnValue = getSessionAuthority(session);

         // 데이터 유형에 따른 데이터 권한 값 설정
         rtnValue = authCommonService.setAuthorityDataInValue(rtnValue, dataTypeCd);

         return rtnValue;
     }

     /*
      * 1. 메소드명: naverLoginConfirm
      * 2. 클래스명: AuthHelper
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 4. 7.
      */

     /**
      * <PRE>
      * 1. 설명
      * BO 네이버 로그인 체크
      * 2. 사용법
      *
      * </PRE>
      *
      * @param accessToken
      * @param request
      * @param response
      * @throws IOException
      */

     public String snsNaverLoginConfirm(String snsId, HttpServletRequest request, HttpServletResponse response) throws IOException {
         LogUtil.param(this.getClass(), snsId);
         String url = "";
         LoginReqDto lr = new LoginReqDto();
         StatusResDto rtnValue = new StatusResDto();
         HttpSession session = request.getSession(true);
         Map<String, String> map = new HashMap<>();
         CacheCommon cacheCommon = new CacheCommon();

         lr.setSessnId(session.getId());
         lr.setSnsId(snsId);
         LoginResDto result = loginService.snsNaverLoginConfirm(lr);
         if (result != null) {
             //세션 Utility에서 사용자별로 세션 관리를 위해 키값을 추가
             result.setSessionId(session.getId());
             if (result.getLang() == null || result.getLang().length() == 0) {
                 result.setLang(CommonUtil.DEFAULT_LANG);
             }

             session.setAttribute(SessionCommon.SESSIONID_PROP, session.getId());
             session.setAttribute(CommonUtil.USER_INFO_PROP, result);
             session.setAttribute(CommonUtil.LANG, lr.getLang());
             //소스 리펙토링 후 적용 소스
             session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());


             //DB에서 로그인한 사용자가 등록된 권한그룹의 프로그램과 오브젝트(버튼)목록을 조회
             List<ProgramCache> proResDto = authCommonService.getLoginAuthList(result.getId());
             //가져온 프로그램과 오브젝트(버튼)목록을 캐시에 저장
             cacheCommon.createCache(cachemanager, result.getId(), proResDto, "ProgramCache");

             //권한 Request
             AuthorityReqDto authReq = new AuthorityReqDto();
             authReq.setEmpId(result.getEmpId());
             authReq.setRidUser(result.getId());
             authReq.setLang(lr.getLang());

             //권한 조회
             AuthorityResDto auth = authCommonService.getAuthority(authReq);
             auth.setRidDivision(result.getOrgId());

             session.setAttribute(CommonUtil.SESSIONID_AUTH, auth);

             //권한 메뉴 목록
             session.setAttribute("menuDump", auth.getAuthMenuList());

             /*
              * URL
              * 메뉴 목록 확인 및 첫번째 메뉴의 URL 확인
              * 권한그룹 유형 VOC 일 경우 : /voc
              * 그외 첫번째 메뉴 URL
              */
             if (ObjectUtil.isNotEmpty(auth.getAuthMenuList())) {
                 //URL을 가진 Menu 확인

                 for (AuthorityMenuListResDto menu : auth.getAuthMenuList()) {
                     if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                         url = menu.getProgPath();
                         break;
                     }
                 }

                 map.put("url", url.replaceAll(".jsp", ""));


                 rtnValue.setSuccess(true);
                 rtnValue.setMessage(HttpUtil.covertJsonString(map));

                 //신규 로그인 세션 추가
                 session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());
                 SessionUtility.addSession(session);
             } else {
                 rtnValue.setSuccess(false);
             }
         } else return null;
         return url.replaceAll(".jsp", "");

     }

     /*
      * 1. 메소드명: naverLoginConfirm
      * 2. 클래스명: AuthHelper
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 4. 7.
      */

     /**
      * <PRE>
      * 1. 설명
      * BO 카카오 로그인 체크
      * 2. 사용법
      *
      * </PRE>
      *
      * @param accessToken
      * @param request
      * @param response
      * @throws IOException
      */

     public String snsKakaoLoginConfirm(String snsId, HttpServletRequest request, HttpServletResponse response) throws IOException {
         LogUtil.param(this.getClass(), snsId);
         String url = "";
         LoginReqDto lr = new LoginReqDto();
         StatusResDto rtnValue = new StatusResDto();
         HttpSession session = request.getSession(true);
         Map<String, String> map = new HashMap<>();
         CacheCommon cacheCommon = new CacheCommon();

         lr.setSessnId(session.getId());
         lr.setSnsId(snsId);
         LoginResDto result = loginService.snsKakaoLoginConfirm(lr);
         if (result != null) {
             //세션 Utility에서 사용자별로 세션 관리를 위해 키값을 추가
             result.setSessionId(session.getId());
             if (result.getLang() == null || result.getLang().length() == 0) {
                 result.setLang(CommonUtil.DEFAULT_LANG);
             }

             session.setAttribute(SessionCommon.SESSIONID_PROP, session.getId());
             session.setAttribute(CommonUtil.USER_INFO_PROP, result);
             session.setAttribute(CommonUtil.LANG, lr.getLang());
             //소스 리펙토링 후 적용 소스
             session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());


             //DB에서 로그인한 사용자가 등록된 권한그룹의 프로그램과 오브젝트(버튼)목록을 조회
             List<ProgramCache> proResDto = authCommonService.getLoginAuthList(result.getId());
             //가져온 프로그램과 오브젝트(버튼)목록을 캐시에 저장
             cacheCommon.createCache(cachemanager, result.getId(), proResDto, "ProgramCache");

             //권한 Request
             AuthorityReqDto authReq = new AuthorityReqDto();
             authReq.setEmpId(result.getEmpId());
             authReq.setRidUser(result.getId());
             authReq.setLang(lr.getLang());

             //권한 조회
             AuthorityResDto auth = authCommonService.getAuthority(authReq);
             auth.setRidDivision(result.getOrgId());

             session.setAttribute(CommonUtil.SESSIONID_AUTH, auth);

             //권한 메뉴 목록
             session.setAttribute("menuDump", auth.getAuthMenuList());

             /*
              * URL
              * 메뉴 목록 확인 및 첫번째 메뉴의 URL 확인
              * 권한그룹 유형 VOC 일 경우 : /voc
              * 그외 첫번째 메뉴 URL
              */
             if (ObjectUtil.isNotEmpty(auth.getAuthMenuList())) {
                 //URL을 가진 Menu 확인

                 for (AuthorityMenuListResDto menu : auth.getAuthMenuList()) {
                     if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                         url = menu.getProgPath();
                         break;
                     }
                 }

                 map.put("url", url.replaceAll(".jsp", ""));

                 rtnValue.setSuccess(true);
                 rtnValue.setMessage(HttpUtil.covertJsonString(map));

                 //신규 로그인 세션 추가
                 session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());
                 SessionUtility.addSession(session);
             } else {
                 rtnValue.setSuccess(false);
             }
         } else return null;
         return url.replaceAll(".jsp", "");
     }

     /*
      * 1. 메소드명: naverLoginConfirm
      * 2. 클래스명: AuthHelper
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 4. 7.
      */

     /**
      * <PRE>
      * 1. 설명
      * BO 구글 로그인 체크
      * 2. 사용법
      *
      * </PRE>
      *
      * @param accessToken
      * @param request
      * @param response
      * @throws IOException
      */

     public String snsGoogleLoginConfirm(String snsId, HttpServletRequest request, HttpServletResponse response) throws IOException {
         LogUtil.param(this.getClass(), snsId);
         String url = "";
         LoginReqDto lr = new LoginReqDto();
         StatusResDto rtnValue = new StatusResDto();
         HttpSession session = request.getSession(true);
         Map<String, String> map = new HashMap<>();
         CacheCommon cacheCommon = new CacheCommon();

         lr.setSessnId(session.getId());
         lr.setSnsId(snsId);
         LoginResDto result = loginService.snsGoogleLoginConfirm(lr);

         //세션 Utility에서 사용자별로 세션 관리를 위해 키값을 추가
         result.setSessionId(session.getId());
         if (result.getLang() == null || result.getLang().length() == 0) {
             result.setLang(CommonUtil.DEFAULT_LANG);
         }

         session.setAttribute(SessionCommon.SESSIONID_PROP, session.getId());
         session.setAttribute(CommonUtil.USER_INFO_PROP, result);
         session.setAttribute(CommonUtil.LANG, lr.getLang());
         //소스 리펙토링 후 적용 소스
         session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());


         //DB에서 로그인한 사용자가 등록된 권한그룹의 프로그램과 오브젝트(버튼)목록을 조회
         List<ProgramCache> proResDto = authCommonService.getLoginAuthList(result.getId());
         //가져온 프로그램과 오브젝트(버튼)목록을 캐시에 저장
         cacheCommon.createCache(cachemanager, result.getId(), proResDto, "ProgramCache");

         //권한 Request
         AuthorityReqDto authReq = new AuthorityReqDto();
         authReq.setEmpId(result.getEmpId());
         authReq.setRidUser(result.getId());
         authReq.setLang(lr.getLang());

         //권한 조회
         AuthorityResDto auth = authCommonService.getAuthority(authReq);
         auth.setRidDivision(result.getOrgId());

         session.setAttribute(CommonUtil.SESSIONID_AUTH, auth);

         //권한 메뉴 목록
         session.setAttribute("menuDump", auth.getAuthMenuList());

         /*
          * URL
          * 메뉴 목록 확인 및 첫번째 메뉴의 URL 확인
          * 권한그룹 유형 VOC 일 경우 : /voc
          * 그외 첫번째 메뉴 URL
          */
         if (ObjectUtil.isNotEmpty(auth.getAuthMenuList())) {
             //URL을 가진 Menu 확인

             for (AuthorityMenuListResDto menu : auth.getAuthMenuList()) {
                 if (ObjectUtil.isNotEmpty(menu.getProgPath())) {
                     url = menu.getProgPath();
                     break;
                 }
             }

             map.put("url", url.replaceAll(".jsp", ""));

             rtnValue.setSuccess(true);
             rtnValue.setMessage(HttpUtil.covertJsonString(map));

             //신규 로그인 세션 추가
             session.setAttribute(SessionCommon.SESSION_USER_KEY_PROP, result.getId());
             SessionUtility.addSession(session);
         } else {
             rtnValue.setSuccess(false);
         }
         return url.replaceAll(".jsp", "");
     }

 }

