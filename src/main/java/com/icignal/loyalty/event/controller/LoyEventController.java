/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyEventController.java
 * 2. Package	: com.icignal.loyalty.event.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 18. 오후 3:08:35
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 18.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.Messages;
import com.icignal.core.exception.RequiredFieldException;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.event.dto.request.LoyAddPromReqDto;
import com.icignal.loyalty.event.dto.request.LoyAddTierReqDto;
import com.icignal.loyalty.event.dto.request.LoyApplctRdmReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPlanExcutionReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPreviewTokenReqDto;
import com.icignal.loyalty.event.dto.request.LoyEvtApplctReqDto;
import com.icignal.loyalty.event.dto.request.LoyLimitMbrReqDto;
import com.icignal.loyalty.event.dto.request.LoyProdEntryReqDto;
import com.icignal.loyalty.event.dto.request.LoyStoreListReqDto;
import com.icignal.loyalty.event.dto.request.LoyUGCAchReqDto;
import com.icignal.loyalty.event.dto.request.LoyUGCListReqDto;
import com.icignal.loyalty.event.dto.response.LoyAddPromResDto;
import com.icignal.loyalty.event.dto.response.LoyApplctRdmResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPlanExcutionDetailResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPlanExcutionResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPreviewTokenResDto;
import com.icignal.loyalty.event.dto.response.LoyEventProdEnrtyExcelResDto;
import com.icignal.loyalty.event.dto.response.LoyEventProdEntryResDto;
import com.icignal.loyalty.event.dto.response.LoyEventWinningCondResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtApplctExcelResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtApplctResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtWinnerResDto;
import com.icignal.loyalty.event.dto.response.LoyLimitMbrResDto;
import com.icignal.loyalty.event.dto.response.LoyProdEntryResDto;
import com.icignal.loyalty.event.dto.response.LoyStoreListResDto;
import com.icignal.loyalty.event.dto.response.LoyTierLimitListResDto;
import com.icignal.loyalty.event.dto.response.LoyUGCAchResDto;
import com.icignal.loyalty.event.dto.response.LoyUGCListResDto;
import com.icignal.loyalty.event.service.LoyEventService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: LoyEventController
 * 2. 파일명	: LoyEventController.java
 * 3. 패키지명	: com.icignal.loyalty.event.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/event")
public class LoyEventController extends BaseController{
	
	@Autowired
	private LoyEventService loyEventService;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	@Autowired
	private AuthHelper authHelper;
	
	@Autowired
	CommonService commonService;
	
