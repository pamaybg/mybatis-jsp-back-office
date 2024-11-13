/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTermMasterController.java
 * 2. Package	: com.icignal.loyalty.terms.termmaster.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 27. 오후 2:35:51
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.terms.termmaster.controller;

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
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsDetailListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsDetailListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsLoyPgmListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsValidChekResDto;
import com.icignal.loyalty.terms.termmaster.service.LoyTermMasterService;


/*
 * 1. 클래스명	: LoyTermMasterController
 * 2. 파일명	: LoyTermMasterController.java
 * 3. 패키지명	: com.icignal.loyalty.terms.termmaster.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/terms")
public class LoyTermMasterController extends BaseController {
		
	@Autowired
	AuthHelper authHelper;
	
	@Autowired
	LoyTermMasterService loyTermMasterService;

	
	/**
	* @programId :
	* @name : getTermsList
	* @date : 2018. 10. 31.
	* @author : mj.kim
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관관리 조회
	*/
	@RequestMapping(value="/getTermsList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> getTermsList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsList(reqDto);
	}

	 /*
	  * 1. 메소드명: getTermsDetail
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세 정보
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsDetailListResDto getTermsDetail(HttpServletRequest request, HttpServletResponse response, 	@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsDetail(reqDto);
	}

	/**
	* @programId :
	* @name : saveTermsList
	* @date : 2018. 10. 31.
	* @author : mj.kim
	* @table :
	* @return : StatusResponseDTO
	* @description :약관관리 추가
	*/
	@RequestMapping(value="/saveTermsList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveTermsList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		

		return loyTermMasterService.saveTermsList(reqDto);
	}

	 /*
	  * 1. 메소드명: modifyTermsList
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: mj.kim
	  * 4. 작성일자: 2018. 11. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관관리 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyTermsList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyTermsList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return loyTermMasterService.modifyTermsList(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: getTermsVerList
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsVerList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> getTermsVerList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsVerList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getTermsRcvChnl
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsRcvChnl.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsRcvChnlListResDto> getTermsRcvChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyTermMasterService.getTermsRcvChnl(reqDto);
	}

	 /*
	  * 1. 메소드명: saveTermsVersion
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveTermsVersion.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveTermsVersion(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.saveTermsVersion(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeTermsVersion
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeTermsVersion.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTermsVersion(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.removeTermsVersion(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getTermsVerDetail
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관관리 버전 상세 팝업 불러오기(rid)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsVerDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsDetailListResDto getTermsVerDetail(HttpServletRequest request, HttpServletResponse response, 	@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsVerDetail(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: modifyTermsVersion
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyTermsVersion.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyTermsVersion(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return loyTermMasterService.modifyTermsVersion(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: removeTermsList
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 삭제 - LOY_TERMS_M, LOY_TERMS_VER, LOY_TEMRS_RCV_CHNL(FLAG = 0 처리 않함)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeTermsList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTermsList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.removeTermsList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getTermsContent
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		버전에 따른 약관 내용 보여주기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsContent.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsDetailListResDto getTermsContent(HttpServletRequest request, HttpServletResponse response, 	@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsContent(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveRcvChnl
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveTermsRcvChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveTermsRcvChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.saveTermsRcvChnl(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyRcvChnl
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyTermsRcvChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyTermsRcvChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return loyTermMasterService.modifyTermsRcvChnl(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getTermsLoyPgmList
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsLoyPgmList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsLoyPgmListResDto> getTermsLoyPgmList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyTermMasterService.getTermsLoyPgmList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getRcvChnlDetail
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신 채널 상세 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getRcvChnlDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsDetailListResDto getRcvChnlDetail(HttpServletRequest request, HttpServletResponse response, 	@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getRcvChnlDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getLoyPgmTList
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트 팝업 (TABLE - LOY.LOY_PGM)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getLoyPgmTList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsLoyPgmListResDto> getLoyPgmTList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyTermMasterService.getLoyPgmTList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getLoyPgmDetai
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 상세 팝업 데이터 불러오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getLoyPgmDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsLoyPgmListResDto getLoyPgmDetail(HttpServletRequest request, HttpServletResponse response, 	@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getLoyPgmDetail(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: saveTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveTermsLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveTermsLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.saveTermsLoyPgm(reqDto);
	}

	 /*
	  * 1. 메소드명: modifyTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyTermsLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyTermsLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return loyTermMasterService.modifyTermsLoyPgm(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getTermsInfoDetail
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 약관 내용 보기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getTermsInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsDetailListResDto getTermsInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		return loyTermMasterService.getTermsInfoDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: validLoyaltyPgm
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세에서  사용여부 == 'Y' 인상태로 저장할때 로열티 프로그램 등록 확인(무조건 1개 이상 프로그램이 등록 되있어야한다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/validLoyaltyPgm.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsValidChekResDto validLoyaltyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyTermMasterService.validLoyaltyPgm(reqDto);
	}
	
	 /*
	  * 1. 메소드명: validTermsStatCheck
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상태 확인 (W : 작성중, A : 활성, S :중지) W 인상태로 저장할때 기존값이 W가 아니면 저장안됨
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/validTermsStatCheck.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsValidChekResDto validTermsStatCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyTermMasterService.validTermsStatCheck(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 로열티 프로그램 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeTermsLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTermsLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.removeTermsLoyPgm(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeTermsRcvChnl
	  * 2. 클래스명: LoyTermMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 항목 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeTermsRcvChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTermsRcvChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyTermMasterService.removeTermsRcvChnl(reqDto);
	}
	
	/**
	* @programId :
	* @name : getTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 조회
	*/
	@RequestMapping(value="/getTermsGrp.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> getTermsGrp(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : insertTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 신규
	*/
	@RequestMapping(value="/insertTermsGrp.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertTermsGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.insertTermsGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : getTermsGrpTermsPop
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 조회
	*/
	@RequestMapping(value="/getTermsGrpTermsPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> getTermsGrpTermsPop(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsGrpTermsPop(reqDto);
	}
	/**
	* @programId :
	* @name : getAlreadyTermsGrp
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 조회
	*/
	@RequestMapping(value="/getAlreadyTermsGrp.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsListResDto getAlreadyTermsGrp(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getAlreadyTermsGrp(reqDto);
	}
	/**
	* @programId :
	* @name : insertTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 수정
	*/
	@RequestMapping(value="/updateTermsGrp.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateTermsGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.updateTermsGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : deleteTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 삭제
	*/
	@RequestMapping(value="/deleteTermsGrp.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteTermsGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.deleteTermsGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : getTermsGrpTermsList
	* @table :
	* @return :
	* @description :약관 조회
	*/
	@RequestMapping(value="/getTermsGrpTermsList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> getTermsGrpTermsList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getTermsGrpTermsList(reqDto);
	}
	
	/**
	* @programId :
	* @name : insertTermsGrp
	* @table :
	* @return :
	* @description :약관그룹의 약관 신규
	*/
	@RequestMapping(value="/insertTermsGrpTerms.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertTermsGrpTerms(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.insertTermsGrpTerms(reqDto);
	}
	/**
	* @programId :
	* @name : getAlreadyTermsGrp
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 수정조회
	*/
	@RequestMapping(value="/getAlreadyTermsGrpTerms.do", method = RequestMethod.POST)
	public @ResponseBody LoyTermsListResDto getAlreadyTermsGrpTerms(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.getAlreadyTermsGrpTerms(reqDto);
	}
	
	/**
	* @programId :
	* @name : updateTermsListGrp
	* @table :
	* @return :
	* @description :약관그룹  약관 수정
	*/
	@RequestMapping(value="/updateTermsListGrp.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateTermsListGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.updateTermsListGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : deleteTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 삭제
	*/
	@RequestMapping(value="/deleteGrpTerms.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteGrpTerms(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTermMasterService.deleteGrpTerms(reqDto);
	}
	
	
}
