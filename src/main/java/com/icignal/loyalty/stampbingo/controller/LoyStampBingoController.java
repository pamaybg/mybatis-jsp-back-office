/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampBingoController.java
 * 2. Package	: com.icignal.loyalty.stampbingo.controller
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 6. 23. 오후 3:27:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.		 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stampbingo.controller;

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
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.channel.dto.response.LoyChnlResDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoBenfReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoChnlReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoMbrHistReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoMbrReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoStepReqDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoBenfResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoMbrHistResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoMbrResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoStepResDto;
import com.icignal.loyalty.stampbingo.service.LoyStampBingoService;

/*
 * 1. 클래스명	: LoyStampBingoController
 * 2. 파일명	: LoyStampBingoController.java
 * 3. 패키지명	: com.icignal.loyalty.stampbingo.controller
 * 4. 작성자명	: nh.lee
 * 5. 작성일자	: 2020. 6. 23.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/stampBingo")
public class LoyStampBingoController extends BaseController {

	@Autowired
	LoyStampBingoService LoyStampBingoService;

	@Autowired
	AuthHelper authHelper;

	@Autowired
	private LoggingHelper loggingHelper;

	/*
	 * 1. 메소드명: getStampBingoList
	 * 2. 클래스명: LoyStampBingoController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 목록 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoResDto> getStampBingoList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoList(slr);
	}

	@RequestMapping(value="/exportExcelStampBingoList.do", method = RequestMethod.POST)
	public String exportExcelStampBingoList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStampBingoReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyStampBingoService.getStampBingoList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "스탬프 빙고 리스트");

		return "ExcelView";
	}

	/*
	 * 1. 메소드명: getStampBingoDetail 
	 * 2. 클래스명: LoyStampBingoController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 상세 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyStampBingoResDto getStampBingoDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStampBingoReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoDetail(slr);
	}

	/*
	 * 1. 메소드명: insertStampBingo 
	 * 2. 클래스명: LoyStampBingoController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 입력
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addStampBingo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertStampBingo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.insertStampBingo(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateStampBingo 
	 * 2. 클래스명: LoyStampBingoController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editStampBingo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateStampBingo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.updateStampBingo(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingo 
	 * 2. 클래스명: LoyStampBingoController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeStampBingo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delStampBingo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.delStampBingo(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: stopStampBingo
	 * 2. 클래스명: LoyStampBingoController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/stopStampBingo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto stopStampBingo(HttpServletRequest request, HttpServletResponse response,
													@RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.stopStampBingo(slr);

		return rtnValue;
	}


	/*
	 * 1. 메소드명: getStampBingoStepList
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoStepList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoStepResDto> getStampBingoStepList(HttpServletRequest request,
																						 HttpServletResponse response,
																						 @RequestBody LoyStampBingoStepReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoStepList(slr);
	}

	/*
	 * 1. 메소드명: getStampBingoStepDetail
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoStepDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyStampBingoStepResDto getStampBingoStepDetail(HttpServletRequest request,
																		 HttpServletResponse response,
																		 @RequestBody LoyStampBingoStepReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoStepDetail(slr);
	}

	/*
	 * 1. 메소드명: insertStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addStampBingoStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertStampBingoStep(HttpServletRequest request,
														   HttpServletResponse response,
														   @RequestBody LoyStampBingoStepReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.insertStampBingoStep(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editStampBingoStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateStampBingoStep(HttpServletRequest request,
														   HttpServletResponse response,
														   @RequestBody LoyStampBingoStepReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.updateStampBingoStep(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeStampBingoStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delStampBingoStep(HttpServletRequest request,
														HttpServletResponse response,
														@RequestBody LoyStampBingoStepReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.delStampBingoStep(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStampBingoMbrListNl
	 * 2. 클래스명: LoyStampBingoController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoMbrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoMbrResDto> getStampBingoMbrList(HttpServletRequest request,
																					   HttpServletResponse response,
																					   @RequestBody LoyStampBingoMbrReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoMbrList(slr);
	}

	@RequestMapping(value="/exportExcelStampBingoMbrList.do", method = RequestMethod.POST)
	public String exportExcelStampBingoList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStampBingoMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyStampBingoService.getStampBingoMbrList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "스탬프 빙고 참여자 리스트");

		return "ExcelView";
	}
	
	/*
	 * 1. 메소드명: getStampBingoMbrHistList
	 * 2. 클래스명: LoyStampBingoController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 참여이력 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoMbrHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoMbrHistResDto> getStampBingoMbrHistList(HttpServletRequest request,
																							   HttpServletResponse response,
																							   @RequestBody LoyStampBingoMbrHistReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoMbrHistList(slr);
	}

	/*
	 * 1. 메소드명: getStampBingoChnlList
	 * 2. 클래스명: LoyStampBingoController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoChnlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlResDto> getStampBingoChnlList(HttpServletRequest request,
																			   HttpServletResponse response,
																			   @RequestBody LoyStampBingoChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoChnlList(slr);
	}

	/*
	 * 1. 메소드명: addStampBingoChnl
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 행사점 추가
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addStampBingoChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addStampBingoChnl(HttpServletRequest request,
														   HttpServletResponse response,
														   @RequestBody LoyStampBingoChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.addStampBingoChnl(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 행사점 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeStampBingoChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeStampBingoChnl(HttpServletRequest request,
														HttpServletResponse response,
														@RequestBody LoyStampBingoChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.removeStampBingoChnl(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStampBingoChnlHistList
	 * 2. 클래스명: LoyStampBingoController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 참여이력
	 *		목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoChnlHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoMbrResDto> getStampBingoChnlHistList(HttpServletRequest request,
																			   HttpServletResponse response,
																			   @RequestBody LoyStampBingoChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoChnlHistList(slr);
	}

	@RequestMapping(value="/exportExcelStampBingoChnlHistList.do", method = RequestMethod.POST)
	public String exportExcelStampBingoChnlHistList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyStampBingoChnlReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyStampBingoService.getStampBingoChnlHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "스탬프 빙고 행사점별 참여자 리스트");

		return "ExcelView";
	}

	/*
	 * 1. 메소드명: getPmgList
	 * 2. 클래스명: LoyStampBingoBenfController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoBenfList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoBenfResDto> getStampBingoBenfList(HttpServletRequest request,
																						 HttpServletResponse response,
																						 @RequestBody LoyStampBingoBenfReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoBenfList(slr);
	}

	/*
	 * 1. 메소드명: getStampBingoBenfDetail
	 * 2. 클래스명: LoyStampBingoBenfController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getStampBingoBenfDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyStampBingoBenfResDto getStampBingoBenfDetail(HttpServletRequest request,
																		 HttpServletResponse response,
																		 @RequestBody LoyStampBingoBenfReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampBingoBenfDetail(slr);
	}

	/*
	 * 1. 메소드명: insertStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addStampBingoBenf.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertStampBingoBenf(HttpServletRequest request,
														   HttpServletResponse response,
														   @RequestBody LoyStampBingoBenfReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.insertStampBingoBenf(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editStampBingoBenf.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateStampBingoBenf(HttpServletRequest request,
														   HttpServletResponse response,
														   @RequestBody LoyStampBingoBenfReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.updateStampBingoBenf(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeStampBingoBenf.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delStampBingoBenf(HttpServletRequest request,
														HttpServletResponse response,
														@RequestBody LoyStampBingoBenfReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyStampBingoService.delStampBingoBenf(slr);

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getStampBingoList
	  * 2. 클래스명: LoyStampBingoController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 10.
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
	 *   @param slr
	 *   @return	
	 */
	@RequestMapping(value = "/getStampListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStampBingoResDto> getStampListPop(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyStampBingoReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyStampBingoService.getStampListPop(slr);
	}

}
