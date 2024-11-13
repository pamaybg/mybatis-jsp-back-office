/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemConditionController.java
 * 2. Package	: com.icignal.systemmanagement.condition.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 5. 오후 4:03:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 5.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.condition.controller;

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
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.condition.dto.request.SystemGetBaseTableListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionDetailReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetDropDownListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetMenuListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetSrcColumListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemModifyConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemRemoveConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemSetConditionReqDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetBaseTableListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionDetailResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetDropDownListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetSrcColumListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemgetMenuListResDto;
import com.icignal.systemmanagement.condition.service.SystemConditionService;

/*
 * 1. 클래스명	: SystemConditionController
 * 2. 파일명	: SystemConditionController.java
 * 3. 패키지명	: com.icignal.systemmanagement.condition.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/system/condition")
public class SystemConditionController extends BaseController{
	
	@Autowired
	public SystemConditionService systemConditionService;
	
	@Autowired
	public AuthHelper authHelper;
	
//	@Override
//	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
//	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {		
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/popup/" +  name;
//		checkProgramAuth(respUrl, request ,response , model);
//		
//    	String result = authHelper.checkUserInfoInclude(request, response, respUrl);
//    	return result;
//	}
	
	/**
	 * @programId : MKT_RCH_001
	 * @name : menuList
	 * @date : 2015. 9. 23.
	 * @author : 장용
	 * @table : MENU (메뉴 목록 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 조건을 등록할 화면 목록을 조회
	 */
	@RequestMapping(value="/getMenuList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemgetMenuListResDto> getMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetMenuListReqDto mlr) {
		LogUtil.param(this.getClass(),mlr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mlr.setEmpId(loginInfo.getId());
		
		return systemConditionService.getMenuList(mlr);
	}
	
	/**
	 * @programId : MKT_RCH_002
	 * @name : conditionList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조회조건 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 화면별 조회 조건 리스트를 조회
	 */
	@RequestMapping(value="/getConditionList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetConditionResDto> getConditionList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetConditionListReqDto clr) {
		LogUtil.param(this.getClass(),clr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
				
		//세션에 저장되어 있는 지원의 아이디를 셋팅
//		clr.setAccntId(loginInfo.getAccountOrgId());
		
		return systemConditionService.getConditionList(clr);
	}
	
	/**
	 * @programId : MKT_RCH_003
	 * @name : getDropDownList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : COMMCODE (조회조건 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 드롭다운 리스트 그룹 목록 조회
	 */
	@RequestMapping(value="/getDropDownList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetDropDownListResDto> getDropDownList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetDropDownListReqDto ddl) {
		LogUtil.param(this.getClass(),ddl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemConditionService.getDropDownList(ddl);
	}
	
	/**
	 * @programId : MKT_RCH_004
	 * @name : getBaseTableList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : TABLELIST (테이블 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 드롭다운 리스트 그룹 목록 조회
	 */
	@RequestMapping(value="/getBaseTableList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetBaseTableListResDto> getBaseTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetBaseTableListReqDto btl) {
		LogUtil.param(this.getClass(),btl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
//		btl.setAccntId(loginInfo.getAccountOrgId());
		
		return systemConditionService.getBaseTableList(btl);
	}
	
	/**
	 * @programId : MKT_RCH_005
	 * @name : getSrcColumList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : TABLEL_COLUM_LIST(테이블 컬럼 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 테이블에 해당하는 컬럼 리스트 조회
	 */
	@RequestMapping(value="/getSrcColumList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetSrcColumListResDto> getSrcColumList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetSrcColumListReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemConditionService.getSrcColumList(scl);
	}
	
	/**
	 * @programId : MKT_RCH_006
	 * @name : setCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResponseDTO
	 * @description : 조건 저장
	 */
	@RequestMapping(value="/setCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetConditionReqDto scr) {
		LogUtil.param(this.getClass(),scr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		scr.setEmpId(loginInfo.getId());
		
		return systemConditionService.setCondition(scr);
	}
	
	/**
	 * @programId : MKT_RCH_007
	 * @name : getConditionDetail
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : MKTgetConditionDetailResponseDTO
	 * @description : 조건 상세 조회
	 */
	@RequestMapping(value="/getConditionDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetConditionDetailResDto getConditionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetConditionDetailReqDto cdr) {
		LogUtil.param(this.getClass(),cdr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		cdr.setEmpId(loginInfo.getId());
		
		return systemConditionService.getConditionDetail(cdr);
	}
	
	/**
	 * @programId : MKT_RCH_008
	 * @name : modifyCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResponseDTO
	 * @description : 조건 상세 조회
	 */
	@RequestMapping(value="/modifyCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto modifyCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemModifyConditionReqDto mcr) {
		LogUtil.param(this.getClass(),mcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setEmpId(loginInfo.getId());
		
		return systemConditionService.modifyCondition(mcr);
	}
	
	/**
	 * @programId : MKT_RCH_009
	 * @name : removeCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResponseDTO
	 * @description : 조건 삭제
	 */
	@RequestMapping(value="/removeCondition.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeCondition(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemRemoveConditionReqDto rcr) {
		LogUtil.param(this.getClass(),rcr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		rcr.setEmpId(loginInfo.getId());
		
		return systemConditionService.removeCondition(rcr);
	}
	
	/**
	 * @name : groupDetailList
	 * @date : 2015. 9. 22.
	 * @author : 장용
	 * @description : 그룹코드 상세 조회
	 */
	@RequestMapping(value="/groupDetailList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MKTCommonCodeResponseDTO> groupDetailList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO bccr) {
		LogUtil.param(this.getClass(), bccr);
	     
		authHelper.checkLoginSession(request, response);
		return systemConditionService.groupDetailList(bccr);
	}
	
	@RequestMapping(value="/getDropDownListColumList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetSrcColumListResDto> getDropDownListColumList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetSrcColumListReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemConditionService.getDropDownListColumList(scl);
	}
	
	@RequestMapping(value="/addTableList.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto addTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetSrcColumListReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemConditionService.addTableList(scl);
	}
}
