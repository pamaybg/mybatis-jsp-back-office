package com.icignal.systemmanagement.menu.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.icignal.systemmanagement.menu.dto.request.SystemMenuListReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemMenuListResDto;
import com.icignal.systemmanagement.menu.dto.response.SystemMenuListResDto2;
import com.icignal.systemmanagement.menu.service.SystemMenuService;


/*
 * 1. 클래스명	: SystemMenuController
 * 2. 파일명	: SystemMenuController.java
 * 3. 패키지명	: com.icignal.systemmanagement.menu.controller
 * 4. 작성자명	: 표민종 
 * 5. 작성일자	: 2017. 2. 28. 
 */
/**
 * <PRE>
 * 1. 설명
 *		SystemManagement - Menu 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/menu")
public class SystemMenuController extends BaseController {
	
	@Autowired
	private SystemMenuService systemMenuService;
	
	@Autowired
	AuthHelper authHelper;
	
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".modal-tiles";
		return authHelper.checkUserInfoInclude(request, response, respUrl);
		
	}

	
	 /*
	  * 1. 메소드명: getMenuList
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종
	  * 4. 작성일자: 2017. 2. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		menuListNew.jsp의 메류트리 정보 불러오는 Method
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/getMenuList.do", method = RequestMethod.POST)
	public @ResponseBody List<SystemMenuListResDto> getMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		authHelper.checkLoginSession(request, response);
		 	
		return systemMenuService.getMenuList(mlr);
	}

	 /*
	  * 1. 메소드명: getAuthMenuProgList
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴에 등록된 프로그램 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/getAuthMenuProgList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemMenuListResDto> getAuthMenuProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		authHelper.checkLoginSession(request, response);
		
		return systemMenuService.getAuthMenuProgList(mlr);
	}

	 /*
	  * 1. 메소드명: deleteMenuList
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명:	표민종
	  * 4. 작성일자: 2017. 3. 9.	
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param bdmr
	 *   @return	
	 */
	@RequestMapping(value="/deleteMenuList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto bdmr) {
		
		LogUtil.param(SystemMenuController.class, bdmr);
		
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		bdmr.setEmpId(userInfo.getId());
		return systemMenuService.deleteMenuList(bdmr);
	}	

	 /*
	  * 1. 메소드명: addAuthMenuList
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/addAuthMenuList.do", method = RequestMethod.POST)
	public @ResponseBody SystemMenuListResDto2 addAuthMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		HttpSession session = request.getSession(true);
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		mlr.setEmpId(userInfo.getId());
		//mlr.setAuthGroupId(userInfo.getAuthInfo().getGroupId());
		return systemMenuService.addAuthMenuList(mlr, session);
	}

	 /*
	  * 1. 메소드명: getAuthMenuListPop
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 등록 모달창
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/getAuthMenuListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemMenuListResDto> getAuthMenuListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		authHelper.checkLoginSession(request, response);
		return systemMenuService.getAuthMenuListPop(mlr);
	}

	 /*
	  * 1. 메소드명: addAuthMenuListProg
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/addAuthMenuListProg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addAuthMenuListProg(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		mlr.setEmpId(userInfo.getId());
		return systemMenuService.addAuthMenuListProg(mlr);
	}

	 /*
	  * 1. 메소드명: delAuthMenuListProg
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 프로그램 관계 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/delAuthMenuListProg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delAuthMenuListProg(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		LoginResDto userInfo =authHelper.checkLoginSession(request, response);
		mlr.setEmpId(userInfo.getId());
		return systemMenuService.delAuthMenuListProg(mlr);
	}

	 /*
	  * 1. 메소드명: updateSortMenu
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: 표민종 
	  * 4. 작성일자: 2017. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴트리 순서 정렬
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/updateSortMenu.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateSortMenu(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		
		LogUtil.param(SystemMenuController.class, mlr);
		
		authHelper.checkLoginSession(request, response);
		
		return systemMenuService.updateSortMenu(mlr);
	}
	
	 /*
	  * 1. 메소드명: updateMenuIcon
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 아이콘 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/updateMenuIcon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateMenuIcon(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuController.class, mlr);
		LoginResDto userInfo =authHelper.checkLoginSession(request, response);
		mlr.setEmpId(userInfo.getId());
		
		return systemMenuService.updateMenuIcon(mlr);
	}
	
	 /*
	  * 1. 메소드명: removeMenuIcon
	  * 2. 클래스명: SystemMenuController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		메뉴 아이콘 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mlr
	 *   @return	
	 */
	@RequestMapping(value="/removeMenuIcon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeMenuIcon(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMenuListReqDto mlr) {
		LogUtil.param(SystemMenuController.class, mlr);
		LoginResDto userInfo =authHelper.checkLoginSession(request, response);
		mlr.setEmpId(userInfo.getId());
		
		return systemMenuService.removeMenuIcon(mlr);
	}
}
