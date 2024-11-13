/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpController.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오후 4:51:23
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpDetailReqDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpDetailResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpItemListResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpListResDto;
import com.icignal.loyalty.chnlgrp.service.LoyChnlGrpService;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: LoyChnlGrpController
 * 2. 파일명	: LoyChnlGrpController.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/chnlgrp")
public class LoyChnlGrpController extends BaseController {
	@Autowired
	private LoyChnlGrpService LoyChnlGrpService;

	@Autowired
	private AuthHelper authHelper;

	@RequestMapping(value = "/getChnlGrpList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlGrpListResDto> getChnlGrpList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.getChnlGrpList(bccr);
	}

	@RequestMapping(value = "/getChnlGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlGrpDetailResDto getChnlGrpDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.getChnlGrpDetail(bccr);
	}

	@RequestMapping(value = "/saveChnlGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChnlGrpDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.saveChnlGrpDetail(bccr);
	}

	@RequestMapping(value = "/modifyChnlGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyChnlGrpDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.modifyChnlGrpDetail(bccr);
	}

	@RequestMapping(value = "/getChnlItemList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlGrpItemListResDto> getChnlItemList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.getChnlItemList(bccr);
	}

	@RequestMapping(value = "/removeChnlItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.removeChnlItem(bccr);
	}

	@RequestMapping(value = "/removeAllTChnlItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeAllTChnlItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.removeAllTChnlItem(bccr);
	}

	@RequestMapping(value = "/uploadExcelChnlGrpXm.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity uploadExcelChnlGrpXm(MultipartHttpServletRequest request, ModelMap model,
			HttpServletResponse response) throws IOException {
		// this.checkLoginSession(request.getSession(true));

		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil();
		List<LoyChnlGrpListReqDto> batchUpload = new ArrayList<LoyChnlGrpListReqDto>();
		StatusResDto rtnValue = new StatusResDto();
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		LoyChnlGrpListReqDto br = new LoyChnlGrpListReqDto();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String chnlGrpRid = (String) obj.get("chnlGrpRid");

		String rid = CommonUtil.newRid();

		try {
			batchUpload = excelUpld.excelUploadChnlGrpXm(request, false, rid);
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
				br.setChnlGrpRid(chnlGrpRid);
				// br.setRidBrdCat(ridBrdCat);
				br.setLoginInfo(loginInfo);

				rtnValue = LoyChnlGrpService.insertChnlList(br);
				// rtnValue.setMessage("저장되었습니다.");
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

	@RequestMapping(value = "/addChnlItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addChnlItem(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.addChnlItem(bccr);
	}

	@RequestMapping(value = "/chnlGrpXmExcelList.do", method = RequestMethod.POST)
	public String chnlGrpXmExcelList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyChnlGrpItemListResDto> data = LoyChnlGrpService.getChnlItemList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "채널이력 목록");

		return "ExcelView";
	}

	@RequestMapping(value = "/removeChnlGrp.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlGrp(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.removeChnlGrp(bccr);
	}

	@RequestMapping(value = "/addChnlExc.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addChnlExc(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.addChnlExc(bccr);
	}

	@RequestMapping(value = "/removeChnlExc.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlExc(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.removeChnlExc(bccr);
	}

	@RequestMapping(value = "/removeAllTChnlExc.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeAllTChnlExc(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.removeAllTChnlExc(bccr);
	}

	@RequestMapping(value = "/getChnlExcList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlGrpItemListResDto> getChnlExcList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return LoyChnlGrpService.getChnlExcList(bccr);
	}
}
