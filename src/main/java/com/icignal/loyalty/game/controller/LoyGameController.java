/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyGameController.java
 * 2. Package	: com.icignal.loyalty.game.controller
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 6. 23. 오후 3:27:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.	 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.game.controller;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.game.dto.request.*;
import com.icignal.loyalty.game.dto.response.*;
import com.icignal.loyalty.game.service.LoyGameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 1. 클래스명	: LoyGameController
 * 2. 파일명	: LoyGameController.java
 * 3. 패키지명	: com.icignal.loyalty.game.controller
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
@RequestMapping("/loyalty/game")
public class LoyGameController extends BaseController {

	@Autowired
	LoyGameService LoyGameService;

	@Autowired
	AuthHelper authHelper;

	@Autowired
	private LoggingHelper loggingHelper;

	/*
	 * 1. 메소드명: getGameList
	 * 2. 클래스명: LoyGameController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 목록 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGameResDto> getGameList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyGameReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameList(slr);
	}

	/*
	 * 1. 메소드명: exportExcelGameList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 엑셀 다운로드
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value="/exportExcelGameList.do", method = RequestMethod.POST)
	public String exportExcelStampBingoList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGameReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyGameService.getGameList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "게임 리스트");

		return "ExcelView";
	}

	/*
	 * 1. 메소드명: getGameDetail 
	 * 2. 클래스명: LoyGameController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyGameResDto getGameDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyGameReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameDetail(slr);
	}

	/*
	 * 1. 메소드명: insertGame 
	 * 2. 클래스명: LoyGameController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 입력
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addGame.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertGame(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyGameReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.insertGame(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateGame 
	 * 2. 클래스명: LoyGameController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editGame.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateGame(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyGameReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.updateGame(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delGame 
	 * 2. 클래스명: LoyGameController 
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeGame.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delGame(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyGameReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.delGame(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: stopGame
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/stopGame.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto stopGame(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody LoyGameReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.stopGame(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameSubDetail
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 세부 정책 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameSubDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyGameSubResDto getGameSubDetail(HttpServletRequest request, HttpServletResponse response,
									  @RequestBody LoyGameSubReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameSubDetail(slr);
	}


	/*
	 * 1. 메소드명: updateGameSub
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editGameSub.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editGameSub(HttpServletRequest request, HttpServletResponse response,
											   @RequestBody LoyGameSubReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.editGameSub(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeGameSub
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 삭제(Null 처리)
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeGameSub.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeGameSub(HttpServletRequest request, HttpServletResponse response,
													@RequestBody LoyGameSubReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.removeGameSub(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameRuleList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameRuleList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGameRuleResDto> getGameRuleList(HttpServletRequest request,
																			 HttpServletResponse response, @RequestBody LoyGameRuleReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameRuleList(slr);
	}

	/*
	 * 1. 메소드명: getGameRuleDetail
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameRuleDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyGameRuleResDto getGameRuleDetail(HttpServletRequest request, HttpServletResponse response,
										@RequestBody LoyGameRuleReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameRuleDetail(slr);
	}

	/*
	 * 1. 메소드명: insertGameRule
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/addGameRule.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertGameRule(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody LoyGameRuleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.insertGameRule(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: updateGameRule
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/editGameRule.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateGameRule(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody LoyGameRuleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.updateGameRule(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: delGameRule
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/removeGameRule.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto delGameRule(HttpServletRequest request, HttpServletResponse response,
												  @RequestBody LoyGameRuleReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = LoyGameService.delGameRule(slr);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameJoinList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임하위 참여자 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameJoinList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGameJoinResDto> getGameRuleList(HttpServletRequest request,
																			 HttpServletResponse response, @RequestBody LoyGameJoinReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameJoinList(slr);

	}

	/*
	 * 1. 메소드명: exportExcelGameJoinList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 참여자 엑셀 다운로드
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value="/exportExcelGameJoinList.do", method = RequestMethod.POST)
	public String exportExcelGameJoinList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGameJoinReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyGameService.getGameJoinList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "게임 참여자 리스트");

		return "ExcelView";
	}
	

	/*
	 * 1. 메소드명: getGameTicketList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임하위 티켓 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value = "/getGameTicketList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGameTicketResDto> getGameRuleList(HttpServletRequest request,
																			   HttpServletResponse response, @RequestBody LoyGameTicketReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return LoyGameService.getGameTicketList(slr);
	}

	/*
	 * 1. 메소드명: exportExcelGameTicketList
	 * 2. 클래스명: LoyGameController
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 23
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 티켓 엑셀 다운로드
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param slr
	 * @return
	 */
	@RequestMapping(value="/exportExcelGameTicketList.do", method = RequestMethod.POST)
	public String exportExcelGameTicketList (HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGameTicketReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);

		// 데이터 조회
		GridPagingResDto data = LoyGameService.getGameTicketList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "게임 티켓 리스트");

		return "ExcelView";
	}

}
