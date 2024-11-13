/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpController.java
 * 2. Package	: com.icignal.loyalty.targetgrp.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 2:40:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.controller;

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
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpDetailReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpListReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTgtGrpXmListReqDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpDetailResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpListResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpXmListResDto;
import com.icignal.loyalty.targetgrp.service.LoyTargetGrpService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: LoyTargetGrpController
 * 2. 파일명	: LoyTargetGrpController.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/targetgrp")
public class LoyTargetGrpController extends BaseController{
	
	@Autowired
	private LoyTargetGrpService loyTargetGrpService;

	
	
	@RequestMapping(value="/getTargetGrpList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyTargetGrpListResDto> getTargetGrpList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.getTargetGrpList(bccr);
	}
	
	@RequestMapping(value="/getTgtGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyTargetGrpDetailResDto getTgtGrpDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.getTgtGrpDetail(bccr);
	}
	
	@RequestMapping(value="/saveTgtDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyTargetGrpResDto saveTgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.saveTgtDetail(bccr);
	}
	
	@RequestMapping(value="/modifyTgtDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto modifyTgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.modifyTgtDetail(bccr);
	}
	
	@RequestMapping(value="/getTgtGrpXmList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyTargetGrpXmListResDto> getTgtGrpXmList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.getTgtGrpXmList(bccr);
	}
	
	@RequestMapping(value="/removeTgtGrpXm.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeTgtGrpXm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.removeTgtGrpXm(bccr);
	}
	
	@RequestMapping(value="/removeAllTgtGrpXm.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeAllTgtGrpXm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.removeAllTgtGrpXm(bccr);
	}
	
	@RequestMapping(value = "/uploadExcelTgtGrpXm.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity  uploadExcelTgtGrpXm(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {	
		//this.checkLoginSession(request.getSession(true));
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
 		List<LoyTgtGrpXmListReqDto> batchUpload = new ArrayList<LoyTgtGrpXmListReqDto>();
 		StatusResDto rtnValue = new StatusResDto();
 		LoginResDto loginInfo = this.checkLoginSession(request, response);
 		LoyTgtGrpXmListReqDto br = new LoyTgtGrpXmListReqDto();
 		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
 		
 		String[] rs = mptRequest.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String tgtGrpRid = (String) obj.get("tgtGrpRid");
 		
 		String rid = CommonUtil.newRid();
 		
 		try {
			batchUpload = excelUpld.excelUploadTgtGrpXm( request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}
 		if(batchUpload.size()>0){
 			if(batchUpload.get(0).getUploadValidCheck()!=null){
 				if(batchUpload.get(0).getUploadValidCheck().equals("EXT")){
 	 	 			rtnValue.setSuccess(false);
 	 		    	rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

 	 			}else if(batchUpload.get(0).getUploadValidCheck().equals("SIZE")){
 	 	 			rtnValue.setSuccess(false);
 	 	 			rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
 	 			}else if(batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")){
	 	 			rtnValue.setSuccess(false);
	 	 			rtnValue.setMessage("업로드 할 데이터가 없습니다.");
	 			}
 			}else{
 				br.setArray(batchUpload);
 				br.setRid(rid);
 				br.setTgtGrpRid(tgtGrpRid);
 				//br.setRidBrdCat(ridBrdCat);
 				br.setLoginInfo(loginInfo);
 				
  	 	 		rtnValue = loyTargetGrpService.insertProdList(br);
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
	
	@RequestMapping(value="/removeTgtGrp.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeTgtGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyTargetGrpService.removeTgtGrp(bccr);
	}
	
}
