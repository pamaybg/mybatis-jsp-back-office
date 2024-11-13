/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustomerController.java
 * 2. Package	: com.icignal.loyalty.customer.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 9. 오전 11:50:20
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 9.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.loyalty.customer.dto.request.LOYCustAddInfoReqDto;
import com.icignal.loyalty.customer.dto.request.LOYCustReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustAgreHistListReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBnftReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustDetailMbrReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustMbrRelReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustNewReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustSettleReqDto;
import com.icignal.loyalty.customer.dto.response.LOYCustAddInfoResDto;
import com.icignal.loyalty.customer.dto.response.LOYCustResDto;
import com.icignal.loyalty.customer.dto.response.LOYMemberResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrDtlResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrResDto;
import com.icignal.loyalty.customer.dto.response.LoyCertCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorpDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorporationCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAlterHistResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAppHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBnftResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustChangeHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailMbrListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginInfoListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustMbrRelResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSettleResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSvrHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustWebHistListResDto;
import com.icignal.loyalty.customer.service.LoyCustomerService;
import com.icignal.loyalty.membership.dto.response.LoyMbrSegmentHistListResDto;

/*
 * 1. 클래스명	: LoyCustomerController
 * 2. 파일명	: LoyCustomerController.java
 * 3. 패키지명	: com.icignal.loyalty.customer.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/member/customer")
public class LoyCustomerController extends BaseController{
	
	@Autowired
	private LoyCustomerService loyCustomerService;
	
	@Autowired
	private AuthHelper authHelper;
	
	@Autowired
	private LoggingHelper loggingHelper;

	
	/**
     * @programId : PLOY_003
     * @name : getCustList
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table :
     * @return :
     * @description : 고객정보 조회
     */
    @RequestMapping(value="/getCustList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyCustNewResDto> getCustList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyCustNewReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyCustomerService.getCustList(reqDto);
    }


    /**
      * @programId :
      * @name : getCustDetail
      * @date : 2016. 12. 13.
      * @author : knlee
      * @table :
      * @변경이력 :
      * @description : 고객 상세 조회
      * @param request
      * @param response
      * @param reqDto
      * @return
      */
    @RequestMapping(value="/getCustDetail.do", method = RequestMethod.POST)
    public @ResponseBody  LoyCustDetailResDto getCustDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyCustomerService.getCustDetail(reqDto);
    }

	/**
	  * @programId : PLOY_004
	  * @name : insertCust
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객정보 추가
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="/addCust.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto insertCust(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.insertCust(reqDto);
    }

	/**
	  * @programId : PLOY_004
	  * @name : updateCust
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객정보 수정
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="editCust.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto updateCust(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.updateCust(reqDto);
    }


	/**
	  * @programId : PLOY_003
	  * @name : delCust
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객삭제
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="removeCust.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto delCust(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.delCust(reqDto);
    }





	/**
	  * @programId : PLOY_003
	  * @name : clearMaskCust
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 회원 마스크 해제
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="clearMaskCust.do", method=RequestMethod.POST)
    public @ResponseBody LOYCustResDto clearMaskCust(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

    	reqDto.setUri(request.getRequestURI());

    	return loyCustomerService.clearMaskCust(reqDto);
    }



	/**
	  * @programId : PLOY_005
	  * @name : getCustAddInfoList
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 부가정보리스트 조회
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="getCustAddInfoList.do", method=RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LOYCustAddInfoResDto> getCustAddInfoList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.getCustAddInfoList(reqDto);
    }


	/**
	  * @programId :
	  * @name : getCustAddInfoDetail
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객부가정보 상세 조회
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="getCustAddInfoDetail.do", method=RequestMethod.POST)
    public @ResponseBody LOYCustAddInfoResDto getCustAddInfoDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustAddInfoReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.getCustAddInfoDetail(reqDto);
    }




	/**
	  * @programId :
	  * @name : insertCustAddInfo
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고개부가정보 추가
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="addCustAddInfo.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto insertCustAddInfo(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustAddInfoReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.insertCustAddInfo(reqDto);
    }



	/**
	  * @programId : PLOY_004_01
	  * @name : getMemberList
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객 멤버쉽 회원 조회
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="getMemberList.do", method=RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LOYMemberResDto> getMemberList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.getMemberList(reqDto);
    }


	/**
	  * @programId :
	  * @name : updateCustAddInfo
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객부가정보 수정
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="editCustAddInfo.do", method=RequestMethod.POST)
	public @ResponseBody StatusResDto updateCustAddInfo(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustAddInfoReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.updateCustAddInfo(reqDto);
    }



	/**
	  * @programId :
	  * @name : delCust
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객 부가정보 삭제
	  * @param request
	  * @param response
	  * @param reqDto
	  * @return
	  */
	@RequestMapping(value="removeCustAddInfo.do", method=RequestMethod.POST)
    public @ResponseBody StatusResDto delCust(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LOYCustAddInfoReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyCustomerService.delCustAddInfo(reqDto);
    }
	
	 /*
	  * 1. 메소드명: getCustListPage
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 23.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCustListPage.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustNewResDto> getCustListPage(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCustListPage(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDetailNewPage
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 24.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCustDetailNewPage.do", method=RequestMethod.POST)
	public @ResponseBody LoyCustDetailNewResDto getCustDetailNewPage(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCustDetailNewPage(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCorpCustListPage
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCorpCustListPage.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCorporationCustResDto> getCorpCustListPage(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCorpCustListPage(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCorpCustDetailNewPage
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCorpCustDetailNewPage.do", method=RequestMethod.POST)
	public @ResponseBody LoyCorpDetailResDto getCorpCustDetailNewPage(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCorpCustDetailNewPage(reqDto);
	}
	
	 /*
	  * 1. 메소드명: clearMaskCustList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="clearMaskCustList.do", method=RequestMethod.POST)
	public @ResponseBody LoyCustNewResDto clearMaskCustList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.clearMaskCustList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: clearMaskCorpCustList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="clearMaskCorpCustList.do", method=RequestMethod.POST)
	public @ResponseBody LoyCorporationCustResDto clearMaskCorpCustList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.clearMaskCorpCustList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCertList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCertList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCertCustResDto> getCertList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCertList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustLoginList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCustLoginList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustLoginListResDto> getCustLoginList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCustLoginList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustAgreList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 6.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCustAgreList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustAgreListResDto> getCustAgreList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustNewReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCustAgreList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustAgreHistList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 10.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="getCustAgreHistList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustAgreHistListResDto> getCustAgreHistList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyCustAgreHistListReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyCustomerService.getCustAgreHistList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustSvrHistList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 10.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustSvrHistList.do", method = RequestMethod.POST)
	   	public @ResponseBody GridPagingResDto<LoyCustSvrHistListResDto> getCustSvrHistList(HttpServletRequest request, HttpServletResponse response,
	   			@RequestBody LoyCustNewReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.getCustSvrHistList(reqDto);
	}
	
	@RequestMapping(value="/getAlterSvrHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCustAlterHistResDto> getAlterSvrHistList(HttpServletRequest request, HttpServletResponse response,
   			@RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getAlterSvrHistList(reqDto);
	}
	
	@RequestMapping(value="/getAppSvrHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCustAppHistListResDto> getAppSvrHistList(HttpServletRequest request, HttpServletResponse response,
   			@RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getAppSvrHistList(reqDto);
	}
	
	@RequestMapping(value="/getChangeHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCustChangeHistListResDto> getChangeHistList(HttpServletRequest request, HttpServletResponse response,
   			@RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getChangeHistList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDetailMbrList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 회원 리스트 탭
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDetailMbrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustDetailMbrListResDto> getCustDetailMbrList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.getCustDetailMbrList(reqDto);
		}
	
	@RequestMapping(value = "/mbrExcelDn.do", method = RequestMethod.POST)
	public String authLogHistoryDownload(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyCustDetailMbrListResDto> data = loyCustomerService.getCustDetailMbrList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "회원 목록");

		return "ExcelView";
	}
	
	@RequestMapping(value="/getCustLoginInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustLoginInfoListResDto> getCustLoginInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.getCustLoginInfo(reqDto);
		}

	/*
	 * 1. 메소드명: loginFailCntInit
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: 2sh.park
	 * 4. 작성일자: 2021. 3. 22.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 실패 횟수 초기화
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/loginFailCntInit.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustLoginInfoListResDto> loginFailCntInit(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.loginFailCntInit(reqDto);
		}
	
	/*
	 * 1. 메소드명: getCustMbrRelList
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 2.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 소속 회원 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getCustMbrRelList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustMbrRelResDto> getCustMbrRelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustMbrRelReqDto  reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustMbrRelList(reqDto);
	}


	/*
	 * 1. 메소드명: getCustBranchList
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 브랜치 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getCustBranchList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustBranchResDto> getCustBranchList(HttpServletRequest request,
																				 HttpServletResponse response,
																				 @RequestBody LoyCustBranchReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustBranchList(slr);
	}

	/*
	 * 1. 메소드명: getCustBranchDetail
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 브랜치 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getCustBranchDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustBranchResDto getCustBranchDetail(HttpServletRequest request,
																 HttpServletResponse response,
																 @RequestBody LoyCustBranchReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustBranchDetail(slr);
	}

	/*
	 * 1. 메소드명: insertCustBranch
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 브랜치 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addCustBranch.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertCustBranch(HttpServletRequest request,
													   HttpServletResponse response,
													   @RequestBody LoyCustBranchReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.insertCustBranch(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateCustBranch
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 브랜치 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editCustBranch.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCustBranch(HttpServletRequest request,
													   HttpServletResponse response,
													   @RequestBody LoyCustBranchReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.updateCustBranch(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustBranch
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 브랜치 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeCustBranch.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delCustBranch(HttpServletRequest request,
													HttpServletResponse response,
													@RequestBody LoyCustBranchReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.delCustBranch(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getCustSettleDetail
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 정산 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getCustSettleDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustSettleResDto getCustSettleDetail(HttpServletRequest request,
																 HttpServletResponse response,
																 @RequestBody LoyCustSettleReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustSettleDetail(slr);
	}

	/*
	 * 1. 메소드명: insertCustSettle
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 정산 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addCustSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertCustSettle(HttpServletRequest request,
													   HttpServletResponse response,
													   @RequestBody LoyCustSettleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.insertCustSettle(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateCustSettle
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 정산 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editCustSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCustSettle(HttpServletRequest request,
													   HttpServletResponse response,
													   @RequestBody LoyCustSettleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.updateCustSettle(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustSettle
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 정산 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeCustSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delCustSettle(HttpServletRequest request,
													HttpServletResponse response,
													@RequestBody LoyCustSettleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.delCustSettle(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getCustBnftList
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 혜택 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getCustBnftList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustBnftResDto> getCustBnftList(HttpServletRequest request,
																			 HttpServletResponse response,
																			 @RequestBody LoyCustBnftReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustBnftList(slr);
	}

	/*
	 * 1. 메소드명: getCustBnftDetail
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 혜택 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getCustBnftDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustBnftResDto getCustBnftDetail(HttpServletRequest request,
															 HttpServletResponse response,
															 @RequestBody LoyCustBnftReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustomerService.getCustBnftDetail(slr);
	}

	/*
	 * 1. 메소드명: insertCustBnft
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 혜택 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addCustBnft.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertCustBnft(HttpServletRequest request,
													 HttpServletResponse response,
													 @RequestBody LoyCustBnftReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.insertCustBnft(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateCustBnft
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editCustBnft.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCustBnft(HttpServletRequest request,
													 HttpServletResponse response,
													 @RequestBody LoyCustBnftReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.updateCustBnft(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustBnft
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 하위 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeCustBnft.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delCustBnft(HttpServletRequest request,
												  HttpServletResponse response,
												  @RequestBody LoyCustBnftReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = loyCustomerService.delCustBnft(slr);

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getCustSegmentHistList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: sh.park
	  * 4. 작성일자: 2020. 7. 23.
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
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getCustSegmentRuleHist.do", method = RequestMethod.POST)
  	public @ResponseBody  GridPagingResDto<LoyMbrSegmentHistListResDto> getCustSegmentRuleHist(HttpServletRequest request, HttpServletResponse response, @RequestBody LOYCustReqDto reqDto) {
      LogUtil.param(this.getClass(), reqDto);
      reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

      return loyCustomerService.getCustSegmentRuleHist(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustWebHistList
	  * 2. 클래스명: LoyCustomerController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 - 서비스 이용내역 - 웹이용내역 상세이력 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustWebHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCustWebHistListResDto> getCustWebHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getCustWebHistList(reqDto);
	}
	
	
	/*
	 * 1. 메소드명: getCafe24MemList
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 20
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	
	@RequestMapping(value="/getCafe24MemList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCafe24MbrResDto> getCafe24MemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getCafe24MemList(reqDto);
	}
	
	/*
	 * 1. 메소드명: cafe24ExcelDown
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	
	
	@RequestMapping(value = "/cafe24ExcelDown.do", method = RequestMethod.POST)
	public String cafe24ExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		if(StringUtil.isNotEmpty(reqDto.getStrWhere())) {
			reqDto.setStrWhere(" AND "+reqDto.getStrWhere());
		} else {
			reqDto.setStrWhere("");
		}
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.MBR_CAFE_24,reqDto.getStrCondWhere()+reqDto.getStrWhere());
		
		
		GridPagingResDto<LoyCafe24MbrDtlResDto> data = loyCustomerService.getCafe24MemListExcel(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "cafe24 회원 목록");

		return "ExcelView";
	}
	
	
	/*
	 * 1. 메소드명: getCafe24MemDetail
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 20
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 상세조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	
	@RequestMapping(value="/getCafe24MemDetail.do", method = RequestMethod.POST)
   	public @ResponseBody LoyCafe24MbrDtlResDto getCafe24MemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getCafe24MemDetail(reqDto);
	}
	
	
	/*
	 * 1. 메소드명: getCafe24MbrCamHist
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 20
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 캠페인 이력 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	
	@RequestMapping(value="/getCafe24MbrCamHist.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyCafe24MbrResDto> getCafe24MbrCamHist(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyCustomerService.getCafe24MbrCamHist(reqDto);
	}
	
	
	
	/*
	 * 1. 메소드명: clearMaskCf24MbrList
	 * 2. 클래스명: LoyCustomerController
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 12. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 마스킹해제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	
	@RequestMapping(value="/clearMaskCf24MbrList.do", method = RequestMethod.POST)
   	public @ResponseBody LoyCafe24MbrResDto clearMaskCf24MbrList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustNewReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
       reqDto.setUri(request.getRequestURI());
       
       
       return loyCustomerService.clearMaskCf24MbrList(reqDto);
	}
	/**
	 * <PRE>
	 * 1. 설명
	 *		모바일 이력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/getMobileCustLoginInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustLoginInfoListResDto> getMobileCustLoginInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.getMobileCustLoginInfo(reqDto);
		}
	/**
	 * <PRE>
	 * 1. 설명
	 *		모바일 이력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/getMbrMobileLoginPopGrid.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustLoginInfoListResDto> getMbrMobileLoginPopGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustDetailMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyCustomerService.getMbrMobileLoginPopGrid(reqDto);
		}	
	
}
