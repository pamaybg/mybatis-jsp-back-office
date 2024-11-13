/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPointDropController.java
 * 2. Package	: com.icignal.loyalty.membership.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 26. 오후 3:21:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 26.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.controller;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointDropReqDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrPointDropResDto;
import com.icignal.loyalty.membership.service.LoyMbrService;

/*
 * 1. 클래스명	: LoyPointDropController
 * 2. 파일명	: LoyPointDropController.java
 * 3. 패키지명	: com.icignal.loyalty.membership.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/pointdrop")
public class LoyPointDropController extends BaseController{
	
	@Autowired
	private LoyMbrService loyMbrService;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
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
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;
		return authHelper.checkUserInfoInclude(request, response, respUrl);
	}
	
	/**
	* @programId :
	* @name : getPointDropList
	* @date : 2018. 11. 5.
	* @author : mj.kim
	* @table :
	* @return : GridPagingResponseDTO
	* @description :소멸예정 조회
	*/
	@RequestMapping(value="/getPointDropList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrPointDropResDto> getPointDropList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyMbrPointDropReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
		encrypor.setPassword("9pwc3dke");

		return loyMbrService.getPointDropList(reqDto);
	}
	
	@RequestMapping(value="/getPointDropDown.do", method = RequestMethod.POST)
	public String getPointDropDown(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyMbrPointDropReqDto reqDto, ModelMap model)throws Exception{
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setSystemColumn(reqDto.getSystemColumn());
        edlr.setTargetId(null);

        loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.PNT_DROP_MBR);
		
		
		GridPagingResDto<LoyMbrPointDropResDto> data = loyMbrService.getPointDropList(reqDto);
		
		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "소멸 포인트 예정자 조회");
        
		return "ExcelView";
	}
}
