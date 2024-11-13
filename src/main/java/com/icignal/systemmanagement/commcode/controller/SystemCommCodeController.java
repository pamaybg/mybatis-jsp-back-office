package com.icignal.systemmanagement.commcode.controller;

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
import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCondListRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCondListResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExCountryItemsResDto;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;

/*
 * 1. 클래스명	: SystemCommController
 * 2. 파일명	: SystemCommController.java
 * 3. 패키지명	: com.icignal.systemmanagement.commcode.controller
 * 4. 작성자명	: kj.kang
 * 5. 작성일자	: 2016. 8. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - CommonCode 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/commcode")
public class SystemCommCodeController extends BaseController{
	
	@Autowired private SystemCommCodeService systemCommCodeService;
	
	@Autowired AuthHelper authhelper;
	
//	@Override
//	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
//	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
//		LogUtil.info("NavigatePopMenu start.....");
//		
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/popup/" +  name;
//
//    	String result = authhelper.checkUserInfoInclude(request, response, respUrl);
//    	LogUtil.info("resUrl: " + result);
//    	return result;
//	}
	
//	@Override
//	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
//	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/include/" + name;
//		return authhelper.checkUserInfoInclude(request, response, respUrl);
//		
//	}
	
	
	/**
	 * @name : getCommCodeList
	 * @date : 2015. 9. 22.
	 * @author : 류동균
	 * @description : 컴코드 목록 조회
	 */
	@RequestMapping(value="/getCommCodeList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MKTCommonCodeResponseDTO> getCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		authhelper.checkLoginSession(request, response);

		return systemCommCodeService.getCommCodeList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getParIdNullCodeList
	  * 2. 클래스명: SystemCommCodeController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		PAR_CODE_ID  = NULL
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getParIdNullCodeList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MKTCommonCodeResponseDTO> getParIdNullCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authhelper.checkLoginSession(request, response);
		
		return systemCommCodeService.getParIdNullCodeList(reqDto);
	}
	
	/**
	 * @name : getCommCondLIst
	 * @date : 2015. 9. 21.
	 * @author : 장용
	 * @table : mkt_cmn_srch (조건 목록 테이블)
	 * @return : GridPagingResDto
	 * @description : 공통 조건 조회
	 */
	@RequestMapping(value="/getCommCondLIst.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MKTCommonCondListResponseDTO> getCommCondLIst(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCondListRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		return systemCommCodeService.getCommCondLIst(reqDto);
	}
	
	
     /*
      * 1. 메소드명: getCommCodeExGroupList
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/getCommCodeExGroupList.do", method=RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExGroupList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExGridReqDto param ) {
    	LogUtil.param(this.getClass(), param);    	
    	authhelper.checkLoginSession(request, response);
    	
    	return systemCommCodeService.getCommCodeExGroupList(param);
    }
    
     /*
      * 1. 메소드명: getCommCodeExCodeList
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/getCommCodeExCodeList.do", method=RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExGridReqDto param ) {
    	LogUtil.param(this.getClass(), param);    	
    	authhelper.checkLoginSession(request, response);
    	
    	return systemCommCodeService.getCommCodeExSubList(param);
    }
    
     /*
      * 1. 메소드명: getCommCodeExParCodeList
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/getCommCodeExParCodeList.do", method=RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExParCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExGridReqDto param ) {
    	LogUtil.param(this.getClass(), param);    	
    	authhelper.checkLoginSession(request, response);
    	
    	return systemCommCodeService.getCommCodeExParCodeList(param);
    }
    
    
    
     /*
      * 1. 메소드명: addCommCodeExGroupCode
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/addCommCodeExGroupCode.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto addCommCodeExGroupCode(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setCreateBy(loginInfo.getEmpId());
    	param.setModifyBy(loginInfo.getEmpId());    	
    	param.setId(loginInfo.getId());
    	
    	return systemCommCodeService.addCommCodeExGroupCode(param);
    }
    
     /*
      * 1. 메소드명: addCommCodeExCodeName
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/addCommCodeExCodeName.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto addCommCodeExCodeName(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setCreateBy(loginInfo.getEmpId());
    	param.setModifyBy(loginInfo.getEmpId());    	
    	
    	
    	return systemCommCodeService.addCommCodeExCodeName(param);
    }
    
    
    
    
     /*
      * 1. 메소드명: editCommCodeExGroupName
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/editCommCodeExGroupName.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto editCommCodeExGroupName(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setModifyBy(loginInfo.getEmpId());    	
    	
    	return systemCommCodeService.editCommCodeExGroupName(param);
    }
    
     /*
      * 1. 메소드명: editCommCodeExCodeProperty
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/editCommCodeExCodeProperty.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto editCommCodeExCodeProperty(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setModifyBy(loginInfo.getEmpId());    	
    	
    	return systemCommCodeService.editCommCodeExCodeProperty(param);
    }
    
     /*
      * 1. 메소드명: editCommCodeExCodeAttribProperty
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/editCommCodeExCodeAttribProperty.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto editCommCodeExCodeAttribProperty(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        param.setModifyBy(loginInfo.getEmpId());
        param.setLang(loginInfo.getLang());
        
        return systemCommCodeService.editCommCodeExCodeAttribProperty(param);
    }
    
     /*
      * 1. 메소드명: editCommCodeExGroupCodeDel
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/editCommCodeExGroupCodeDel.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto editCommCodeExGroupCodeDel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setModifyBy(loginInfo.getEmpId());    	
    	
    	return systemCommCodeService.editCommCodeExGroupCodeDel(param);
    }
    
     /*
      * 1. 메소드명: editCommCodeExCodeNameDel
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/editCommCodeExCodeNameDel.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto editCommCodeExCodeNameDel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemCommCodeExReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
    	param.setModifyBy(loginInfo.getEmpId());    	
    	
    	return systemCommCodeService.editCommCodeExCodeNameDel(param);
    }
    
     /*
      * 1. 메소드명: getCommCodeExCountryCode
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: kj.kang 
      * 4. 작성일자: 2016. 8. 30.
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
    @RequestMapping(value="/getCommCodeExCountryCode.do", method=RequestMethod.POST)
    public @ResponseBody SystemCommCodeExCountryItemsResDto getCommCodeExCountryCode(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTBaseReqDto param) {
    	LogUtil.param(this.getClass(), param);    	
    	authhelper.checkLoginSession(request, response);
    	
    	return systemCommCodeService.getCommCodeExCountryCode(param);
    }
    
     /*
      * 1. 메소드명: reApplyServerCommCode
      * 2. 클래스명: SystemCommCodeController
      * 3. 작성자명: hr.noh 
      * 4. 작성일자: 2020. 3. 9.
      */
    /**
     * <PRE>
     * 1. 설명
     *		모든 공통코드 서버 재적용
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param	
     */
    @RequestMapping(value="/reApplyServerCommCode.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto reApplyServerCommCode(HttpServletRequest request, HttpServletResponse response) {
    	return systemCommCodeService.reApplyServerCommCode();
    }
}
