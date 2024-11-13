package com.icignal.loyalty.family.controller;

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
import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyCallbackResDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyListResDto;
import com.icignal.loyalty.family.service.LoyFamilyService;

/*
 * 1. 클래스명	: LoyFamilyController
 * 2. 파일명	: LoyFamilyController.java
 * 3. 패키지명	: com.icignal.loyalty.famaily.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		패밀리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/loyalty/family")
public class LoyFamilyController extends BaseController{
	
	@Autowired
	LoyFamilyService loyFamilyService;
	
	@Autowired
	AuthHelper authHelper;
	
     /*
      * 1. 메소드명: getFamilyList
      * 2. 클래스명: LoyFamilyController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 6. 22.
      */
    /**
     * <PRE>
     * 1. 설명
     *		패밀리 리스트
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param reqDto
     *   @return	
     */
    @RequestMapping(value="/getFamilyList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyFamilyListResDto> getFamilyList(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyFamilyListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyFamilyService.getFamilyList(reqDto);
    }
    
	 /*
	  * 1. 메소드명: clearMaskListMbr
	  * 2. 클래스명: LoyFamilyController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 마스킹해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/clearMaskFamilyList.do", method = RequestMethod.POST)
   	public @ResponseBody  LoyFamilyListResDto clearMaskListMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyFamilyService.clearMaskFamilyList(reqDto);
    }
	
	 /*
	  * 1. 메소드명: saveApprProcess
	  * 2. 클래스명: LoyFamilyController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 승인처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveApprProcess.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveApprProcess(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyFamilyService.saveApprProcess(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveCanlProcess
	  * 2. 클래스명: LoyFamilyController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 해제처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveCanlProcess.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCanlProcess(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyFamilyService.saveCanlProcess(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveNewFmly
	  * 2. 클래스명: LoyFamilyController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 신규 가입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 * @throws java.sql.SQLException 
	 */
	@RequestMapping(value="/saveNewFmly.do", method = RequestMethod.POST)
	public @ResponseBody LoyFamilyCallbackResDto saveNewFmly(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) throws java.sql.SQLException {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
//		return loyFamilyService.addMbr(reqDto);
		return loyFamilyService.saveNewFmly(reqDto);
	}
}
