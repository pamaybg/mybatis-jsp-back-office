/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyVocController.java
 * 2. Package	: com.icignal.voc.requestConsultation.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 7. 오전 10:05:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.voc.requestConsultation.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryMsgReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRecordFileListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetReplyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRgstCardListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetTransactionListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocModifyRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetActyHistoryReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryMsgResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRecordFileListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetReplyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRgstCardListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetTransactionListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationExcelListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationResDto;
import com.icignal.loyalty.voc.requestConsultation.service.LoyVocService;


/*
 * 1. 클래스명	: LoyVocController
 * 2. 파일명	: LoyVocController.java
 * 3. 패키지명	: com.icignal.voc.requestConsultation.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/voc/requestConsultation")
public class LoyVocController extends BaseController{
	
	@Autowired
	private LoyVocService loyVocService;
	
	@Autowired
	private AuthHelper authHelper;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
			HttpServletResponse response,Model model) {
		LogUtil.info("NavigatePopMenu start.....");
		
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		//Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;
		
		//checkProgramAuth(respUrl, request ,response , model);
		
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}
	
	/*@Autowired
	private loyVocService loyVocService;*/
	
	/**
	 * @name : getCommCodeList
	 * @date : 2015. 9. 22.
	 * @author : 류동균
	 * @description : 컴코드 목록 조회
	 */
	/*@RequestMapping(value="/getCommCodeList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<> getCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);
		return loyVocService.getCommCodeList(bccr);

	}*/


	/**
	 * @name : getConsultList
	 * @date : 2017. 10. 16.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @throws Exception
	 * @description : 상담요청 목록 조회
	 */
	@RequestMapping(value="/getConsultList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<VocRequestConsultationListResDto> getConsultList(HttpServletRequest request, HttpServletResponse response, @RequestBody VocRequestConsultationListReqDto bccr) throws Exception {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getConsultList(bccr);
	}

	/**
	 * @name : getConsultDetail
	 * @date : 2017. 10. 16.
	 * @author : jun.lee
	 * @return : VOCRequestConsultationResponseDTO
	 * @description : 상담요청 상세 조회
	 */
	@RequestMapping(value="/getConsultDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	VocRequestConsultationResDto getConsultDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody VocRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyVocService.getConsultDetail(bccr);
	}

	/**
	 * @name : getActyHistoryList
	 * @date : 2017. 10. 17.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @description : 활동내역 목록 조회
	 */
	@RequestMapping(value="/getActyHistoryList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<VocGetActyHistoryListResDto> getActyHistoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetActyHistoryListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyVocService.getActyHistoryList(bccr);
	}

	/**
	 * @name : getTransactionListByRidMbr
	 * @date : 2017. 10. 17.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @description : 포인트거래 목록 조회
	 */
	@RequestMapping(value="/getTransactionListByRidMbr.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<VocGetTransactionListResDto> getTransactionListByRidMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetTransactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyVocService.getTransactionListByRidMbr(bccr);
	}


	/**
	 * @programId :
	 * @name : getRgstCardListByRidMbr
	 * @date : 2018. 1. 27.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @description : 포인트카드 목록 조회
	 */
	@RequestMapping(value="/getRgstCardListByRidMbr.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<VocGetRgstCardListResDto> getRgstCardListByRidMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetRgstCardListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyVocService.getRgstCardListByRidMbr(bccr);
	}

	/**
	 * @name : setActyHistory
	 * @date : 2017. 10. 18.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 활동내역 추가
	 */
	@RequestMapping(value="/setActyHistory.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setActyHistory(HttpServletRequest request, HttpServletResponse response, @RequestBody VocSetActyHistoryReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);

		bccr.setEmpId(loginInfo.getId());

		return loyVocService.setActyHistory(bccr);
	}

	/**
	 * @name : modifyRequestConsultation
	 * @date : 2017. 10. 18.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 상담요청 상세 수정
	 */
	@RequestMapping(value="/modifyRequestConsultation.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto modifyRequestConsultation(HttpServletRequest request, HttpServletResponse response, @RequestBody VocModifyRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		bccr.setEmpId(loginInfo.getId());

		return loyVocService.modifyRequestConsultation(bccr);
	}

	/**
	 * @name : setRequestConsultation
	 * @date : 2017. 10. 19.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 상담요청 신규
	 */
	@RequestMapping(value="/setRequestConsultation.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setRequestConsultation(HttpServletRequest request, HttpServletResponse response, @RequestBody VocSetRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		bccr.setEmpId(loginInfo.getId());
		bccr.setUserId(loginInfo.getUserId());

		return loyVocService.setRequestConsultation(bccr);
	}


	/**
	 * @name : getRecordFileListForNexus
	 * @date : 2017. 11. 30.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @description : NEXUS 녹취청취 목록 조회
	 */
	@RequestMapping(value="/getRecordFileListForNexus.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto getRecordFileListForNexus(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getRecordFileListForNexus(bccr);
	}


	/**
	 * @name : getPbxRecordFileListForNexus
	 * @date : 2018. 2. 5.
	 * @author : jun.lee
	 * @return : GridPagingResDto<>
	 * @description : NEXUS 녹취청취 목록 조회(PBX callId 인 경우)
	 */
	@RequestMapping(value="/getPbxRecordFileListForNexus.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto getPbxRecordFileListForNexus(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getPbxRecordFileListForNexus(bccr);
	}

	/**
	 * @name : getRecordFileListForCCA
	 * @date : 2017. 12. 19.
	 * @author : jun.lee
	 * @return : VOCGetRecordFileListResponseDTO
	 * @description : CCA 녹취청취 목록 조회
	 */
	@RequestMapping(value="/getRecordFileListForCCA.do", method = RequestMethod.POST)
	public @ResponseBody
	VocGetRecordFileListResDto getRecordFileListForCCA(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getRecordFileListForCCA(bccr);
	}


	/**
	 * @name : modifyActyHistory
	 * @date : 2018. 1. 4.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 활동내역 이메일 또는 SMS 발송 후, 활동내역 수정
	 */
	@RequestMapping(value="/modifyActyHistory.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto modifyActyHistory(HttpServletRequest request, HttpServletResponse response, @RequestBody VocSetActyHistoryReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);

		bccr.setEmpId(loginInfo.getId());

		return loyVocService.modifyActyHistory(bccr);
	}


	/**
	 * @name : getCtiRecordUrl
	 * @date : 2018. 1. 23.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : CTI NEXUS 녹취청취 URL 정보 호출
	 */
	@RequestMapping(value="/getCtiRecordUrl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto getCtiRecordUrl(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetRecordFileListReqDto bccr) {
		LogUtil.info("VOCRequestConsultationController");

		this.checkLoginSession(request, response);

		return loyVocService.getCtiRecordUrl(bccr);
	}


	/**
	 * @name : getActyHistoryMsg
	 * @date : 2018. 3. 19.
	 * @author : jun.lee
	 * @return : VOCGetActyHistoryMsgResponseDTO
	 * @description : 활동이력 > 활동내역 메시지 조회
	 */
	@RequestMapping(value="/getActyHistoryMsg.do", method = RequestMethod.POST)
	public @ResponseBody
	VocGetActyHistoryMsgResDto getActyHistoryMsg(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetActyHistoryMsgReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getActyHistoryMsg(bccr);
	}
	
	/**
	 * @name : getActyHistoryMsg
	 * @date : 2018. 3. 19.
	 * @author : jun.lee
	 * @return : VOCGetActyHistoryMsgResponseDTO
	 * @description : 활동이력 > 마스킹 해제
	 */
	@RequestMapping(value="/getConsultMasking.do", method = RequestMethod.POST)
	public @ResponseBody
	VocRequestConsultationResDto getConsultMasking(HttpServletRequest request, HttpServletResponse response, @RequestBody VocRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		this.checkLoginSession(request, response);

		return loyVocService.getConsultMasking(bccr);
	}
	
	@RequestMapping(value="/consultExcelDown.do", method = RequestMethod.POST)
	public String consultExcelDown(HttpServletRequest request, HttpServletResponse response, 
		@RequestBody VocRequestConsultationListReqDto reqDto, ModelMap model) throws Exception {
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
		
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.VOC_LIST,reqDto.getStrCondWhere()+reqDto.getStrWhere());
		
		GridPagingResDto<VocRequestConsultationExcelListResDto> data = loyVocService.getConsultMaskList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "상담내역 목록");

		return "ExcelView";
	}
	
	/**
	 * @name : getReplyHistoryList
	 * @date : 2021. 02. 17.
	 * @author : 2sh.park
	 * @return : GridPagingResDto<>
	 * @description : 답변내용 목록 조회
	 */
	@RequestMapping(value="/getReplyHistoryList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<VocGetReplyHistoryListResDto> getReplyHistoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody VocGetReplyHistoryListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		bccr.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyVocService.getReplyHistoryList(bccr);
	}

}
