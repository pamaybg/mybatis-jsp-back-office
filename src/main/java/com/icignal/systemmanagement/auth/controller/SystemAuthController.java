package com.icignal.systemmanagement.auth.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.request.UserDetailReqDto;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.external.facebookservice.service.FacebookService;
import com.icignal.external.gogleservice.service.GogleService;
import com.icignal.external.kakaoservice.service.KakaoService;
import com.icignal.external.naverservice.service.NaverService;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthCallProcReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthDetailReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthMenuListRequestDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthObjectListReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthProgramAccessReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemDeleteAuthObjRelReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemInsertVIewAuthListReqDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthDetailResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthMenuListResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthObjectListResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthProgramAccessResDto;
import com.icignal.systemmanagement.auth.service.SystemAuthService;
import com.icignal.systemmanagement.authgroup.dto.request.InsertAuthDetailReqDto;
import com.icignal.systemmanagement.menu.dto.request.SystemAuthMenuNameLangReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemAuthMenuNameLangResDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthGroupListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;

/*
 * 1. 클래스명	: SystemAuthController
 * 2. 파일명	: SystemAuthController.java
 * 3. 패키지명	: com.icignal.systemmanagement.auth.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *	시스템운영 - 권한 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/auth")
public class SystemAuthController extends BaseController{
	
	@Autowired SystemAuthService systemAuthService;
	
	@Autowired AuthHelper authhelper;

	@Autowired NaverService naverService;
	
	@Autowired KakaoService kakaoService;
	
	@Autowired FacebookService facebookService;
	
	@Autowired GogleService gogleService;
	
	 /*
	  * 1. 메소드명: getAuthList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종
	  * 4. 작성일자: 2017. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param balr
	 *   @return	
	 */
	@RequestMapping(value="/getAuthList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthListResDto> getAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthListReqDto balr) {
		
		LogUtil.param(this.getClass(), balr);
		
		balr.setLoginInfo(authhelper.checkLoginSession(request, response));
		
		return systemAuthService.getAuthList(balr);
	}

	 /*
	  * 1. 메소드명: deleteAuthList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종
	  * 4. 작성일자: 2017. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 리스트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param baml
	 *   @return	
	 */
	@RequestMapping(value="/deleteAuthList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthMenuListRequestDto baml) {
		
		LogUtil.param(this.getClass(), baml);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		baml.setLoginInfo(loginInfo);
		baml.setEmpId(loginInfo.getId());
		return systemAuthService.deleteAuthList(baml);
	}

	 /*
	  * 1. 메소드명: authDetail
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 *		2017. 3. 9.			장용			권한 통합에 따른 소스변경 - 권한 마스터 테이블에서 조회되도록 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param badr
	 *   @return	
	 */
	@RequestMapping(value="/authDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemAuthDetailResDto authDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthDetailReqDto badr) {
		
		LogUtil.param(this.getClass(), badr);
		
		authhelper.checkLoginSession(request, response);
		
		return systemAuthService.authDetail(badr);
	}

	 /*
	  * 1. 메소드명: insertAuthDetail
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종	
	  * 4. 작성일자: 2017. 3. 3.	
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 상세 저장
	 *		2017. 3. 9.			장용			권한 통합 관련 변경 - 마스터만 인서트 되도록 쿼리 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param biad
	 *   @return	
	 */
	@RequestMapping(value="/insertAuthDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertAuthDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody InsertAuthDetailReqDto biad) {
		
		LogUtil.param(this.getClass(), biad);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		biad.setLoginInfo(userInfo);
		biad.setEmpId(userInfo.getId());
		return systemAuthService.insertAuthDetail(biad);
	}

	 /*
	  * 1. 메소드명: updateAuthDetail
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 상세 수정
	 *		2017. 3. 9.		장용			서버 통합 관련 변경 - 마스터만 수정되도록 쿼리 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param biad
	 *   @return	
	 */
	@RequestMapping(value="/updateAuthDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateAuthDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody InsertAuthDetailReqDto biad) {
		
		LogUtil.param(this.getClass(), biad);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		biad.setEmpId(userInfo.getId());
		return systemAuthService.updateAuthDetail(biad);
	}
	
	 /*
	  * 1. 메소드명: getMenuNameLang
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 4.
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
	 *   @param bamnl
	 *   @return	
	 */
	@RequestMapping(value="/getMenuNameLang.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthMenuNameLangResDto> getMenuNameLang(HttpServletRequest request, HttpServletResponse response, @RequestBody  SystemAuthMenuNameLangReqDto bamnl) {
		
		LogUtil.param(this.getClass(), bamnl);
		
		LoginResDto userInfo =  authhelper.checkLoginSession(request, response);
		return systemAuthService.getMenuNameLang(bamnl);
	}

	 /*
	  * 1. 메소드명: getAuthMenuList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		계정이 갖고 있는 권한 정보에 따른 메뉴 권한을 불러오는 함수
	 *		2017. 3. 09.			장용			권한 통합 관련 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/getAuthMenuList.do", method = RequestMethod.POST)
	public @ResponseBody List<SystemAuthMenuListResDto> getAuthMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthMenuListRequestDto mlr) {
		
		LogUtil.param(this.getClass(), mlr);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		return systemAuthService.getAuthMenuList(mlr);
	}
	
	 /*
	  * 1. 메소드명: getProgramAccessList
	  * 2. 클래스명: MKTAuthController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 01. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 프로그램 목록 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mapnar
	 *   @return	
	 */
	@RequestMapping(value="/getProgramAccessList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthProgramAccessResDto> getProgramAccessList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthProgramAccessReqDto mapnar) {
		
		LogUtil.param(this.getClass(), mapnar);
		
		authhelper.checkLoginSession(request, response);
		
		return systemAuthService.getProgramAccessList(mapnar);
	}

	 /*
	  * 1. 메소드명: setViewAuthList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: yongjang 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		화면 권한 설정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param ivar
	 *   @return	
	 */
	@RequestMapping(value="/setViewAuthList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setViewAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody  SystemInsertVIewAuthListReqDto ivar) {
		LogUtil.param(this.getClass(), ivar);
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		ivar.setEmpId(userInfo.getId());
		return systemAuthService.setViewAuthList(ivar);
	}

	 /*
	  * 1. 메소드명: getAuthObjectList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 장용
	  * 4. 작성일자: 2017. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 오브젝트 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param aolr
	 *   @return	
	 */
	@RequestMapping(value="/getAuthObjectList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthObjectListResDto> getAuthObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthObjectListReqDto aolr) {
		
		LogUtil.param(this.getClass(), aolr);
		
		authhelper.checkLoginSession(request, response);
	    
	    return systemAuthService.getAuthObjectList(aolr);
	    
	}

	 /*
	  * 1. 메소드명: deleteAuthObjRel
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 장용 
	  * 4. 작성일자: 2017. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 오브젝트 관계 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param darr
	 *   @return	
	 */
	@RequestMapping(value="/deleteAuthObjRel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteAuthObjRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteAuthObjRelReqDto darr) {
		
		LogUtil.param(this.getClass(), darr);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		darr.setEmpId(userInfo.getId());
	    
	    return systemAuthService.deleteAuthObjRel(darr);
	    
	}

	 /*
	  * 1. 메소드명: getProgList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: 표민종
	  * 4. 작성일자: 2017. 3. 3.	
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한관리 오브젝트 관리 프로그램 목록
	 *		2020. 02. 05		노형래			권한관리 오브젝트 관리 프로그램 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param plr
	 *   @return	
	 */
	@RequestMapping(value="/getProgList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto plr) {
		
		LogUtil.param(this.getClass(), plr);
		
		authhelper.checkLoginSession(request, response);
		
		return systemAuthService.getProgList(plr);
	}

     /*
      * 1. 메소드명: callAuthCopyProc
      * 2. 클래스명: SystemAuthController
      * 3. 작성자명: sh.park 
      * 4. 작성일자: 2020. 2. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *		권한복사 프로시져 호출
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/callAuthCopyProc.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto callAuthCopyProc(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthCallProcReqDto param){
  	  LogUtil.param(this.getClass(), param);
  	  authhelper.checkLoginSession(request, response);
  	  return systemAuthService.callAuthCopyProc(param);
    }

	 /*
	  * 1. 메소드명: getAuthCopyList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: sh.park 
	  * 4. 작성일자: 2020. 2. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한복사 팝업 권한 리스트(선택한 권한 제외 GRID)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getAuthCopyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthListResDto> getAuthCopyList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.getAuthCopyList(param);
	}
	
	 /*
	  * 1. 메소드명: getProgramListPop
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 권한관리 프로그램 권한 팝업 호출	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getAuthProgramListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgramListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.getAuthProgramListPop(param);
	}
	
	 /*
	  * 1. 메소드명: getProgAuthList
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 권한관리 프로그램 권한 호출		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getProgAuthList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.getProgAuthList(param);
	}
	
	 /*
	  * 1. 메소드명: addProgramAuth
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 4.
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/addProgramAuth.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addProgramAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.addProgramAuth(param);
	}
	
	 /*
	  * 1. 메소드명: addProgramAuth
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getAuthProgram.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getAuthProgram(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.getAuthProgram(param);
	}
	
	 /*
	  * 1. 메소드명: removeProgramPrarent
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/removeProgramPrarentAuth.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeProgramPrarentAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.removeProgramPrarentAuth(param);
	}
	
	 /*
	  * 1. 메소드명: removeProgramChildAuth
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/removeProgramChildAuth.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeProgramChildAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.removeProgramChildAuth(param);
	}
	
	/**
	 * @name : modifyUserPwd
	 * @date : 2017. 11. 23.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 로그인 사용자 비밀번호 변경
	 */
	@RequestMapping(value="/modifyUserPwd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyUserPwd(HttpServletRequest request, HttpServletResponse response, @RequestBody UserDetailReqDto plr) {
		
		LogUtil.param(this.getClass(), plr);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		
		plr.setEmpId(loginInfo.getId());
		
		return systemAuthService.modifyUserPwd(plr);
	}
	
	 /*
	  * 1. 메소드명: getAuthProgramLChildistPop
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getAuthProgramLChildistPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getAuthProgramLChildistPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.getAuthProgramLChildistPop(param);
	}
	
	 /*
	  * 1. 메소드명: addProgramChildAuth
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 13.
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
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/addProgramChildAuth.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addProgramChildAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		authhelper.checkLoginSession(request, response);
		return systemAuthService.addProgramChildAuth(param);
	}
	
//	@RequestMapping(value = "/naverLogin.do", method = RequestMethod.POST)
//	public @ResponseBody NaverLoginInfoResDto NaverAuth(HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response,Model model) {		
//		
//		return naverService.getAuthorizationUrl(session);
//	}
	
//	@RequestMapping(value = "/facebookLogin.do", method = RequestMethod.POST)
//	public @ResponseBody FacebookLoginInfoResDto facebookLogin(HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response,Model model) {		
//		
//		return facebookService.getAuthorizationUrl(session);
//	}
	
//	@RequestMapping(value = "/googleLogin.do", method = RequestMethod.POST)
//	public @ResponseBody GogleLoginResDto googleLogin(HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response,Model model) {		
//		
//		return gogleService.getAuthorizationUrl(session);
//	}
	
	/*@RequestMapping(value="/naverCallback", method = RequestMethod.GET)
	public void callback(@RequestParam String code, @RequestParam String state, HttpSession session, HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 
		LogUtil.param(this.getClass(), code);
		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		OAuth2AccessToken oauthToken = naverService.getAccessToken(session, code, state);
		systemAuthService.modifyNaverToken(oauthToken.getAccessToken(),userId);
		setRPrintPopupWriter(response); 
	}*/
	
