package com.icignal.loyalty.club.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.FileUploadResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.club.dto.request.LoyClubAttrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubMbrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubAttrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrAttrDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.club.service.LoyClubMasterService;

/*
 * 1. 클래스명	: LoyClubMasterController
 * 2. 파일명	: LoyClubController.java
 * 3. 패키지명	: com.icignal.loyalty.club.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		멤버십 클럽 - Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/loyalty/club")
public class LoyClubMasterController extends BaseController{
	
	@Autowired
	LoyClubMasterService loyClubMasterService;
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getClubList
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubListResDto> getClubList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyClubMasterService.getClubList(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: getClubAttrList
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubAttrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubAttrListResDto> getClubAttrList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyClubMasterService.getClubAttrList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getClubDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto getClubDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyClubMasterService.getClubDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveClubDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveClubDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto saveClubDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.saveClubDetail(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: modifyClubDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyClubDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto modifyClubDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.modifyClubDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeClub
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeClub.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeClub(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.removeClub(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: getClubAttrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클러 속성 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubAttrDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto getClubAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyClubMasterService.getClubAttrDetail(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: saveClubAttrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveClubAttrDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveClubAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.saveClubAttrDetail(reqDto);
	}
	 /*
	  * 1. 메소드명: modifyClubAttrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyClubAttrDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyClubAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.modifyClubAttrDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeClubAttr
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 정보 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeClubAttr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeClubAttr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.removeClubAttr(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getClubOfferList
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 혜택 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubOfferList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubOfferListResDto> getClubOfferList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyClubMasterService.getClubOfferList(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: saveClubOfferDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveClubOfferDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveClubOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.saveClubOfferDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyClubOfferDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyClubOfferDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyClubOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.modifyClubOfferDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeClubOffer
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 삭제(FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeClubOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeClubOffer(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.removeClubOffer(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getClubOfferDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value="/getClubOfferDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto getClubOfferDetail (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyClubMasterService.getClubOfferDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getClubMbrList
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubMbrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubMbrListResDto> getClubMbrList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyClubMasterService.getClubMbrList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getClubAttrInMbr
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 -> 속성정보 가져오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubAttrInMbr.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubAttrListResDto> getClubAttrInMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyClubMasterService.getClubAttrInMbr(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getMbrListPop -> getClubMbrListPop
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubMbrListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrListPopResDto> getClubMbrListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyClubMasterService.getClubMbrListPop(reqDto);
	}
	
	 /*
	  * 1. 메소드명: clearMaskMbrNew
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 리스트 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/clearMaskMbrNew.do", method = RequestMethod.POST)
	public @ResponseBody  LoyMbrListPopResDto clearMaskMbrNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
    LogUtil.param(this.getClass(), reqDto);
    reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

    return loyClubMasterService.clearMaskMbrNew(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveClubMbrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveClubMbrDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyClubDetailResDto saveClubMbrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.saveClubMbrDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyClubMbrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 수정	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	@RequestMapping(value="/modifyClubMbrDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyClubMbrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyClubMasterService.modifyClubMbrDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getClubMbrDetail
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세(속성값 가져와서 뿌려주기)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubMbrDetail.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubMbrAttrDetailResDto> getClubMbrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyClubMasterService.getClubMbrDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: clubMbrFileupload
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 증빙서류 파일 업로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param file
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = "/clubMbrFileupload.do", method = RequestMethod.POST, headers = "content-type=multipart/*") 
	public @ResponseBody FileUploadResDto clubMbrFileupload(@RequestParam(value = "file", required = false) MultipartFile file, @RequestParam(value = "clubMbrRid") String clubMbrRid,
			@RequestParam(value = "ridAttr") String ridAttr,	HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true); 

		return loyClubMasterService.clubMbrFileupload(session.getId(), file, clubMbrRid, ridAttr);
	}
	
	 /*
	  * 1. 메소드명: clearMaskClubMbr
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 리스트 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/clearMaskClubMbr.do", method = RequestMethod.POST)
   	public @ResponseBody  LoyMbrListPopResDto clearMaskClubMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyClubMasterService.clearMaskClubMbr(reqDto);
 	}
	
	 /*
	  * 1. 메소드명: apprClubMbr
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 - 승인(상태 STAT_CD : A)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/apprClubMbr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto apprClubMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

       return loyClubMasterService.apprClubMbr(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveResnRgst
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 (반려, 탈뢰)사유 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveResnRgst.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveResnRgst(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyClubMasterService.saveResnRgst(reqDto);
	}	
	
	 /*
	  * 1. 메소드명: getClubMbrListCheck
	  * 2. 클래스명: LoyClubMasterController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클러 회원 신청 여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getClubMbrValidCheck.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getClubMbrValidCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyClubMasterService.getClubMbrValidCheck(reqDto);
	}	
	
}
