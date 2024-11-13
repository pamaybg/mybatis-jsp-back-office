package com.icignal.offer.controller;

import java.io.IOException;
import java.util.HashMap;

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
import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.Messages;
import com.icignal.offer.dto.request.CouponDtlReqDto;
import com.icignal.offer.dto.request.CouponGuideListReqDto;
import com.icignal.offer.dto.request.CouponGuideReqDto;
import com.icignal.offer.dto.request.CouponReqDto;
import com.icignal.offer.dto.request.OfferCouponPoolReqDto;
import com.icignal.offer.dto.request.OfferCpnPoolListCondReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlItemReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlReqDto;
import com.icignal.offer.dto.request.OfferJoinPgmReqDto;
import com.icignal.offer.dto.request.OfferJoinProdReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.CouponDtlResDto;
import com.icignal.offer.dto.response.CouponGuideResDto;
import com.icignal.offer.dto.response.CouponHistResDto;
import com.icignal.offer.dto.response.CouponResDto;
import com.icignal.offer.dto.response.OfferCouponPoolResDto;
import com.icignal.offer.dto.response.OfferCpnPoolListCondResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;
import com.icignal.offer.dto.response.OfferJoinChnlResDto;
import com.icignal.offer.dto.response.OfferJoinPgmResDto;
import com.icignal.offer.dto.response.OfferJoinProdResDto;
import com.icignal.offer.dto.response.OfferResDto;
import com.icignal.offer.service.OfferService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: OfferController
 * 2. 파일명	: OfferController.java
 * 3. 패키지명	: com.icignal.loyalty.membership.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/offer")

public class OfferController extends BaseController{

	
	@Autowired
	private OfferService offerService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Autowired
    private LoggingHelper loggingHelper;
	
	@Autowired
    private CommonService commonService;
	
	@RequestMapping(value = "/getOfferList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferResDto> getOfferList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getOfferList(slr);
	}

