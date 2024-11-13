/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCardMasterController.java
 * 2. Package	: com.icignal.loyalty.membershipcard.cardmaster.controller
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 6. 오전 10:50:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmaster.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardBinReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardNoPoolReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardTypeReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyIssuedCardReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardBinResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardNoPoolResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardTypeResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import com.icignal.loyalty.membershipcard.cardmaster.service.LoyCardMasterService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/*
 * 1. 클래스명	: LoyCardMasterController
 * 2. 파일명	: LoyCardMasterController.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.cardmaster.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/membership/card")
public class LoyCardMasterController extends BaseController{
	
	@Autowired
	private LoyCardMasterService loyCardMasterService;
	
	@Autowired
	private AuthHelper authHelper;
    
    @Autowired
    private CommonService commonService;

	@RequestMapping(value = "/getCardTypeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCardTypeResDto> getCardTypeList(HttpServletRequest request, HttpServletResponse response,
																			 @RequestBody LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getCardTypeList(reqDto);
	}

	@RequestMapping(value = "/getCardTypeDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCardTypeResDto getCardTypeDetail(HttpServletRequest request, HttpServletResponse response,
										@RequestBody LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getCardTypeDetail(reqDto);
	}

	@RequestMapping(value = "/editCardType.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCardType(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.editCardType(reqDto);
	}

	@RequestMapping(value = "/setCardType.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCardType(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.setCardType(reqDto);
	}

	@RequestMapping(value = "/getIssuedCardList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyIssuedCardResDto> getCardListTab(HttpServletRequest request, HttpServletResponse response,
																			  @RequestBody LoyIssuedCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getIssuedCardList(reqDto);
	}

	 /*
	  * 1. 메소드명: getCardBinHistList
	  * 2. 클래스명: LoyCardMasterController
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	@RequestMapping(value = "/getCardBinList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCardBinResDto> getCardBinList(HttpServletRequest request, HttpServletResponse response,
																		   @RequestBody LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getCardBinList(reqDto);
	}

	@RequestMapping(value = "/getCardBinDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyCardBinResDto getCardTypeDetail(HttpServletRequest request, HttpServletResponse response,
									   @RequestBody LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getCardBinDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveCardBin
	  * 2. 클래스명: LoyCardMasterController
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	@RequestMapping(value = "/saveCardBin.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCardBin(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.saveCardBin(reqDto);
	}

	 /*
	  * 1. 메소드명: removeCardBinHist
	  * 2. 클래스명: LoyCardMasterController
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2020. 7. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	@RequestMapping(value = "/removeCardBin.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCardBinHist(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.removeCardBin(reqDto);
	}
	
	@RequestMapping(value = "/getCardNoPoolList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCardNoPoolResDto> getCardNoPoolList(HttpServletRequest request, HttpServletResponse response,
																				 @RequestBody LoyCardNoPoolReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.getCardNoPoolList(reqDto);
	}

	@RequestMapping(value = "/genCardNo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto genCardNo(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyCardNoPoolReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCardMasterService.genCardNo(reqDto);
	}

	@RequestMapping(value = "/uploadCardNo.do", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity  uploadCardNo(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), "");

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
		LoyCardNoPoolReqDto reqDto = new LoyCardNoPoolReqDto();
 		StatusResDto rtnValue = new StatusResDto();
 		
 		String[] rs = request.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		
 		// xss 문자열 변환(복구)
 		ns = StringUtil.toWEB_BOX2(ns);
 		
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String rid = commonService.getRowID();
 		
 		try {
			reqDto = excelUpld.excelUploadCardNoPool(request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}
 		
 		if (reqDto.getPoolList().size() > 0) {
 			if (reqDto.getUploadValidCheck()!=null) {
 				if (reqDto.getUploadValidCheck().equals("EXT")) {
 	 	 			rtnValue.setSuccess(false);
 	 		    	rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
 	 			} else if (reqDto.getUploadValidCheck().equals("SIZE")) {
 	 	 			rtnValue.setSuccess(false);
 	 	 			rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
 	 			} else if (reqDto.getUploadValidCheck().equals("NOTUPLD")) {
	 	 			rtnValue.setSuccess(false);
	 	 			rtnValue.setMessage("업로드 할 데이터가 없습니다.");
	 			}
 			} else {
 		 		reqDto.setLoginInfo(loginInfo);
 		 		reqDto.setRidCardKind(obj.getString("ridCardKind"));

  	 	 		rtnValue = loyCardMasterService.uploadCardNo(reqDto);
  			}
  		}else{
  			rtnValue.setSuccess(false);
	    	rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
  		}
 		
 		HashMap<String, Object> map  = new HashMap<String, Object>();
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
	
	@Transactional(readOnly=true)
	@RequestMapping(value = "/exportExcelCardNoPool.do", method = RequestMethod.POST)
	public String exportExcelCardNoPool(HttpServletRequest request, HttpServletResponse response,
										@RequestBody LoyCardNoPoolReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyCardNoPoolResDto> data = loyCardMasterService.getCardNoPoolListForExcelExport(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "카드 번호");

		return "ExcelView";
	}

}
