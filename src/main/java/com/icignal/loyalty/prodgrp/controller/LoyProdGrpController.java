/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpController.java
 * 2. Package	: com.icignal.loyalty.prodgrp.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 5:29:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.controller;

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
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.loyalty.prodgrp.dto.request.LoyCategoryGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpDetailReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpDetailResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpItemListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpListResDto;
import com.icignal.loyalty.prodgrp.mapper.LoyProdGrpService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: LoyProdGrpController
 * 2. 파일명	: LoyProdGrpController.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/prodgrp")
public class LoyProdGrpController extends BaseController{
	
	@Autowired
	private LoyProdGrpService loyProdGrpService;

	@Autowired
	private AuthHelper authHelper;
	
	@RequestMapping(value="/getProdGrpList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyProdGrpListResDto> getProdGrpList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.getProdGrpList(bccr);
	}
	
	@RequestMapping(value="/getProdGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	LoyProdGrpDetailResDto getProdGrpDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.getProdGrpDetail(bccr);
	}
	
	@RequestMapping(value="/saveProdGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveProdGrpDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.saveProdGrpDetail(bccr);
	}
	
	@RequestMapping(value="/modifyProdGrpDetail.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto modifyTgtDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.modifyProdGrpDetail(bccr);
	}
	
	@RequestMapping(value="/getProdItemList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyProdGrpItemListResDto> getProdItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.getProdItemList(bccr);
	}
	
	@RequestMapping(value="/removeProdItem.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeProdItem(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.removeProdItem(bccr);
	}
	
	@RequestMapping(value="/removeAllTProdItem.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeAllTProdItem(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.removeAllTProdItem(bccr);
	}
	
	@RequestMapping(value = "/uploadExcelProdGrpXm.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity  uploadExcelProdGrpXm(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {	
		//this.checkLoginSession(request.getSession(true));
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
 		List<LoyProdGrpListReqDto> batchUpload = new ArrayList<LoyProdGrpListReqDto>();
 		StatusResDto rtnValue = new StatusResDto();
 		LoginResDto loginInfo = this.checkLoginSession(request, response);
 		LoyProdGrpListReqDto br = new LoyProdGrpListReqDto();
 		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
 		
 		String[] rs = mptRequest.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String prodGrpRid = (String) obj.get("prodGrpRid");
 		
 		String rid = CommonUtil.newRid();
 		
 		try {
			batchUpload = excelUpld.excelUploadProdGrpXm( request, false, rid);
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
 				br.setProdGrpRid(prodGrpRid);
 				//br.setRidBrdCat(ridBrdCat);
 				br.setLoginInfo(loginInfo);
 				
  	 	 		rtnValue = loyProdGrpService.insertProdList(br);
  	 	 		//rtnValue.setMessage("저장되었습니다.");
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
	
	@RequestMapping(value="/addProdItem.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto addProdItem(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.addProdItem(bccr);
	}
	
	@RequestMapping(value = "/prodGrpXmExcelList.do", method = RequestMethod.POST)
	public String prodGrpXmExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyProdGrpItemListResDto> data = loyProdGrpService.getProdItemList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "상품 목록");

		return "ExcelView";
	}
	
	@RequestMapping(value = "/cateogoryGrpXmExcelList.do", method = RequestMethod.POST)
	public String cateogoryGrpXmExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyCategoryListResDto> data = loyProdGrpService.getCategoryList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "카테고리 목록");

		return "ExcelView";
	}
	
	@RequestMapping(value="/getCategoryList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyCategoryListResDto> getCategoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.getCategoryList(bccr);
	}
	
	@RequestMapping(value = "/uploadExcelCategory.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity  uploadExcelCategory(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {	
		//this.checkLoginSession(request.getSession(true));
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
 		List<LoyCategoryGrpListReqDto> batchUpload = new ArrayList<LoyCategoryGrpListReqDto>();
 		StatusResDto rtnValue = new StatusResDto();
 		LoginResDto loginInfo = this.checkLoginSession(request, response);
 		LoyCategoryGrpListReqDto br = new LoyCategoryGrpListReqDto();
 		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
 		
 		String[] rs = mptRequest.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String prodGrpRid = (String) obj.get("prodGrpRid");
 		
 		String rid = CommonUtil.newRid();
 		
 		try {
 			batchUpload = excelUpld.excelUploadCategory( request, false, rid);
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
 				br.setProdGrpRid(prodGrpRid);
 				//br.setRidBrdCat(ridBrdCat);
 				br.setLoginInfo(loginInfo);
 				
  	 	 		rtnValue = loyProdGrpService.insertCategoryList(br);
  	 	 		//rtnValue.setMessage("저장되었습니다.");
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
	
	@RequestMapping(value="/removeCategory.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeCategory(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.removeCategory(bccr);
	}
	
	@RequestMapping(value="/removeAllTCategory.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeAllTCategory(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.removeAllTCategory(bccr);
	}
	
	@RequestMapping(value="/addCategory.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto addCategory(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCategoryGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.addCategory(bccr);
	}
	
	@RequestMapping(value="/removeProdGrp.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeProdGrp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.removeProdGrp(bccr);
	}

	@RequestMapping(value="/getProdListItemPop.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyProdGrpItemListResDto> getProdListItemPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		LoginResDto loginInfo = this.checkLoginSession(request, response);
		bccr.setLoginInfo(loginInfo);

		return loyProdGrpService.getProdListItemPop(bccr);
	}
	
	@RequestMapping(value = "/getGiftsPopList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProdGrpItemListResDto> getGiftsPopList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody LoyProdGrpListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProdGrpService.getGiftsPopList(slr);
	}
	
}