	@RequestMapping(value = "/getOfferDetail.do", method = RequestMethod.POST)
	public @ResponseBody OfferResDto getOfferDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getOfferDetail(slr);
	}
	
	@RequestMapping(value = "/addOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertOffer(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/editOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.updateOffer(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOffer(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/getCouponDetail.do", method = RequestMethod.POST)
	public @ResponseBody CouponDtlResDto getCouponDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CouponDtlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		CouponDtlResDto rtnValue = offerService.getCouponDetail(slr);

		return rtnValue;
	}
	
	
	@RequestMapping(value = "/editCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCoupon(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CouponDtlReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.updateCoupon(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/getOfferJoinPgmList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferJoinPgmResDto> getOfferJoinPgmList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferJoinPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getOfferJoinPgmList(slr);
	}
	
	@RequestMapping(value = "/addOfferJoinPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addOfferJoinPgm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertOfferJoinPgm(slr);

		return rtnValue;
	}
	

	@RequestMapping(value = "/addCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCoupon(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CouponDtlReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertCoupon(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/getCouponExtAttr.do", method = RequestMethod.POST)
	public @ResponseBody CouponResDto getCouponExtAttr(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		CouponResDto rtnValue = offerService.getCouponExtAttr(slr);
		return rtnValue;
	}

	@RequestMapping(value = "/removeOfferJoinPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferJoinPgm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinPgm(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/getCpnStatusList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<CouponHistResDto> getCpnStatusList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getCpnStatusList(slr);
	}


	@RequestMapping(value = "/editCoupGuide.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCoupGuide(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponGuideReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.editCoupGuide(slr);
	}
	
	@RequestMapping(value = "/insertCpnAttr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertCpnAttr(HttpServletRequest request, HttpServletResponse response, @RequestBody CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertCpnAttr(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/updateCpnAttr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCpnAttr(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.updateCpnAttr(slr);
	}
	
	
	@RequestMapping(value = "/getCouponChk.do", method = RequestMethod.POST)
	public @ResponseBody CouponResDto chkIsCoupon(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getCouponChk(slr);
	}
	
	@RequestMapping(value = "/addCouponGuide.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCouponGuide(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponGuideReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.addCouponGuide(slr);
	}
	
	@RequestMapping(value = "/getCouponGuide.do", method = RequestMethod.POST)
	public @ResponseBody CouponGuideResDto getCouponGuide(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getCouponGuide(slr);
	}
	
	@RequestMapping(value = "/updateCouponGuide.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateCouponGuide(HttpServletRequest request,HttpServletResponse response, @RequestBody CouponGuideReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.updateCouponGuide(slr);
	}
	
	@RequestMapping(value = "/getOfferJoinChnlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferJoinChnlResDto> getOfferJoinChnlList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferJoinChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.getOfferJoinChnlList(slr);
	}
	
	@RequestMapping(value = "/addOfferJoinChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addOfferJoinChnl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertOfferJoinChnl(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOfferJoinChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferJoinChnl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinChnl(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOfferJoinAllChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeOfferJoinAllChnl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinChnlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinAllChnl(slr);
		return rtnValue;
	}
	
	@RequestMapping(value="/exportExcelOfferJoinChnlTargetList.do", method = RequestMethod.POST)
    public String exportExcelOfferJoinChnlTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody OfferJoinChnlReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
		
		// 데이터 조회
		GridPagingResDto data = offerService.getOfferJoinChnlList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "사용 가능채널 리스트");

		return "ExcelView";
    }
		
	@RequestMapping(value = "/setOfferJoinChnlUpload.do", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity  setOfferJoinChnlUpload(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), "");
		
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
		OfferJoinChnlItemReqDto reqDto = new OfferJoinChnlItemReqDto();
 		StatusResDto rtnValue = new StatusResDto();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

 		String[] rs = mptRequest.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
 		// xss 문자열 변환(복구)
 		ns = StringUtil.toWEB_BOX2(ns);
 		
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String rid = commonService.getRowID();
 		
 		try {
 			reqDto = excelUpld.excelUploadOfferJoinChnl( request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}
 		
 		if (reqDto.getItemList().size()>0) {
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
 		 		reqDto.setTargetOfferId((String) obj.get("ridOfr"));
  	 	 		rtnValue = offerService.addOfferJoinChnlItem(reqDto);
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
	
	
	@RequestMapping(value = "/setOfferJoinProdUpload.do", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity  setOfferJoinProdUpload(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), "");
		
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
		OfferJoinChnlItemReqDto reqDto = new OfferJoinChnlItemReqDto();
 		StatusResDto rtnValue = new StatusResDto();
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

 		String[] rs = mptRequest.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
 		// xss 문자열 변환(복구)
 		ns = StringUtil.toWEB_BOX2(ns);
 		
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String rid = commonService.getRowID();
 		
 		try {
 			reqDto = excelUpld.excelUploadOfferJoinProd( request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}
 		
 		if (reqDto.getItemList().size()>0) {
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
 		 		reqDto.setTargetOfferId((String) obj.get("ridOfr"));
 		 		reqDto.setProdUseType((String) obj.get("prodUseType"));
  	 	 		rtnValue = offerService.addOfferJoinProdItem(reqDto);
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


	@RequestMapping(value = "/getOfferJoinProdList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferJoinProdResDto> getOfferJoinProdList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.getOfferJoinProdList(slr);
	}
	
	@RequestMapping(value = "/getOfferJoinProdNotList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferJoinProdResDto> selectOfferJoinProdNotUsedList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.selectOfferJoinProdNotUsedList(slr);
	}
	
	@RequestMapping(value = "/addOfferJoinProd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addOfferJoinProd(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.insertOfferJoinProd(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOfferJoinProd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferJoinProd(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinProd(slr);
		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOfferJoinAllProd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferJoinAllProd(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinAllProd(slr);
		return rtnValue;
	}
	@RequestMapping(value = "/removeOfferJoinNotAllProd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferJoinNotAllProd(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferJoinProdReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerService.deleteOfferJoinNotAllProd(slr);
		return rtnValue;
	}
	
	@RequestMapping(value="/exportExcelOfferJoinProdTargetList.do", method = RequestMethod.POST)
    public String exportExcelOfferJoinProdTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody OfferJoinProdReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
		
		// 데이터 조회
		GridPagingResDto data = offerService.getOfferJoinProdList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "사용 가능상품 리스트");

		return "ExcelView";
    }
	
	@RequestMapping(value="/exportExcelOfferJoinNotProdTargetList.do", method = RequestMethod.POST)
    public String exportExcelOfferJoinNotProdTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody OfferJoinProdReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
		
		// 데이터 조회
		GridPagingResDto data = offerService.selectOfferJoinProdNotUsedList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "사용 불가능상품 리스트");

		return "ExcelView";
    }
	
	@RequestMapping(value = "/getChildOfferGroupList.do", method = RequestMethod.POST )
	public @ResponseBody GridPagingResDto<OfferGroupResDto> getChildOfferGroupList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferGroupReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getOfferGroupList(slr);
	}
	
	@RequestMapping(value = "/getOfferCouponPoolList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferCouponPoolResDto> getOfferCpnPoolList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferCouponPoolReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.getOfferCouponPoolList(slr);
	}
	
	@RequestMapping(value="/exportExcelOfferCpnPoolList.do", method = RequestMethod.POST)
    public String exportExcelOfferCpnPoolTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody OfferCouponPoolReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
		
		// 데이터 조회
		GridPagingResDto data = offerService.getOfferCouponPoolList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "사용 가능채널 리스트");

		return "ExcelView";
    }
	
	@RequestMapping(value = "/getOfferCpnPoolListCond.do", method = RequestMethod.POST)
	public @ResponseBody OfferCpnPoolListCondResDto getOfferCpnPoolListCond(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferCpnPoolListCondReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		return offerService.getOfferCpnPoolListCond(slr);
	}
	
	 /*
	  * 1. 메소드명: ofrCuponStatusExcelDownload
	  * 2. 클래스명: OfferController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		쿠폰발급 현황 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/ofrCuponStatusExcelDownload.do", method = RequestMethod.POST)
	public String ofrCuponStatusExcelDownload(HttpServletRequest request, HttpServletResponse response, @RequestBody CouponReqDto reqDto , ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		GridPagingResDto<CouponHistResDto>  data = offerService.getCpnStatusList(reqDto);
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.OFR_CUPON_STATUS_LIST);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "쿠폰발급현황 리스트");

		return "ExcelView";
	}
	
	 /*
	  * 1. 메소드명: modifyOfferJoinPgm
	  * 2. 클래스명: OfferController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 -프로그램 리스트 상세 수정 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param slr
	 *   @return	
	 */
	@RequestMapping(value = "/modifyOfferJoinPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyOfferJoinPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody OfferJoinPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.modifyOfferJoinPgm(reqDto);
	}
	
	 /*
	  * 1. 메소드명: initOfrCouponDetail
	  * 2. 클래스명: OfferController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 상세 쿠폰 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/initOfrCouponDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto initOfrCouponDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody CouponDtlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.initOfrCouponDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: iniOfrCouponGuide
	  * 2. 클래스명: OfferController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 상세 이용안내 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/initOfrCouponGuide.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto initOfrCouponGuide(HttpServletRequest request, HttpServletResponse response, @RequestBody CouponGuideListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.initOfrCouponGuide(reqDto);
	}
	
	@RequestMapping(value = "/getOfrCpnCnt.do", method = RequestMethod.POST)
	public @ResponseBody int getOfrCpnCnt(HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.getOfrCpnCnt(reqDto);
	}
	
	@RequestMapping(value = "/updateOfrStatCdStop.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateOfrStatCdStop(HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.updateOfrStatCdStop(reqDto);
	}
	
	@RequestMapping(value = "/updateOfrStatCdStart.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateOfrStatCdStart(HttpServletRequest request, HttpServletResponse response, @RequestBody OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.updateOfrStatCdStart(reqDto);
	}
	
	@RequestMapping(value = "/getOfferPointCommCodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<ICNCommonCodeResponseDTO> getOfferPointCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonCodeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return offerService.getOfferPointCommCodeList(reqDto);
	}
	
	@RequestMapping(value = "/getOfferPointList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<OfferResDto> getOfferPointList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerService.getOfferPointList(slr);
	}
	
}
