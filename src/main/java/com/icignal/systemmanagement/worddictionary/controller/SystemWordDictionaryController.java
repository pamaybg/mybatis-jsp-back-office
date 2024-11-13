package com.icignal.systemmanagement.worddictionary.controller;

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
import com.icignal.systemmanagement.worddictionary.dto.request.SystemWordDictionaryReqDto;
import com.icignal.systemmanagement.worddictionary.dto.response.SystemWordDictionaryResDto;
import com.icignal.systemmanagement.worddictionary.service.SystemWordDictionarySerivce;

/*
 * 1. 클래스명	: SystemWordDictionaryController
 * 2. 파일명	: SystemWordDictionaryController.java
 * 3. 패키지명	: com.icignal.systemmanagement.worddictionary.controller
 * 4. 작성자명	: seungjun
 * 5. 작성일자	: 2020. 4. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *		용어사전 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/wordDictionary")
public class SystemWordDictionaryController extends BaseController{
	
	@Autowired
	AuthHelper authHelper;
	
	@Autowired
	SystemWordDictionarySerivce systemWordDictionarySerivce;
	
	
	 /*
	  * 1. 메소드명: getWordDictionaryList
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getWordDictionaryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemWordDictionaryResDto> getWordDictionaryList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemWordDictionarySerivce.getWordDictionaryList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getWordDicDetail
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getWordDicDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemWordDictionaryResDto getWordDicDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemWordDictionarySerivce.getWordDicDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getWordDictionaryChk
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 중복 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getWordDictionaryChk.do", method = RequestMethod.POST)
	public @ResponseBody SystemWordDictionaryResDto getWordDictionaryChk(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemWordDictionarySerivce.getWordDictionaryChk(reqDto);
	}
	
	 /*
	  * 1. 메소드명: setProdDtl
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/setWordDictionary.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setWordDictionary(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemWordDictionarySerivce.setWordDictionary(reqDto);
	}
	
	 /*
	  * 1. 메소드명: editWordDictionary
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/editWordDictionary.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editWordDictionary(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemWordDictionarySerivce.editWordDictionary(reqDto);
	}
	 /*
	  * 1. 메소드명: delWordDictionary
	  * 2. 클래스명: SystemWordDictionaryController
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/delWordDictionary.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delWordDictionary(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemWordDictionarySerivce.delWordDictionary(reqDto);
	}
	
}




