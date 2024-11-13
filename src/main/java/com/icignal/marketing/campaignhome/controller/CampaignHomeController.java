/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: testCampaginController.java
 * 2. Package	: com.icignal.marketing.campaignhome.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 27. 오후 1:17:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.marketing.campaignhome.controller;

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
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.campaignhome.dto.request.CampaignHomeReqDto;
import com.icignal.marketing.campaignhome.dto.response.CampaignValatilityResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigNoticeResDto;
import com.icignal.marketing.campaignhome.dto.response.CampigPromotionResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignBaseResDto;
import com.icignal.marketing.campaignhome.dto.response.CampignCustTypeCdResDto;
import com.icignal.marketing.campaignhome.service.CampaignHomeService;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.response.ApprovalListResDto;


/*
 * 1. 클래스명	: CampaignHomeController
 * 2. 파일명	: testCampaginController.java
 * 3. 패키지명	: com.icignal.marketing.campaignhome.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/marketing/campaignhome")
public class CampaignHomeController extends BaseController{

	@Autowired
	public CampaignHomeService campaignHomeService;
	
	@Autowired
	AuthHelper authHelper;


     /*
      * 1. 메소드명: getHomePromList
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 30.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 전체 프로모션
     * 2. 사용법
     *
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getHomePromList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<CampigPromotionResDto> getHomePromList(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setEmpId(loginInfo.getId());
        
    	return campaignHomeService.getHomePromList(param);
    }

     /*
      * 1. 메소드명: getHomeNoticeList
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 30.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 공지사항 리스트
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getHomeNoticeList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<CampigNoticeResDto> getHomeNoticeList(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return campaignHomeService.getHomeNoticeList(param);
    }
    
     /*
      * 1. 메소드명: getTotalCust
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 28.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 전체회원수 조회
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getTotalCust.do", method = RequestMethod.POST)
    public @ResponseBody CampignCustTypeCdResDto getTotalCust(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return campaignHomeService.getTotalCust(param);
    }
    
     /*
      * 1. 메소드명: getNewCustOfMonth
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 28.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 당월 신규고객수
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getNewCustOfMonth.do", method = RequestMethod.POST)
    public @ResponseBody CampignBaseResDto getNewCustOfMonth(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return campaignHomeService.getNewCustOfMonth(param);
    }
    
     /*
      * 1. 메소드명: getPromotionOfMonth
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 30.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 당월 프로모션 진행건
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getPromotionOfMonth.do", method = RequestMethod.POST)
    public @ResponseBody int getPromotionOfMonth(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return campaignHomeService.getPromotionOfMonth(param);
    }
    
     /*
      * 1. 메소드명: getHomeVolatility
      * 2. 클래스명: CampaignHomeController
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 30.
      */
    /**
     * <PRE>
     * 1. 설명
     *		홈화면 - 가입자 변동추이
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param param
     *   @return	
     */
    @RequestMapping(value="/getHomeVolatility.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<CampaignValatilityResDto> getHomeVolatility(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return campaignHomeService.getHomeVolatility(param);
    }
    
	 /*
	  * 1. 메소드명: getMyElapproval2
	  * 2. 클래스명: CampaignHomeController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		내가 승인할 캠페인 목록 조회
	 *		table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mer
	 *   @return	
	 */
	@RequestMapping(value = "/getHomeApprovalList.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalListResDto> getHomeApprovalList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalListReqDto mer) {
		LogUtil.param(this.getClass(), mer);
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mer.setMemId(loginInfo.getEmpId());

		return campaignHomeService.getHomeApprovalList(mer);
	}
	
	 /*
	  * 1. 메소드명: getHomeApprovalReqList
	  * 2. 클래스명: CampaignHomeController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		내가 승인 요청한 캠페인 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mer
	 *   @return	
	 */
	@RequestMapping(value = "/getHomeApprovalReqList.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalListResDto> getHomeApprovalReqList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalListReqDto mer) {
		LogUtil.param(this.getClass(), mer);
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mer.setMemId(loginInfo.getEmpId());
		
		return campaignHomeService.getHomeApprovalReqList(mer);
	}
    /*
     * 1. 메소드명: getNewCustOfDay
     * 2. 클래스명: CampaignHomeController
     * 3. 작성자명: 2sh.park
     * 4. 작성일자: 2020. 01. 19.
     */
   /**
    * <PRE>
    * 1. 설명
    *		홈화면 - 금일 신규고객수
    * 2. 사용법
    *		
    * </PRE>
    *   @param request
    *   @param response
    *   @param param
    *   @return	
    */
   @RequestMapping(value="/getNewCustOfDay.do", method = RequestMethod.POST)
   public @ResponseBody CampignBaseResDto getNewCustOfDay(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
   	LogUtil.param(this.getClass(), param);
   	param.setLoginInfo(authHelper.checkLoginSession(request, response));
   	
   	return campaignHomeService.getNewCustOfDay(param);
   }
   /*
    * 1. 메소드명: getCampaignOfMonth
    * 2. 클래스명: CampaignHomeController
    * 3. 작성자명: 2sh.park
    * 4. 작성일자: 2020. 01. 19.
    */
  /**
   * <PRE>
   * 1. 설명
   *		홈화면 - 당월 캠페인
   * 2. 사용법
   *		
   * </PRE>
   *   @param request
   *   @param response
   *   @param param
   *   @return	
   */
  @RequestMapping(value="/getCampaignOfMonth.do", method = RequestMethod.POST)
  public @ResponseBody CampignBaseResDto getCampaignOfMonth(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
  	LogUtil.param(this.getClass(), param);
  	param.setLoginInfo(authHelper.checkLoginSession(request, response));
  	
  	return campaignHomeService.getCampaignOfMonth(param);
  }
  
  	/*
  	 * 1. 메소드명: getPointStatus
  	 * 2. 클래스명: CampaignHomeController
  	 * 3. 작성자명: 2sh.park
  	 * 4. 작성일자: 2021. 01. 20.
  	 */
  	/**
  	 * <PRE>
  	 * 1. 설명
  	 *		홈화면 - 포인트 현황
  	 * 2. 사용법
  	 *		
  	 * </PRE>
  	 *   @param request
  	 *   @param response
  	 *   @param param
  	 *   @return	
  	 */
  	@RequestMapping(value="/getPointStatus.do", method = RequestMethod.POST)
  	public @ResponseBody CampignBaseResDto getPointStatus(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(authHelper.checkLoginSession(request, response));
 	
  		return campaignHomeService.getPointStatus(param);
  	}

	/*
	 * 1. 메소드명: getCrmHome
	 * 2. 클래스명: CampaignHomeController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 02. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 F_CRM_HOME 집계테이블 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value="/getCrmHome.do", method = RequestMethod.POST)
  	public @ResponseBody CampignBaseResDto getCrmHome(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(authHelper.checkLoginSession(request, response));

  		return campaignHomeService.getCrmHome(param);
  	}

	/*
	 * 1. 메소드명: getHomeCamList
	 * 2. 클래스명: CampaignHomeController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 2. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 캠페인 목록
	 * 2. 사용법
	 * 		PROM_STAT_CD = 'A'
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value="/getHomeCamList.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<CampigPromotionResDto> getHomeCamList(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		//param.setEmpId(loginInfo.getId());

		return campaignHomeService.getHomeCamList(param);
	}

	/*
	 * 1. 메소드명: getHomeCamList
	 * 2. 클래스명: CampaignHomeController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 2. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		홈화면 - 캠페인 목록
	 * 2. 사용법
	 *		PROM_STAT_CD = 'W'
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value="/getHomeCamList2.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<CampigPromotionResDto> getHomeCamList2(HttpServletRequest request, HttpServletResponse response, @RequestBody CampaignHomeReqDto param) {
		LogUtil.param(this.getClass(), param);
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		//param.setEmpId(loginInfo.getId());

		return campaignHomeService.getHomeCamList2(param);
	}
}