//	@RequestMapping(value="/kakaoCallback", method = RequestMethod.GET)
//	public void kakaoCallback(@RequestParam String code, HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response) throws IOException {
//		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
//		LogUtil.param(this.getClass(), code);
//		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
//		String access_Token = kakaoService.getAccessToken(code);
//		systemAuthService.modifyKaKaoToken(access_Token,userId);
//	}

//	@RequestMapping(value="/facebookCallback", method = RequestMethod.GET)
//	public void facebookCallback(@RequestParam String code, HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response) throws IOException {
//		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
//		LogUtil.param(this.getClass(), code);
//		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
//		String access_Token = facebookService.getAccessToken(code);
//		systemAuthService.modifyFacebookToken(access_Token,userId);
//	}
	
//	@RequestMapping(value="/googleCallback", method = RequestMethod.GET)
//	public void googleCallback(@RequestParam String code, HttpSession session, HttpServletRequest request, 
//			HttpServletResponse response) throws IOException {
//		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
//		LogUtil.param(this.getClass(), code);
//		String userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
//		String access_Token = gogleService.getAccessToken(code);
//		systemAuthService.modifyGogleToken(access_Token,userId);
//		JavaScriptStringUtil.setRPrintPopupWriter(response); 
//	}
	
	/**
	* @name : delAuthObjRel
	* @date : 2020. 1. 31.
	* @author : sh.park
	* @history :
	* @description : 프로그램 관리 오브젝트 권한 리스트 삭제
	* @param requ
	* @param response
	* @param reqDto
	* @return : StatusResDto
	*/
	@RequestMapping(value="/delAuthObjRel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delAuthObjRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthGroupListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		authhelper.checkLoginSession(request, response);
		return systemAuthService.delAuthObjRel(param);
	}
	
	 /*
	  * 1. 메소드명: modifyUserFirstLoginFlg
	  * 2. 클래스명: SystemAuthController
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2018. 03. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 사용자 최초 로그인 플래그 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param plr
	 *   @return	
	 */
	@RequestMapping(value="/modifyUserFirstLoginFlg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyUserFirstLoginFlg(HttpServletRequest request, HttpServletResponse response, @RequestBody UserDetailReqDto plr) {
		LogUtil.param(UserDetailReqDto.class, plr);
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		plr.setEmpId(loginInfo.getId());
		
		return systemAuthService.modifyUserFirstLoginFlg(plr);
	}
	
	@RequestMapping(value="/getEmpAddListModalForCallCenter.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthGroupEmployeeModalResDto> getEmpAddListModalForCallCenter(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody SystemAuthGroupEmployeeModalReqDto bagem) {
		
		LogUtil.param(this.getClass(), bagem);
		
		LoginResDto userInfo =  this.checkLoginSession(request, response);
		bagem.setEmpId(userInfo.getId());
		return systemAuthService.getEmpAddListModalForCallCenter(bagem);
	}
	
}
