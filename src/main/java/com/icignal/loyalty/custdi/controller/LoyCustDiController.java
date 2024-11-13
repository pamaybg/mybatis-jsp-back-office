package com.icignal.loyalty.custdi.controller;

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
import com.icignal.loyalty.custdi.dto.request.LoyCustDiDetailReqDto;
import com.icignal.loyalty.custdi.dto.request.LoyCustDiListReqDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiValListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstResDto;
import com.icignal.loyalty.custdi.service.LoyCustDiService;

@Controller
@RequestMapping("/loyalty/custdi")
public class LoyCustDiController extends BaseController{

	@Autowired
	LoyCustDiService loyCustDiService;
	
	@Autowired
	AuthHelper authHelper;
	
	 /*
	  * 1. 메소드명: getCustDiList
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDiList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustDiListResDto> getCustDiList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustDiService.getCustDiList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDiDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDiDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustDiDetailResDto getCustDiDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustDiService.getCustDiDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDiValList
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 식별값 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDiValList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustDiValListResDto> getCustDiValList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustDiService.getCustDiValList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveCustDiDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveCustDiDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustDiDetailResDto saveCustDiDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyCustDiService.saveCustDiDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyCustDiDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyCustDiDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyCustDiDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyCustDiService.modifyCustDiDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDiValDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDiValDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustDiDetailResDto getCustDiValDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustDiService.getCustDiValDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveCustDiValDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/saveCustDiValDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCustDiValDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyCustDiService.saveCustDiValDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: modifyCustDiValDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/modifyCustDiValDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyCustDiValDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyCustDiService.modifyCustDiValDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCustDupRstList
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복 결과 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCustDupRstList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustDupRstResDto> getCustDupRstList(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCustDiService.getCustDupRstList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeCustDiVal
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeCustDiVal.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustDiVal(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		return loyCustDiService.removeCustDiVal(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getDupRstDetail
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 중복체크 결과 상세 - I: 개인, C: 단체(사업자)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getDupRstDetail.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustDupRstDetailResDto> getDupRstDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyCustDiService.getDupRstDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: custMergePrcs
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복 결과 병합 처리 (작업상태만 완료로 바뀌게 해놨음 - 추후 개발 필요)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/custMergePrcs.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto custMergePrcs(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyCustDiService.custMergePrcs(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeCustDi
	  * 2. 클래스명: LoyCustDiController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeCustDi.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustDi(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return loyCustDiService.removeCustDi(reqDto);
	}
	
	@RequestMapping(value="/getMaxSeq.do", method = RequestMethod.POST)
	public @ResponseBody LoyCustDiDetailResDto getMaxSeq(HttpServletRequest request, HttpServletResponse response, @RequestBody  LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyCustDiService.getMaxSeq(reqDto);
	}
}
