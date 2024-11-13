/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampController.java
 * 2. Package	: com.icignal.loyalty.stamp.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 25. 오후 5:26:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stamp.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.stamp.dto.request.LoyStampListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtRemoveReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtUpldReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreUpldReqDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpItemListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrTgtListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpStoreListResDto;
import com.icignal.loyalty.stamp.service.LoyStampService;



/*
 * 1. 클래스명	: LoyStampController
 * 2. 파일명	: LoyStampController.java
 * 3. 패키지명	: com.icignal.loyalty.stamp.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/stamp")
public class LoyStampController extends BaseController{
	
	@Autowired
	private LoyStampService loyStampService;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	@Autowired
	private AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
			HttpServletResponse response,Model model) {
		LogUtil.debug("NavigatePopMenu start.....");
			
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		//Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;
		
		//checkProgramAuth(respUrl, request ,response , model);
		
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;
	
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}
	
	/**
     * @programId :
     * @name : getStampTxnList
     * @date : 2017. 10. 13.
     * @author : kimjunki
     * @table : loy.loy_stmp_txn 
     * @return : GridPagingResDto
     * @description : 스탬프 거래 리스트 조회
    **/
    @RequestMapping(value="/stampTxnList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStampListResDto> getStampTxnList(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStampListReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
   
        return loyStampService.getStampTxnList(param);
    }

	/**
	  * @programId :
	  * @name : getStampTxnDetail
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : loy.loy_stmp_txn
	  * @return : GridPagingResDto
	  * @description : 스탬프 상세 조회
	 **/
    @RequestMapping(value="/getStampDetail.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStampDetailResDto> getStampTxnDetail(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStampListReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyStampService.getStampTxnDetail(param);
    }
	/**
	  * @programId :
	  * @name : getStampDetailPop
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table :  loy.loy_stmp_txn
	  * @return : GridPagingResDto
	  * @description : 스탬프 상세 팝업
	 **/
    @RequestMapping(value="/getStampDetailPop.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStampDetailResDto> getStampDetailPop(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStampListReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyStampService.getStampDetailPop(param);
    }
    
    /* ========================= 다이소 스탬프 ========================= */
    /**
    * @programId :
    * @name : getLoyStmpList
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 스탬프 목록 조회
    */
    @RequestMapping(value="/getLoyStmpList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStmpListResDto> getLoyStmpList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyStampService.getLoyStmpList(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpDetail
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : LOYStmpDetailResponseDTO
    * @description : 스탬프 상세 조회
    */
    @RequestMapping(value="/getLoyStmpDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyStmpDetailResDto getLoyStmpDetail(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpDetail(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpDetail2
    * @date : 2019. 3. 26.
    * @author : hy.jun
    * @table :
    * @return : LOYStmpDetailResponseDTO
    * @description : 회원 상세 > 스탬프 (tab) > 스탬프정보 조회
    */
    @RequestMapping(value="/getLoyStmpDetail2.do", method = RequestMethod.POST)
    public @ResponseBody LoyStmpDetailResDto getLoyStmpDetail2(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpDetail2(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpItemList
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 스탬프 구간별 스탬프 목록 조회
    */
    @RequestMapping(value="/getLoyStmpItemList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStmpItemListResDto> getLoyStmpItemList(HttpServletRequest request, HttpServletResponse response, 
    	   @RequestBody LoyStmpItemListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpItemList(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpStoreList
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 스탬프 적용채널 목록 조회
    */
    @RequestMapping(value="/getLoyStmpStoreList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStmpStoreListResDto> getLoyStmpStoreList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpStoreListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpStoreList(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpMbrList
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 스탬프 참여 회원 조회
    */
    @RequestMapping(value="/getLoyStmpMbrList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStmpMbrListResDto> getLoyStmpMbrList(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStmpMbrListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpMbrList(param);
    }
    
    /**
    * @programId :
    * @name : setLoyStmp
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 등록
    */
    @RequestMapping(value="/setLoyStmp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto setLoyStmp(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.setLoyStmp(param, request.getSession(true));
    }
    
    /**
    * @programId :
    * @name : removeLoyStmp
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 삭제
    */
    @RequestMapping(value="/removeLoyStmp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeLoyStmp(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.removeLoyStmp(param);
    }
    
    /**
    * @programId :
    * @name : activeStmp
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 활성
    */
    @RequestMapping(value="/activeStmp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto activeStmp(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.activeStmp(param);
    }
    
    /**
     * @programId :
     * @name : inactiveStmp
     * @date : 2019. 3. 6.
     * @author : hy.jun
     * @table :
     * @return : StatusResDto
     * @description : 스탬프 비활성
     */
    @RequestMapping(value="/inactiveStmp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto inactiveStmp(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.inactiveStmp(param);
    }
    
    /**
    * @programId :
    * @name : editLoyStmp
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 수정
    */
    @RequestMapping(value="/editLoyStmp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto editLoyStmp(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.editLoyStmp(param, request.getSession(true));
    }
    
    /**
    * @programId :
    * @name : editLoyStmpItem
    * @date : 2019. 3. 6.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 아이템 수정 (구간별 스탬프 수정)
    */
    @RequestMapping(value="/editLoyStmpItem.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto editLoyStmpItem(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpItemDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.editLoyStmpItem(param);
    }
    
    /**
    * @programId :
    * @name : removeLoyStmpStore
    * @date : 2019. 3. 14.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 적용채널 삭제
    */
    @RequestMapping(value="/removeLoyStmpStore.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeLoyStmpStore(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpStoreDeleteReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.removeLoyStmpStore(param);
    }
    
    /**
     * @programId :
     * @name : setLoyStmpStore
     * @date : 2019. 4. 12.
     * @author : hy.jun
     * @table :
     * @return : StatusResDto
     * @description : 스탬프 적용채널 등록
     */
    @RequestMapping(value="/setLoyStmpStore.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto setLoyStmpStore(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpStoreInsertReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.setLoyStmpStore(param);
    }
    
    /**
    * @programId :
    * @name : excelDownLoyStmpStoreList
    * @date : 2019. 3. 8.
    * @author : hy.jun
    * @table :
    * @return : String
    * @description : 스탬프 적용채널 목록 엑셀 다운로드
    */
    @RequestMapping(value="/excelDownLoyStmpStoreList.do", method = RequestMethod.POST)
    public String excelDownLoyStmpStoreList(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStmpStoreListReqDto param, ModelMap model) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setSystemColumn(param.getSystemColumn());
        edlr.setTargetId(param.getRidStmp());
        
        GridPagingResDto<LoyStmpStoreListResDto> data = loyStampService.getLoyStmpStoreList(param);

//        iICNLogService.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.STMP_MBR);
        
    	model.addAttribute("result", data);
        model.addAttribute("excelHeader", param.getExcelHeader());
        model.addAttribute("fileName", "스탬프 적용채널 리스트");
    	return "ExcelView";
    }
    
    /**
     * @programId :
     * @name : excelDownLoyStmpMbrList
     * @date : 2019. 3. 8.
     * @author : hy.jun
     * @table :
     * @return : String
     * @description : 스탬프 참여 회원 목록 엑셀 다운로드
     */
    @RequestMapping(value="/excelDownLoyStmpMbrList.do", method = RequestMethod.POST)
    public String excelDownLoyStmpMbrList(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStmpMbrListReqDto param, ModelMap model) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
    	edlr.setSystemColumn(param.getSystemColumn());
    	edlr.setTargetId(param.getRidStmp());
    	
    	GridPagingResDto<LoyStmpMbrListResDto> data = loyStampService.getLoyStmpMbrList(param);
    	
    	loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.STMP_MBR);
    	
    	model.addAttribute("result", data);
    	model.addAttribute("excelHeader", param.getExcelHeader());
    	model.addAttribute("fileName", "스탬프 참여회원 리스트");
    	return "ExcelView";
    }
    
    /**
    * @programId :
    * @name : excelUploadStmpStoreTemplate
    * @date : 2019. 3. 14.
    * @author : hy.jun
    * @table :
    * @return : LOYStmpExcelUploadResponseDTO
    * @description : 스탬프 적용채널 엑셀 업로드
    */
    @RequestMapping(value="/excelUploadStmpStoreTemplate.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto excelUploadStmpStoreTemplate(
            @RequestParam("file") MultipartFile file,
            @RequestParam("ridStmp") String ridStmp,
    		HttpServletRequest request, HttpServletResponse response) {
        
        LoyStmpStoreUpldReqDto param = new LoyStmpStoreUpldReqDto();
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        param.setRidStmp(ridStmp);
        
        return loyStampService.excelUploadStmpStoreTemplate(file, param);
    }
    
    /**
    * @programId :
    * @name : getStmpItemDetail
    * @date : 2019. 3. 14.
    * @author : hy.jun
    * @table :
    * @return : LOYStmpItemListResponseDTO
    * @description : 스탬프 아이템 상세 조회
    */
    @RequestMapping(value="/getStmpItemDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyStmpItemListResDto getStmpItemDetail(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpItemDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getStmpItemDetail(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpMbrTgtList
    * @date : 2019. 4. 22.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 스탬프 적용회원 목록 조회
    */
    @RequestMapping(value="/getLoyStmpMbrTgtList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyStmpMbrTgtListResDto> getLoyStmpMbrTgtList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpMbrTgtListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.getLoyStmpMbrTgtList(param);
    }
    
    /**
    * @programId :
    * @name : removeLoyStmpMbrTgt
    * @date : 2019. 4. 22.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 적용회원 초기화
    */
    @RequestMapping(value="/removeLoyStmpMbrTgt.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeLoyStmpMbrTgt(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyStmpMbrTgtRemoveReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.removeLoyStmpMbrTgt(param);
    }
    
    /**
    * @programId :
    * @name : excelUploadStmpMbrTgtTemplate
    * @date : 2019. 4. 22.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description : 스탬프 적용회원 업로드
    */
    @RequestMapping(value="/excelUploadStmpMbrTgtTemplate.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto excelUploadStmpMbrTgtTemplate(
    		@RequestParam("file") MultipartFile file,
    		@RequestParam("ridStmp") String ridStmp,
    		HttpServletRequest request, HttpServletResponse response) {
    	
    	LoyStmpMbrTgtUpldReqDto param = new LoyStmpMbrTgtUpldReqDto();
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	param.setRidStmp(ridStmp);
    	
    	return loyStampService.excelUploadStmpMbrTgtTemplate(file, param);
    }
    
    /**
    * @programId :
    * @name : excelDownLoyStmpMbrTgtList
    * @date : 2019. 4. 22.
    * @author : hy.jun
    * @table :
    * @return : String
    * @description : 스탬프 적용회원 목록 다운로드
    */
    @RequestMapping(value="/excelDownLoyStmpMbrTgtList.do", method = RequestMethod.POST)
    public String excelDownLoyStmpMbrTgtList(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyStmpMbrTgtListReqDto param, ModelMap model) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setSystemColumn(param.getSystemColumn());
        edlr.setTargetId(param.getRidStmp());
        
        GridPagingResDto<LoyStmpMbrTgtListResDto> data = loyStampService.getLoyStmpMbrTgtList(param);

//        iICNLogService.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.STMP_MBR);
        
    	model.addAttribute("result", data);
        model.addAttribute("excelHeader", param.getExcelHeader());
        model.addAttribute("fileName", "스탬프 특정회원 리스트");
    	return "ExcelView";
    }
    
    /**
    * @programId :
    * @name : excelDownloadMbrTgtTemplate
    * @date : 2019. 4. 22.
    * @author : hy.jun
    * @table :
    * @return : void
    * @description : 스탬프 적용회원 템플릿 다운로드
    */
    @RequestMapping(value="/excelDownloadMbrTgtTemplate.do", method = RequestMethod.GET)
    public void excelDownloadMbrTgtTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        loyStampService.createDownloadMbrTgtTemplate(response, loginInfo);
    }
    
    /**
    * @programId :
    * @name : setLoyStmpMbrTgt
    * @date : 2019. 4. 24.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description :
    */
    @RequestMapping(value="/setLoyStmpMbrTgt.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto setLoyStmpMbrTgt(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStmpMbrTgtInsertReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.setLoyStmpMbrTgt(param);
    }
    
    /**
    * @programId :
    * @name : removeLoyStmpMbrTgt2
    * @date : 2019. 4. 24.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description :
    */
    @RequestMapping(value="/removeLoyStmpMbrTgt2.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeLoyStmpMbrTgt2(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStmpMbrTgtDeleteReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.removeLoyStmpMbrTgt2(param);
    }
    
    /**
    * @programId :
    * @name : removeLoyStmpItemCamNo
    * @date : 2019. 4. 24.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description :
    */
    @RequestMapping(value="/removeLoyStmpItemCamNo.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeLoyStmpItemCamNo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStmpItemDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyStampService.removeLoyStmpItemCamNo(param);
    }
	
	
}