	/**
	 * @programId :
	 * @name : getEventPlanExcutionList
	 * @date : 2019. 6. 19.
	 * @author : dw.keum
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description : 이벤트 리스트
	 */
	@RequestMapping(value = "/getEventPlanExcutionList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyEventPlanExcutionResDto> getEventPlanExcutionList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyEventPlanExcutionResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getEventPlanExcutionList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getEventPlanExcutionList
	 * @date : 2019. 6. 19.
	 * @author : dw.keum
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description : 프로모션 리스트
	 */
	@RequestMapping(value = "/getPromotionPopUpList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyEventPlanExcutionResDto> getPromotionPopUpList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyEventPlanExcutionResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getPromotionPopUpList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : saveEventPlane
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 이벤트저장
	 */
	@RequestMapping(value = "/saveEventPlane.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveEventPlane(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.saveEventPlane(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : eventPlanDetail
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEventPlanExcutionDetailResponseDTO
	 * @description : 이벤트상세
	 */
	@RequestMapping(value = "/eventPlanDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPlanExcutionDetailResDto eventPlanDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		rtnValue = loyEventService.eventPlanDetail(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : updateEventPlane
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 이벤트 업데이트
	 */
	@RequestMapping(value = "/updateEventPlane.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateEventPlane(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.updateEventPlane(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : deleteEventPlan
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 이벤트삭제
	 */
	@RequestMapping(value = "/deleteEventPlan.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteEventPlan(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.deleteEventPlan(param);
	}

	/**
	 * @programId :
	 * @name : updateStartEventPlan
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 이벤트 시작
	 */
	@RequestMapping(value = "/updateStartEventPlan.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateStartEventPlan(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.updateStartEventPlan(param);
	}

	/**
	 * @programId :
	 * @name : updateFinishEventPlan
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : event 종료
	 */
	@RequestMapping(value = "/updateFinishEventPlan.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateFinishEventPlan(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.updateFinishEventPlan(param);
	}

	/**
	 * @programId :
	 * @name : updateStopEventPlan
	 * @date : 2019. 6. 25.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : event 중지
	 */
	@RequestMapping(value = "/updateStopEventPlan.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateStopEventPlan(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.updateStopEventPlan(param);
	}

	/**
	 * @programId :
	 * @name : getEventApplicantList
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description : 응모자 리스트
	 */
	@RequestMapping(value = "/getEventApplicantList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyEvtApplctResDto> getEventApplicantList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyEvtApplctResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getEventApplicantList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : evtApplicantDown
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : String
	 * @description : 응모자 엑셀 다운로드
	 */
	@RequestMapping(value = "/evtApplicantDown.do", method = RequestMethod.POST)
	public String evtApplicantDown(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
		ProgramCache proResDto = null;
		String ObjCode = reqDto.getObjCode();
		//MetaData 가져오기
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
		
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.EVT_APPLICANT,reqDto.getStrCondWhere());

		GridPagingResDto<LoyEvtApplctExcelResDto> data = loyEventService.getEvtApplicantDown(reqDto);

		model.addAttribute("result", data);
		//model.addAttribute("excelHeader", reqDto.getExcelHeader());
		//model.addAttribute("fileName", "이벤트 참여자 리스트");

		return "ExcelView";
	}

	/**
	 * @programId :
	 * @name : eventWinnerExcelDown
	 * @date : 2019. 7. 5.
	 * @author : dw.keum
	 * @table :
	 * @return : String
	 * @description :
	 */
	@RequestMapping(value = "/eventWinnerExcelDown.do", method = RequestMethod.POST)
	public String eventWinnerExcelDown(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);
		//프로그램 경로 가져오기
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
		ProgramCache proResDto = null;
		String ObjCode = reqDto.getObjCode();
		//MetaData 가져오기
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
		if(StringUtil.isNotEmpty(reqDto.getStrWhere())) {
			reqDto.setStrWhere(" AND "+reqDto.getStrWhere());
		}
		else {
			reqDto.setStrWhere("");
		}
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.EVT_WINNER,reqDto.getStrCondWhere()+reqDto.getStrWhere());

		GridPagingResDto<LoyEventProdEnrtyExcelResDto> data = loyEventService.getWinnerExcelDownList(reqDto);

		model.addAttribute("result", data);
		//model.addAttribute("excelHeader", reqDto.getExcelHeader());
		//model.addAttribute("fileName", "이벤트 당첨자 리스트");

		return "ExcelView";
	}

	/**
	 * @programId :
	 * @name : cancelVote
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/cancelVote.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPlanExcutionDetailResDto cancelVote(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		rtnValue = loyEventService.cancelVote(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : insertTransferWinner
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/insertTransferWinner.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertTransferWinner(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.insertTransferWinner(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : validWinnerTransfer
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/validWinnerTransfer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto validWinnerTransfer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.validWinnerTransfer(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getProdEntryList
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description :
	 */
	@RequestMapping(value = "/getProdEntryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyEventProdEntryResDto> getProdEntryList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyEventProdEntryResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getProdEntryList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : insertNewEvtWinner
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/insertEvtWinner.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertEvtWinner(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.insertEvtWinner(reqDto);

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: insertEvtApplict
	  * 2. 클래스명: LoyEventController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 10. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	참여자 신규	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/insertEvtApplict.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertEvtApplict(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.insertEvtApplict(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : deleteEventWinner
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/deleteEventWinner.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteEventWinner(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.deleteEventWinner(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : eventWinnerReset
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/eventWinnerReset.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto eventWinnerReset(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.eventWinnerReset(reqDto);

		return rtnValue;
	}
	
	/**
	 * @programId :
	 * @name : eventApplicantReset
	 * @date : 2021. 03. 18.
	 * @author : jb.kim
	 * @table :
	 * @return : StatusResDto
	 * @description : [이벤트 > 응모/참여형 > 참여자 탭] 참여자 목록 초기화
	 */
	@RequestMapping(value = "/eventApplicantReset.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto eventApplicantReset(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.eventApplicantReset(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : benefitPayment
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEventPlanExcutionDetailResponseDTO
	 * @description :
	 */
	@RequestMapping(value = "/benefitPayment.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPlanExcutionDetailResDto benefitPayment(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		rtnValue = loyEventService.benefitPayment(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : cancleBenefitPayment
	 * @date : 2019. 6. 26.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEventPlanExcutionDetailResponseDTO
	 * @description :
	 */
	@RequestMapping(value = "/cancleBenefitPayment.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPlanExcutionDetailResDto cancleBenefitPayment(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		rtnValue = loyEventService.cancleBenefitPayment(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : setEventWinnerMultiUpload
	 * @date : 2019. 6. 27.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/setEventWinnerMultiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity setEventWinnerMultiUpload(MultipartHttpServletRequest request, ModelMap model,
			HttpServletResponse response) throws IOException {
		authHelper.checkLoginSession(request.getSession(true));

		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil();
		List<LoyEvtApplctReqDto> batchUpload = new ArrayList<LoyEvtApplctReqDto>();
		StatusResDto rtnValue = new StatusResDto();
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LoyEvtApplctReqDto br = new LoyEvtApplctReqDto();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String rid = CommonUtil.newRid();
		String eventRid = (String) obj.get("eventRid");
		String eventNo = (String) obj.get("eventNo");

		try {
			batchUpload = excelUpld.excelUploadEventWinner(request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}

		if (batchUpload.size() > 0) {
			if (batchUpload.get(0).getUploadValidCheck() != null) {
				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
				}
			} else {
				br.setArray(batchUpload);
				br.setRid(rid);
				br.setLoginInfo(loginInfo);
				br.setEventRid(eventRid);
				br.setEventNo(eventNo);
				
				rtnValue = loyEventService.insertEventWinnerList(br);
				rtnValue.setMessage("저장되었습니다.");
			}
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", rtnValue);
		String jsonData = "";
		try {
			jsonData = new ObjectMapper().writeValueAsString(map);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");
		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
	}

	/**
	 * @programId :
	 * @name : setEventApplicantMultiUpload
	 * @date : 2021. 03. 17.
	 * @author : jb.kim
	 * @table :
	 * @return : StatusResDto
	 * @description : [이벤트 > 응모/참여형 > 참여자 탭] 참여자 '엑셀업로드' 
	 */
	@RequestMapping(value = "/setEventApplicantMultiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity setEventApplicantMultiUpload(MultipartHttpServletRequest request, ModelMap model,
			HttpServletResponse response) throws IOException {
		authHelper.checkLoginSession(request.getSession(true));

		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil();
		List<LoyEvtApplctReqDto> batchUpload = new ArrayList<LoyEvtApplctReqDto>();
		StatusResDto rtnValue = new StatusResDto();
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LoyEvtApplctReqDto br = new LoyEvtApplctReqDto();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		
		String rid = CommonUtil.newRid();
		String eventRid = (String) obj.get("eventRid");
		String eventNo = (String) obj.get("eventNo");
		String excelUploadType = (String) obj.get("excelUploadType");

		try {
			batchUpload = excelUpld.excelUploadEventWinner(request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}

		if (batchUpload.size() > 0) {
			if (batchUpload.get(0).getUploadValidCheck() != null) {
				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
				}
			} else {
				br.setArray(batchUpload);
				br.setRid(rid);
				br.setLoginInfo(loginInfo);
				br.setEventRid(eventRid);
				br.setEventNo(eventNo);
				br.setExcelUploadType(excelUploadType);
				
				rtnValue = loyEventService.insertEventApplicantList(br);
				rtnValue.setMessage("저장되었습니다.");
			}
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", rtnValue);
		String jsonData = "";
		
		try {
			jsonData = new ObjectMapper().writeValueAsString(map);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");
		
		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
	}
	
	
	/**
	 * @programId :
	 * @name : getSelectProdEntryList
	 * @date : 2019. 6. 27.
	 * @author : dw.keum
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description :
	 */
	@RequestMapping(value = "/getSelectProdEntryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProdEntryResDto> getSelectProdEntryList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyProdEntryResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getSelectProdEntryList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : updateSendSuccess
	 * @date : 2019. 6. 27.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 */
	@RequestMapping(value = "/updateSendSuccess.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateSendSuccess(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.updateSendSuccess(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : updateSendCancel
	 * @date : 2019. 6. 27.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 발송취소
	 */
	@RequestMapping(value = "/updateSendCancel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateSendCancel(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.updateSendCancel(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : setProdEntryMultiUpload
	 * @date : 2019. 6. 27.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description :
	 *//*
	@RequestMapping(value = "/setProdEntryMultiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity setProdEntryMultiUpload(MultipartHttpServletRequest request, ModelMap model,
			HttpServletResponse response) throws IOException {
		this.checkLoginSession(request.getSession(true));

		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil();
		List<LOYProdEntryRequestDTO> batchUpload = new ArrayList<LOYProdEntryRequestDTO>();
		StatusResDto rtnValue = new StatusResDto();
		MKTLoginResponseDTO loginInfo = this.checkLoginSession(request, response);
		LOYProdEntryRequestDTO br = new LOYProdEntryRequestDTO();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String rid = iMKTBase.getRowID();
		String eventRid = (String) obj.get("eventRid");

		try {
			batchUpload = excelUpld.excelUploadProdEntry(request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}

		if (batchUpload.size() > 0) {
			if (batchUpload.get(0).getUploadValidCheck() != null) {
				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
				}
			} else {
				br.setArray(batchUpload);
				br.setRid(rid);
				br.setLoginInfo(loginInfo);
				br.setEventRid(eventRid);

				rtnValue = loyEventService.insertEventProdEntryList(br);
				rtnValue.setMessage("저장되었습니다.");
			}
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", rtnValue);
		String jsonData = "";
		try {
			jsonData = new ObjectMapper().writeValueAsString(map);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");
		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
	}
*/
	/**
	 * @programId :
	 * @name : evtAppliClearMask
	 * @date : 2019. 7. 11.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEvtApplctResponseDTO
	 * @description :
	 */
	@RequestMapping(value = "/evtAppliClearMask.do", method = RequestMethod.POST)
	public @ResponseBody LoyEvtApplctResDto evtAppliClearMask(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());

		return loyEventService.evtAppliClearMask(reqDto);
	}

	/**
	 * @programId :
	 * @name : evtWinnerClearMask
	 * @date : 2019. 7. 11.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEvtWinnerResponseDTO
	 * @description :
	 */
	@RequestMapping(value = "/evtWinnerClearMask.do", method = RequestMethod.POST)
	public @ResponseBody LoyEvtWinnerResDto evtWinnerClearMask(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());

		return loyEventService.evtWinnerClearMask(reqDto);
	}

	/**
	 * @programId :
	 * @name : evtProdEntryClearMask
	 * @date : 2019. 7. 11.
	 * @author : dw.keum
	 * @table :
	 * @return : LOYEventProdEntryResponseDTO
	 * @description :
	 */
	@RequestMapping(value = "/evtProdEntryClearMask.do", method = RequestMethod.POST)
	public @ResponseBody LoyProdEntryResDto evtProdEntryClearMask(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());

		return loyEventService.evtProdEntryClearMask(reqDto);
	}

	/**
	 * @programId :
	 * @name : getEventPreviewToken
	 * @date : 2019. 7. 17.
	 * @author : dg.ryu
	 * @table :
	 * @return : LOYEventPreviewTokenResponseDTO
	 * @description : 이벤트 미리보기 토큰 조회
	 */
	@RequestMapping(value = "/getEventPreviewToken.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPreviewTokenResDto getEventPreviewToken(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		return loyEventService.getEventPreviewToken(reqDto);
	}

	/**
	 * @programId :
	 * @name : removeEventPreviewToken
	 * @date : 2019. 7. 17.
	 * @author : dg.ryu
	 * @table :
	 * @return : LOYEventPreviewTokenResponseDTO
	 * @description : 이벤트 미리보기 토큰 삭제
	 */
	@RequestMapping(value = "/removeEventPreviewToken.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeEventPreviewToken(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		return loyEventService.removeEventPreviewToken(reqDto);
	}

	/**
	 * @programId :
	 * @name : setEventWinCmplt
	 * @date : 2019. 7. 26.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : 이벤트 당첨 완료
	 */
	@RequestMapping(value = "/setEventWinCmplt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeEventPreviewToken(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		return loyEventService.setEventWinCmplt(reqDto);
	}
	
	/**
	* @programId :
	* @name : getEventWinCompleteYn
	* @date : 2021. 03. 18.
	* @author : jb.kim
	* @table :
	* @return : 
	* @description : 해당 이벤트의 '당첨완료'여부를 체크
	*/
	@RequestMapping(value = "/getEventWinCompleteYn.do", method = RequestMethod.POST)
	public @ResponseBody LoyEvtApplctResDto getEventWinCompleteYn(HttpServletRequest request, HttpServletResponse response
			, @RequestBody LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.getEventWinCompleteYn(reqDto);
	}
	
	/**
	 * @programId :
	 * @name : eventProdEntryExcelDown
	 * @date : 2019. 7. 29.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : 신청자 엑셀 다운로드 목록 조회
	 */
	@RequestMapping(value = "/eventProdEntryExcelDown.do", method = RequestMethod.POST)
	public String eventProdEntryExcelDown(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyProdEntryReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.EVT_PRODENTRY);

		GridPagingResDto<LoyProdEntryResDto> data = loyEventService.getProdEntryExcelDownList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "이벤트 신청자 리스트");

		return "iCNExcelView";
	}

	/**
	 * @programId :
	 * @name : getMbrStoreList
	 * @date : 2019. 9. 10.
	 * @author : 2sh.kim
	 * @table :
	 * @return : GridPagingResDto<>
	 * @description : 스토어 거래이력 조회
	 */
	@RequestMapping(value = "/getMbrStoreList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyStoreListResDto> getMbrStoreList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStoreListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		GridPagingResDto<LoyStoreListResDto> rtnValue = new GridPagingResDto<>();

		rtnValue = loyEventService.getMbrStoreList(reqDto);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : clearMaskingStore
	 * @date : 2019. 9. 10.
	 * @author : 2sh.kim
	 * @table :
	 * @return : LOYStoreListResponseDTO
	 * @description :스토어 거래이력 마스킹 해제
	 */
	@RequestMapping(value = "/clearMaskingStore.do", method = RequestMethod.POST)
	public @ResponseBody LoyStoreListResDto clearMaskingStore(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyStoreListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());

		return loyEventService.clearMaskingStore(reqDto);
	}

	/**
	 * @programId :
	 * @name : mbrStoreListExport
	 * @date : 2019. 9. 10.
	 * @author : 2sh.kim
	 * @table :
	 * @return : String
	 * @description :스토어 거래이력 엑셀 다운로드
	 *//*
	@RequestMapping(value = "/mbrStoreListExport.do", method = RequestMethod.POST)
	public String mbrStoreListExport(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyStoreListReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<> rtnValue = loyEventService.getMbrStoreListExport(reqDto);

		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.MBR_STORE_LIST);

		model.addAttribute("result", rtnValue);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "GLO SHOP 거래이력");

		return "iCNExcelView";
	}*/

	/*
	 * @name : attendanceList
	 * 
	 * @date : 2019. 9. 3.
	 * 
	 * @author : jh.seo
	 * 
	 * @table :
	 * 
	 * @return :
	 * 
	 * @description : 출석이벤트 이력 조회
	 */
	/*@RequestMapping(value = "/getAttendanceList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<> getAttendanceList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyAttendanceReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.getAttendanceList(reqDTO);
	}*/

	/*
	 * @name : clearMaskAttendance
	 * 
	 * @date : 2019. 9. 4.
	 * 
	 * @author : jh.seo
	 * 
	 * @table :
	 * 
	 * @return :
	 * 
	 * @description : 출석이벤트 이력 마스킹 해제
	 */
	/*@RequestMapping(value = "clearMaskAttendance.do", method = RequestMethod.POST)
	public @ResponseBody LoyAttendanceResDto clearMaskAttendance(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyAttendanceReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());
		return loyEventService.clearMaskAttendance(reqDto);
	}*/

	/*
	 * @name : excelDownAttendanceList
	 * 
	 * @date : 2019. 9. 4.
	 * 
	 * @author : jh.seo
	 * 
	 * @table :
	 * 
	 * @return :
	 * 
	 * @description : 출석이벤트 이력 리스트 엑셀다운로드
	 */
	/*@RequestMapping(value = "/excelDownAttendanceList.do", method = RequestMethod.POST)
	public String excelDownAttendanceList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyAttendanceReqDto param, ModelMap model) throws Exception {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(param.getSystemColumn());
		edlr.setTargetId(null);
		
		GridPagingResDto<> data=loyEventService.excelDownAttendanceList(param);
		
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.ATTENDANCE_TRANS);
		
		model.addAttribute("result", data);
		model.addAttribute("excelHeader", param.getExcelHeader());
		model.addAttribute("fileName", "출석이벤트 이력 리스트");
		return "iCNExcelView";
	}*/


    /**
    * @programId :
    * @name : imageViewDown
    * @date : 2019. 9. 17.
    * @author : 2sh.kim
    * @table :
    * @return : void
    * @description : 이미지 다운로드
    */
    @RequestMapping(value = "/imageViewDown")
    public Void imageViewDown(HttpServletResponse response, HttpServletRequest request) throws IOException, RequiredFieldException, FileNotFoundException,  UnsupportedEncodingException {
        // 세션 확인
        authHelper.checkUserInfo(request, response);
        
        if(StringUtil.isEmptyAll(request.getParameter("fileName"), request.getParameter("fileUrl"))) {
            String msg = "파일명 및 URL이 존재하지 않습니다.";
            LogUtil.error(msg);
            
            throw new RequiredFieldException(msg);
        }
        String oriFileName = request.getParameter("fileName");
		int pos = oriFileName.lastIndexOf('.' );	
		String ext = oriFileName.substring( pos + 1 );
        String fileName = "다운로드" + "." + ext; 
        String fileUrl = request.getParameter("fileUrl");
        LogUtil.info(fileName);
        
        fileName = URLDecoder.decode(fileName, "UTF-8");
        fileUrl = URLDecoder.decode(fileUrl, "UTF-8");
        
        fileName = SecurityUtil.chkPath(fileName.trim());
        fileUrl = SecurityUtil.chkPath(fileUrl.trim());
        
        if (!(fileUrl.toLowerCase().indexOf("http://") == 0 || fileUrl.toLowerCase().indexOf("https://") == 0)) {
            String msg = "URL이 올바르지 못합니다.";
            LogUtil.error(msg);
            
            throw new RequiredFieldException(msg);
        }
        
        // MIME Type 을 application/octet-stream 타입으로 변경
        // 무조건 팝업(다운로드창)이 뜨게 된다.
        response.setContentType( "application/download; UTF-8" );
        response.setHeader("Content-Type", "application/octet-stream");                
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");
        
        String header = request.getHeader("User-Agent");

        if (header.contains("MSIE") || header.contains("Trident")) {
            fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
        } else {
            fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        }
        
        OutputStream os = null;
        InputStream in = null;
        URL url = null;
        URLConnection uc = null;
        String type = null;
        
        try {
            url = new URL(fileUrl);
            uc = url.openConnection();
            type = uc.getContentType();
            
            // 다운로드 가능 파일 유형
            String types[] = {"application", "video", "image"};
            Boolean typecheck = false;
            
            // 다운로드 가능 유형 확인
            for (int i=0; i < types.length; i++) {
                if (type.indexOf(types[i]) != -1 ){
                    typecheck = true;
                    break;
                }
            }
            if (!typecheck) {
                String msg = "파일이 올바르지 못합니다.";
                LogUtil.error(msg);
                
                throw new RequiredFieldException(msg);
            }
            
            os = response.getOutputStream();
            in = url.openStream();
            
           if (in != null ) {
               int n = 0;
               byte[] b = new byte[1024];

               while ((n = in.read(b)) != -1) {
                   os.write(b, 0, n);
               }
           }
           //in.close();
           //os.close();
       } catch (IOException io) {
           throw io;
       } finally {
           if (in != null ) {
               try {in.close();} catch (IOException e2) {LogUtil.error(e2); in = null;}
           }
               
           if(os != null ) {
               try {os.close();} catch (IOException e3) {LogUtil.error(e3); os = null;}
           }                            
       }
        return null;
    }

	/**
	 * @programId :
	 * @name : getEventStorePreviewToken
	 * @date : 2019. 7. 17.
	 * @author : dg.ryu
	 * @table :
	 * @return : LOYEventPreviewTokenResponseDTO
	 * @description : 이벤트 스토어 미리보기 토큰 조회
	 *//*
	@RequestMapping(value = "/getEventStorePreviewToken.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPreviewTokenResDto getEventStorePreviewToken(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		return loyEventService.getEventStorePreviewToken(reqDto);
	}*/
	
	 /**
	    * @programId :
	    * @name : getStoreListRdmPoint
	    * @date : 2019. 10. 10.
	    * @author : jh.seo
	    * @table :
	    * @return : LOYStoreListResponseDTO
	    * @description : SHOP 총사용 포인트
	    *//*
	 @RequestMapping(value="/getStoreListRdmPoint.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyStoreListResDto getStoreListRdmPoint(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyStoreListReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return loyEventService.getStoreListRdmPoint(reqDto);
	    }
	 
	 *//**
	    * @programId :
	    * @name : getStoreListAcrlPoint
	    * @date : 2019. 10. 10.
	    * @author : jh.seo
	    * @table :
	    * @return : LOYStoreListResponseDTO
	    * @description : SHOP 총적립 포인트
	    *//*
	 @RequestMapping(value="/getStoreListAcrlPoint.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyStoreListResDto getStoreListAcrlPoint(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyStoreListReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(this.checkLoginSession(request, response));

	        return loyEventService.getStoreListAcrlPoint(reqDto);
	    }*/
	 
	/**
	* @programId :
	* @name : getAddPromList
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : GridPagingResDto<>
	* @description : 추가혜택 조회
	*/
	@RequestMapping(value = "/getAddPromList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyAddPromResDto> getAddPromList(HttpServletRequest request, HttpServletResponse response,
		   @RequestBody LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
	
		GridPagingResDto<LoyAddPromResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getAddPromList(reqDto);
	
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : addPromSave
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 추가혜택 등록
	*/
	@RequestMapping(value="/addPromSave.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addPromSave(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyAddPromReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.addPromSave(param);
	}
	
	/**
	* @programId :
	* @name : deleteProm
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 추가혜택 삭제
	*/
	@RequestMapping(value = "/deleteProm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.deleteProm(reqDto);

		return rtnValue;
	}

	/**
	* @programId :
	* @name : InsertLimitMbr
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 부정회원 등록
	*/
	@RequestMapping(value="/InsertLimitMbr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto InsertLimitMbr(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyLimitMbrReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.InsertLimitMbr(param);
	}
	
	/**
	* @programId :
	* @name : validLimitMbr
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 부정회원 중복체크
	*/
	@RequestMapping(value = "/validLimitMbr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto validLimitMbr(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.validLimitMbr(reqDto);

		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getLimitMbrList
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : GridPagingResDto<>
	* @description : 부정회원 조회
	*/
	@RequestMapping(value = "/getLimitMbrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyLimitMbrResDto> getLimitMbrList(HttpServletRequest request, HttpServletResponse response,
		    @RequestBody LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
	
		GridPagingResDto<LoyLimitMbrResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getLimitMbrList(reqDto);
	
		return rtnValue;
	}
	
	/**
	* @name : getPointMallPreviewToken
	* @date : 2019. 10. 21.
	* @author : dw.keum
	* @table :
	* @return : LOYEventPreviewTokenResponseDTO
	* @description :
	*//*
	@RequestMapping(value = "/getPointMallPreviewToken.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventPreviewTokenResDto getPointMallPreviewToken(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
	
		return loyEventService.getPointMallPreviewToken(reqDto);
	}*/
	
	/**
	* @programId :
	* @name : LimitMbrClearMask
	* @date : 2019. 10. 23.
	* @author : 2sh.kim
	* @table :
	* @return : LOYLimitMbrResponseDTO
	* @description : 부정등록회원 마스킹해제
	*/
	@RequestMapping(value = "/LimitMbrClearMask.do", method = RequestMethod.POST)
	public @ResponseBody LoyLimitMbrResDto LimitMbrClearMask(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());

		return loyEventService.LimitMbrClearMask(reqDto);
	}
	
	/**
	* @programId :
	* @name : terminationCancel
	* @date : 2019. 10. 23.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 부정회원 해지
	*/
	@RequestMapping(value="/terminationCancel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto terminationCancel(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyLimitMbrReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.terminationCancel(param);

		return rtnValue;
	}
		
	/**
	* @programId :
	* @name : getWinningCond
	* @date : 2019. 10. 29.
	* @author : dw.keum
	* @table :
	* @return : LOYEventWinningCondResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getWinningCond.do", method = RequestMethod.POST)
	public @ResponseBody LoyEventWinningCondResDto getWinningCond(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
			
		return loyEventService.getWinningCond(param);
	}
	
    /**
    * @programId :
    * @name : getReservPreviewToken
    * @date : 2019. 10. 22.
    * @author : jh.seo
    * @table :
    * @return : LOYReservPreviewTokenResponseDTO
    * @description : 예약서비스 미리보기 토큰 조회
    *//*
    @RequestMapping(value = "/getReservPreviewToken.do", method = RequestMethod.POST)
    public @ResponseBody LoyEventPreviewTokenResDto getReservPreviewToken(HttpServletRequest request,
            HttpServletResponse response, @RequestBody LoyEventPreviewTokenReqDto param) {
        LogUtil.param(this.getClass(), param);
    
        param.setLoginInfo(this.checkLoginSession(request, response));
        
        return loyEventService.getReservPreviewToken(param);
    }*/
    
    /**
    * @programId :
    * @name : tempUploadS3Delete
    * @date : 2019. 10. 30.
    * @author : 2sh.kim
    * @table :
    * @return : StatusResDto
    * @description : S3이미지 삭제
    *//*
    @RequestMapping(value = "/tempUploadS3Delete.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto tempUploadS3Delete(HttpServletRequest request, HttpServletResponse response
    		, @RequestBody String FileName) {
        JSONParser jsonParser = new JSONParser();
		org.json.simple.JSONObject json;
		String fileNm = null;
		try {
			json = (org.json.simple.JSONObject)jsonParser.parse(FileName);
			fileNm = (String) json.get("FileName");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return iMKTBase.deleteUploadS3(fileNm);
    }*/
    
	/**
	* @programId :
	* @name : updateEventEmg
	* @date : 2019. 10. 31.
	* @author : 2sh.kim
	* @table :
	* @return : StatusResDto
	* @description : 이미지 삭제 업데이트
	*/
	@RequestMapping(value = "/updateEventEmg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateEventEmg(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loyEventService.updateEventEmg(reqDto);

		return rtnValue;
	}
		
		/**
		* @programId :
		* @name : getAttendAcrlPoint
		* @date : 2019. 10. 29.
		* @author : jh.seo
		* @table :
		* @return : LOYAttendanceResponseDTO
		* @description : 출석이벤트 총적립 및 적립별 총액 조회
		*//*
		@RequestMapping(value = "/getAttendAcrlPoint.do", method = RequestMethod.POST)
		public @ResponseBody LOYAttendanceResDto getAttendAcrlPoint(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LOYAttendanceRequestDTO param) {
			LogUtil.param(this.getClass(), param);

			param.setLoginInfo(this.checkLoginSession(request, response));
			return loyEventService.getAttendAcrlPoint(param);
		}*/
		
		/**
		* @programId :
		* @name : getUGCList
		* @date : 2019. 11. 5.
		* @author : yj.choi
		* @table :
		* @return : GridPagingResDto<> 
		* @description : UGCList조회
		*/
		@RequestMapping(value = "/getUGCList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyUGCListResDto> getUGCList(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LoyUGCListReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));

			GridPagingResDto<LoyUGCListResDto> rtnValue = new GridPagingResDto<>();
			rtnValue = loyEventService.getUGCList(reqDto);

			return rtnValue;
		}
		
		
		/**
		* @programId :
		* @name : getUGCList
		* @date : 2019. 11. 6.
		* @author : yj.choi
		* @table :
		* @return : LOYUGCAchResponseDTO
		* @description : UGC 총 완료인원, 총 완료 스탬프, 총스탬프
		*/
		@RequestMapping(value = "/getUGCAch.do", method = RequestMethod.POST)
		public @ResponseBody LoyUGCAchResDto getUGCAch(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LoyUGCAchReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));

			LoyUGCAchResDto rtnValue = new LoyUGCAchResDto();
			rtnValue = loyEventService.getUGCAch(reqDto);

			return rtnValue;
		}
		
		/**
		 * @programId :
		 * @name : UGCMbrclearMasking
		 * @date : 2019. 11. 06.
		 * @author : yj.choi
		 * @table :
		 * @return : 
		 * @description :ugc 이력 마스킹 해제
		 */
		@RequestMapping(value = "/ugcMbrClearMasking.do", method = RequestMethod.POST)
		public @ResponseBody LoyUGCListResDto UGCMbrclearMasking(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LoyUGCListReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));
			reqDto.setUri(request.getRequestURI());
			
			return loyEventService.UGCMbrClearMasking(reqDto);
		}

		/**
		 * @programId :
		 * @name : ugcListExport
		 * @date : 2019. 11. 07.
		 * @author : yj.choi
		 * @table :
		 * @return : String
		 * @description :ugc이력 엑셀 다운로드
		 */
		@RequestMapping(value = "/ugcListExport.do", method = RequestMethod.POST)
		public String ugcListExport(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyUGCListReqDto reqDto, ModelMap model) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));

			GridPagingResDto<LoyUGCListResDto> rtnValue = loyEventService.ugcListExport(reqDto);

			ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
			edlr.setSystemColumn(reqDto.getSystemColumn());
			edlr.setTargetId(null);
			loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.MBR_UGC_LIST);

			model.addAttribute("result", rtnValue);
			model.addAttribute("excelHeader", reqDto.getExcelHeader());
			model.addAttribute("fileName", "UGC 이력");

			return "iCNExcelView";
		}
		
		/**
		* @programId :
		* @name : validLimitProm
		* @date : 2019. 11. 15.
		* @author : 2sh.kim
		* @table :
		* @return : StatusResDto
		* @description : 추가혜택 중복체크
		*/
		@RequestMapping(value = "/validLimitProm.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto validLimitProm(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyAddPromReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));

			StatusResDto rtnValue = new StatusResDto();
			rtnValue = loyEventService.validLimitProm(reqDto);

			return rtnValue;
		}
		
		/**
		* @programId :
		* @name : selectAddProm
		* @date : 2019. 11. 15.
		* @author : 2sh.kim
		* @table :
		* @return : LOYAddPromResponseDTO
		* @description : 추가혜택 조회
		*/
		@RequestMapping(value = "/selectAddProm.do", method = RequestMethod.POST)
		public @ResponseBody LoyAddPromResDto selectAddProm(HttpServletRequest request, HttpServletResponse response,
				@RequestBody  String rid) {
			String riddata =rid;
	        JSONParser jsonParser = new JSONParser();
			org.json.simple.JSONObject json;
			try {
				json = (org.json.simple.JSONObject)jsonParser.parse(riddata);
				riddata = (String) json.get("rid");
			} catch (ParseException e) {
				LogUtil.error(e.getMessage(),e);
			}
			return loyEventService.selectAddProm(riddata);
		}
		
		
		/**
		* @programId :
		* @name : updatePromSave
		* @date : 2019. 11. 15.
		* @author : 2sh.kim
		* @table :
		* @return : StatusResDto
		* @description : 추가혜택 수정
		*/
		@RequestMapping(value = "/updatePromSave.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto updatePromSave(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyAddPromReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);

			reqDto.setLoginInfo(this.checkLoginSession(request, response));

			StatusResDto rtnValue = new StatusResDto();
			rtnValue = loyEventService.updatePromSave(reqDto);

			return rtnValue;
		}
		
		/**
		* @name : getAttendAcrlJoin
		* @date : 2019. 11. 15.
		* @author : hr.noh
		* @table :
		* @return : LOYAttendanceResponseDTO
		* @description : 출석이벤트 참여횟수 및 참여인원, 비율 조회
		*//*
		@RequestMapping(value = "/getAttendAcrlJoin.do", method = RequestMethod.POST)
		public @ResponseBody LOYAttendanceResponseDTO getAttendAcrlJoin(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LOYAttendanceRequestDTO param) {
			LogUtil.param(this.getClass(), param);

			param.setLoginInfo(this.checkLoginSession(request, response));
			return loyEventService.getAttendAcrlJoin(param);
		}
		*/
		
		/**
		* @programId :
		* @name : getAttendAgeGroupCnt
		* @date : 2019. 11. 22.
		* @author : hr.noh
		* @table :
		* @return : LOYAttendanceResponseDTO
		* @description : 출석이벤트 연령별 인원 조회
		*//*
		@RequestMapping(value = "/getAttendAgeGroupCnt.do", method = RequestMethod.POST)
		public @ResponseBody LOYAttendanceResponseDTO getAttendAgeGroupCnt(HttpServletRequest request,
				HttpServletResponse response, @RequestBody LOYAttendanceRequestDTO param) {
			LogUtil.param(this.getClass(), param);

			param.setLoginInfo(this.checkLoginSession(request, response));
			LOYAttendanceResponseDTO rtnValue = loyEventService.getAttendAgeGroupCnt(param);
			return rtnValue;
		}*/
		
		/**
		* @programId :
		* @name : getAddPromCondVal
		* @date : 2019. 11. 29.
		* @author : 2sh.kim
		* @table :
		* @return : LOYAddPromResponseDTO
		* @description : 추가혜택 조건값 조회
		*/
		@RequestMapping(value = "/getAddPromCondVal.do", method = RequestMethod.POST)
		public @ResponseBody LoyAddPromResDto getAddPromCondVal(HttpServletRequest request, HttpServletResponse response,
			   @RequestBody LoyAddPromReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
			return loyEventService.getAddPromCondVal(reqDto);
		}

	/**
	* @programId :
	* @name : getApplicantCnt
	* @date : 2019. 11. 28.
	* @author : dw.keum
	* @table :
	* @return : LOYApplctRdmResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getApplicantCnt.do" , method = RequestMethod.POST)
	public @ResponseBody LoyApplctRdmResDto getApplicantCnt(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyApplctRdmReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.getApplicantCnt(param);
	}
	
	/**
	* @programId :
	* @name : getRdmWinner
	* @date : 2019. 11. 28.
	* @author : dw.keum
	* @table :
	* @return : LOYApplctRdmResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getRdmWinner.do" , method = RequestMethod.POST)
	public @ResponseBody StatusResDto getRdmWinner(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyApplctRdmReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.getRdmWinner(param);
	}
	
	/**
	* @programId :
	* @name : validCheckWinnerTrans
	* @date : 2019. 12. 2.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value = "/validCheckWinnerTrans.do" , method = RequestMethod.POST)
	public @ResponseBody StatusResDto validCheckWinnerTrans(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyApplctRdmReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(this.checkLoginSession(request, response));
		return loyEventService.validCheckWinnerTrans(param);
	}
	
	/**
	* @programId :
	* @name : InsertMbrMsg
	* @date : 2019. 12. 11.
	* @author : jh.seo
	* @table :
	* @return : StatusResDto
	* @description : 부정회원 등록 및 취소, 이벤트 당첨완료 프로시저 호출
	*/
	@RequestMapping(value="/InsertMbrMsg.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto InsertMbrMsg(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyLimitMbrReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.InsertMbrMsg(param);
	}
	
	
	 /*
	  * 1. 메소드명: getUGCList
	  * 2. 클래스명: LoyEventController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	이벤트 등급제한 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getTierLimitList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTierLimitListResDto> getTierLimitList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyUGCListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));

		GridPagingResDto<LoyTierLimitListResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = loyEventService.getTierLimitList(reqDto);

		return rtnValue;
	}
	
	@RequestMapping(value="/saveTierLimit.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveTierLimit(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyAddTierReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.saveTierLimit(param);
	}
	
	@RequestMapping(value = "/setProdEntryMultiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity setProdEntryMultiUpload(MultipartHttpServletRequest request, ModelMap param,
			HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), param);


		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil(); // 엑셀파일유틸 객체
		List<LOYProdRequestDTO> batchUpload = new ArrayList<LOYProdRequestDTO>(); // 결과물 담을 리스트객체 batchUpload
		StatusResDto rtnValue = new StatusResDto(); // 상태응답Dto객쳬
		LoginResDto loginInfo = this.checkLoginSession(request, response); // 로그인정보를 얻어낸다(create_by, modify_by를 위한) 
		LOYProdRequestDTO raDto = new LOYProdRequestDTO(); // RequestDto의 객체를 생성
		// request 객체
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
		
		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		
		// 랜덤하게 rid값을 생성
		String rid = CommonUtil.newRid();
		
		try {
			batchUpload = excelUpld.excelUploadProdList(request, false, rid); 
		} catch (Exception e) {
			LogUtil.error(e);
		}
		// 업로드한 자료의 유효성 검사(크기/양식 등)
		if (batchUpload.size() > 0) { // 크기가 0 인지
			if (batchUpload.get(0).getUploadValidCheck() != null) { // 유효성검사메소드 통과 여부
				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) { // 파일형식이 맞지 않은 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) { // size가 범위를 초과한 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) { // 업로드할 데이터가 없는 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
				}
			} else { // 유효성 검사를 무사히 통과한 경우
				raDto.setArray(batchUpload);
				raDto.setRid(rid);
				raDto.setLoginInfo(loginInfo);
				
				rtnValue = loyEventService.insertProdList(raDto);
			}
		} else { // 업로드 유형과 파일양식이 불일치하는 경우
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang())); 
		}
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", rtnValue);
		String jsonData = "";
		
		try {
			jsonData = new ObjectMapper().writeValueAsString(map);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");
		
		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
	}

	

	 /*
	  * 1. 메소드명: isThereWinnerInApplicant
	  * 2. 클래스명: LoyEventController
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 03. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 : 해당 이벤트의 참여자들 중, 당첨자가 현재 있는지 체크	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/isThereWinnerInApplicant.do", method = RequestMethod.POST)
	public @ResponseBody List<LoyEvtApplctResDto> isThereWinnerInApplicant(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEvtApplctReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(this.checkLoginSession(request, response));
		
		return loyEventService.isThereWinnerInApplicant(param);
	}
	
}
