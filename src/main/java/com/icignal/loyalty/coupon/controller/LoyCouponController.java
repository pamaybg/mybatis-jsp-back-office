/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampController.java
 * 2. Package	: com.icignal.loyalty.stamp.controller
 * 3. Comments	:
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 25. 오후 5:26:38
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.coupon.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.coupon.dto.request.LoyCouponDetailReqDto;
import com.icignal.loyalty.coupon.dto.request.LoyCouponListReqDto;
import com.icignal.loyalty.coupon.dto.response.LOYCpnPayUploadResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCouponListResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCpnOfferResDto;
import com.icignal.loyalty.coupon.service.LoyCouponService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;



/*
 * 1. 클래스명	: LoyCouponController
 * 2. 파일명	: LoyCouponController.java
 * 3. 패키지명	: com.icignal.loyalty.coupon.controller
 * 4. 작성자명	: jk.kim
 * 5. 작성일자	: 2020. 7. 09.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/coupon")
public class LoyCouponController extends BaseController{

	@Autowired
	private LoyCouponService loyCouponService;

	@Autowired
	private AuthHelper authHelper;

	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request,
			HttpServletResponse response,Model model) {
		LogUtil.error("NavigatePopMenu start.....");


		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		//Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name;

		//checkProgramAuth(respUrl, request ,response , model);

		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}

	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;

		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}


    @RequestMapping(value="/paymentCpnMultiUpload.do" , method = RequestMethod.POST)
	public @ResponseBody ResponseEntity paymentCpnMultiUpload (MultipartHttpServletRequest request , HttpServletResponse response) throws Exception{
		LoginResDto loginInfo = this.checkLoginSession(request,response);
		StatusResDto rtnValue = new StatusResDto();
		LOYCpnPayUploadResDto resDto = new LOYCpnPayUploadResDto();

		String offerNo = "";

		//헤더값 추출
		MultipartHttpServletRequest multiRequest = request;
		MultipartFile file = multiRequest.getFile("fileUpload");

		try {
			String[] rs = multiRequest.getParameterValues("param");
			String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
			ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
			JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
			JSONObject obj = (JSONObject) json.get("data");
			offerNo = (String) obj.get("offerNo");
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e.getMessage());
		}

		//데이터 read
		LOYCpnPayUploadResDto uploadRes = loyCouponService.parymentCpnMultiUpload(request,file);

		if(uploadRes.getArray().size() > 0){
			if(ObjectUtil.isNotEmpty(uploadRes.getUploadValidCheck())){
				if(uploadRes.getUploadValidCheck().equals("EXT")){
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
				}else if(uploadRes.getUploadValidCheck().equals("SIZE")){
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				}else{
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 업로드 ERROR 관리자에게 문의해주시기 바랍니다.");
				}
			}else{
				uploadRes.setLoginInfo(loginInfo);
				uploadRes.setOfferNo(offerNo);
				uploadRes.setFilePath(uploadRes.getFilePath().substring(uploadRes.getFilePath().indexOf("coupon"))); //FULL 경로 제거
				rtnValue = loyCouponService.insertPaymentCoupon(uploadRes);
			}
		}else{
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
		}

		//response 셋팅
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

	@RequestMapping(value="/getCouponUploadList.do", method = RequestMethod.POST)
    public @ResponseBody   GridPagingResDto<LoyCouponListResDto> getMbrList( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyCouponListReqDto reqDto) throws Exception {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyCouponService.getCouponUploadList(reqDto);

    }
	@RequestMapping(value="/couponExcelSampleDown.do" ,method = RequestMethod.POST)
	 public void  couponExcelSampleDown(HttpServletRequest request, HttpServletResponse response) throws IOException {

	    	OutputStream os = null;
			FileInputStream fis = null;

	    	String fileName = "couponUploadTempalte.xlsx";
	    	String filePath = null;

	  	  try {

				String fileRootPath = CommonUtil.getInstance().getExcelFileSampleDownPath().replaceAll("/", Matcher.quoteReplacement(File.separator));

				filePath = fileRootPath + fileName;

				String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
				File orgFile = new File(realPath  + filePath);
		         if(orgFile.exists()) {
//					fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
					fileName = SecurityUtil.chkPath(fileName);

					//ContentType 설정
					String mime = request.getSession().getServletContext().getMimeType(fileName);
					if (ObjectUtil.isEmpty(mime)) {
						mime = "application/octet-stream;charset=euc-kr";
					} else {
						mime = "application/octet-stream";
					}
					response.setContentType(mime);

					//헤더 설정
					String userAgent = request.getHeader("User-Agent");
					if (userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
						response.setHeader("Content-Disposition", "filename="+ URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+","\\ ") + ";");
					} else if (userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
						response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
					} else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
						response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
					} else { // 모질라나 오페라
						response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("UTF-8"), "latin1").replaceAll("\\+", "\\ ") + ";");
					}

					//파일 출력
					fis = new FileInputStream(orgFile.getAbsolutePath());
					if(fis != null) {
						os = response.getOutputStream();
						int n = 0;
						byte[] b = new byte[1024];
						while ((n = fis.read(b)) != -1) {
							os.write(b, 0, n);
						}
					}
		         } else {
		        	 throw new FileNotFoundException();
		         }
	  	} catch (UnsupportedEncodingException e) {
	  		LogUtil.error(e);
	  	} catch(IOException io){
	  		LogUtil.error(io);
			}finally {
				try {
					if(fis != null ) fis.close();
				} catch (IOException e2) {
					{LogUtil.error(e2);  fis = null;}
				}
				try {
					if(os != null)	os.close();
				}catch (IOException io){LogUtil.error(io);  os = null;}
			}
	    }

	@RequestMapping(value="/saveMbrCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveMbrCoupon(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param) throws ParseException{
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.saveMbrCoupon(param);
	}

	@RequestMapping(value="/useMbrCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto useMbrCoupon(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.useMbrCoupon(param);
	}

	@RequestMapping(value="/saveCnclMbrCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveCnclMbrCoupon(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.saveCnclMbrCoupon(param);
	}

	@RequestMapping(value="/useCnclMbrCoupon.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto useCnclMbrCoupon(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.useCnclMbrCoupon(param);
	}

	@RequestMapping(value="/getCpnOffer.do", method = RequestMethod.POST)
	public @ResponseBody LoyCpnOfferResDto getCpnOffer(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.getCpnOffer(param);
	}
	
	@RequestMapping(value="/getCpnChnl.do", method = RequestMethod.POST)
	public @ResponseBody LoyCpnOfferResDto getCpnChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyCouponService.getCpnChnl(param);
	}




}
