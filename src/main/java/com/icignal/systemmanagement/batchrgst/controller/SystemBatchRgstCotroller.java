package com.icignal.systemmanagement.batchrgst.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.component.Messages;
import com.icignal.external.aws.KMSManager;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchLogListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstDetailInsertReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstDetailReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstItemReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemSmsUnSubscribeListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemUpldItemListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemAprReqResResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemBatchLogListResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemBatchRgstDetailResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemPntBatchRgstItemResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemPntBatchRgstListResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemTxnCodeListResDto;
import com.icignal.systemmanagement.batchrgst.service.SystemBatchRgstService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;
import com.icignal.systemmanagement.log.dto.request.SystemExcelDownloadLogReqDto;
import com.icignal.systemmanagement.log.service.SystemLogSerivce;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/*
 * 1. 클래스명	: SystemBatchRgstCotroller
 * 2. 파일명	: SystemBatchRgstCotroller.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2017. 11. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 -  승인서버 관리 로그 , 080수신자거부 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/batchRgst")
public class SystemBatchRgstCotroller extends BaseController {

	@Autowired
	private SystemBatchRgstService systemBatchRgstService;
	
	@Autowired
	SystemLogSerivce systemLogService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		LogUtil.info("NavigatePopMenu start.....");
		
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name + ".modal-tiles";

		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}

	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".include-tiles";;
		if( checkIncludeProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
		
	}

    /**
    * @programId   :
    * @name        : getTransactionList
    * @date        : 2017. 11. 13.
    * @author      : kimjunki
    * @table       :
    * @return      : GridPagingResDto
    * @description :
    **/
    @RequestMapping(value="/getBatchRgstList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemBatchRgstListReqDto> getBatchRgstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstListReqDto param) {
        LogUtil.param(SystemBatchRgstCotroller.class, param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));

        return systemBatchRgstService.getBatchRgstList(param);
    }


     /**
    * @programId   :
    * @name        : getUpldItemList
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : GridPagingResDto
    * @description :
    **/
    @RequestMapping(value="/getUpldItemList.do", method = RequestMethod.POST)
     public @ResponseBody GridPagingResDto<SystemUpldItemListReqDto> getUpldItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemUpldItemListReqDto param) {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));

         return systemBatchRgstService.getUpldItemList(param);
     }

     /**
    * @programId   :
    * @name        : uploadExcel
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : HashMap<String,Object>
    * @description :
    **/
    @RequestMapping(value="/uploadExcel.do", method = RequestMethod.POST)
     @ResponseBody
     public ResponseEntity  uploadExcel(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
 		authHelper.checkLoginSession(request.getSession(true));
 		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
 		List<SystemBatchRgstUploadReqDto> batchUpload = new ArrayList<SystemBatchRgstUploadReqDto>() ;
 		StatusResDto rtnValue = new StatusResDto();
 		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

 		String empId = loginInfo.getId();
 		String upldId = loginInfo.getEmpId();
 		SystemBatchRgstUploadReqDto br = new SystemBatchRgstUploadReqDto();
 		String rid = CommonUtil.newRid();

 		try {
			batchUpload = excelUpld.excelFileUpload( request, false, rid);
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
 	 	 		br.setEmpId(empId);
 	 	 		br.setUpldId(upldId);
 	 	 		br.setRid(rid);
 	 	 		rtnValue = systemBatchRgstService.insertStampUploadData(br);
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

     /**
    * @programId   :
    * @name        : excelSampleDown
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : StatusResDto
    * @description :
    **/
    @RequestMapping(value="/excelSampleDown.do", method = RequestMethod.POST)
     @ResponseBody
     public StatusResDto  excelSampleDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstUploadReqDto param) throws IOException {
    	 BatchRgstExcelFileUtil excelUtil= new BatchRgstExcelFileUtil();
    	 StatusResDto rtnValue = new StatusResDto();
    	 rtnValue.setSuccess(false);
    	 try {
    		 rtnValue = excelUtil.excelFileDown(request,param);
    		 rtnValue.setSuccess(true);
		} catch (Exception e) {

			LogUtil.error(e);
		}
    	 return rtnValue;
     }

    @RequestMapping(value="/excelSampleDown2.do")
    public void  excelSampleDown2(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	OutputStream os = null;
		FileInputStream fis = null;

    	String fileName = null;
    	String filePath = null;
    	String offerType = request.getParameter("offerType");

		if(offerType.equals("STMP")){
			fileName="stamp_sample_data.xls";
		}else if(offerType.equals("PNT")){
			fileName="point_sample_data.xls";
		}else if(offerType.equals("CARD")){
			fileName="card_sample_data.xls";
		}else if(offerType.equals("TARGET_MEMBER")){
			fileName="point_upload_member_sample_data.xlsx";
		}else if(offerType.equals("100") || offerType.equals("200")){
			fileName="point_upload_event_sample_data.xls";
	    }else if(offerType.equals("TARGET_EMP")){
	    	fileName="point_upload_cust_sample_data.xls";
	    }else if(offerType.equals("TARGET_MEMBER_CI")){
			fileName="point_upload_cust(CI)_sample_data.xls";
	    }else if(offerType.equals("PROD")) {
	    	fileName="prod_list_sample_data.xls";
	    }else if(offerType.equals("EVENT_WINNER")) {
	    	fileName="event_winner_sample_data.xls";
	    }else if(offerType.equals("EVENT_APPLICANT")) {
	    	fileName="event_applicant_sample_data.xls";
	    }else if(offerType.equals("PROD_ENTRY")){
	    	fileName="send_success_sample_data.xls";
	    }else if(offerType.equals("POINT_MALL_ORDER")) {
	    	fileName="point_mall_order_data.xls";
	    }else if(offerType.equals("FAQ")) {
	    	fileName="faq_upload_sample_data.xls";
	    }else if(offerType.equals("OFR_CUPON_STATUS")) {
	    	fileName="ofrCuponStatus_upload_sample_data.xls";
	    }else if(offerType.equals("TARGET_TGTGRP")) {
	    	fileName="tgtgrp_member_sample_data.xls";
	    }else if(offerType.equals("PROD_GRP")) {
	    	fileName="prod_grp_sample_data.xls";
	    }else if(offerType.equals("CHNL_GRP")) {
	    	fileName="chnl_grp_sample_data.xls";
	    }else if(offerType.equals("PROD_CATEGORY_GRP")) {
	    	fileName="category_grp_sample_data.xls";
	    }else if(offerType.equals("ROAD_ADDR")) { /// 도로명주소업로드를 위한 키워드 넣어주기
	    	fileName="system_roadAddress_sample_data.xls";  //<== 이런 식으로 파일이름으로 저장될 이름 (겹치지않게) 만들어서 설정한다 
	    }else if(offerType.equals("PROD_LIST")) {
	    	fileName="prod_uploadlist_sample_data.xls";
	    }
  	  try {
//			fileName = new String(fileName.getBytes("8859_1"), "UTF-8");
//			fileName = URLDecoder.decode(fileName,"UTF-8");
//
//			filePath = new String(filePath.getBytes("8859_1"), "UTF-8");
//			filePath  = URLDecoder.decode(filePath,"UTF-8");
//		    String rid = new String(request.getParameter("rid").getBytes("8859_1"), "UTF-8");
//		    String exc  = filePath.substring(filePath.lastIndexOf(".")+1, filePath.length());
  		  
	  		// local "user.dir" 경로 : C:\Users\Quintet\Documents\iCIGNAL_LOYALTY_T10_Beta/
	  		// Real "user.dir" 경로 : /app/adimn or /app/tomcat
	  		String applicationFilePath = System.getProperty("user.dir");

	  		String fileRootPath = CommonUtil.getInstance().getExcelFileSampleDownPath().replaceAll("/", Matcher.quoteReplacement(File.separator));
	  		
  		    filePath = request.getSession().getServletContext().getRealPath("/") + fileRootPath + fileName;

			File orgFile = new File(filePath);
			
			//LogUtil.info("!!!!!!!!!!!!!!ROOT PATH : "+request.getSession().getServletContext().getRealPath("/")+"!!!!!!!!!!!!!!!!!!!!!!!!");
			//LogUtil.info("!!!!!!!!!!!!!!filePath : "+filePath+"!!!!!!!!!!!!!!!!!!!!!!!!");
			//LogUtil.info("!!!!!!!!!!!!!!applicationFilePath : "+applicationFilePath+"!!!!!!!!!!!!!!!!!!!!!!!!");
			//LogUtil.info("!!!!!!!!!!!!!!fileRootPath : "+fileRootPath+"!!!!!!!!!!!!!!!!!!!!!!!!");
			//LogUtil.info("!!!!!!!!!!!!!!fileName : "+fileName+"!!!!!!!!!!!!!!!!!!!!!!!!");
			
	         if(orgFile.exists()) {
//				fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
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
			} catch (Exception e2) {
				{LogUtil.error(e2);  fis = null;}
			}
			try {
				if(os != null)	os.close();
			}catch (IOException io){LogUtil.error(io);  os = null;}
		}
    }


     /**
    * @programId   :
    * @name        : getBatchRgstDetail
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : SystemBatchRgstDetailResDto
    * @description :
    **/
    @RequestMapping(value="/getBatchRgstDetail.do", method = RequestMethod.POST)
     public @ResponseBody SystemBatchRgstDetailResDto  getBatchRgstDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstDetailReqDto param) throws IOException {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));

         return systemBatchRgstService.getBatchRgstDetail(param);
     }

     /**
    * @programId   :
    * @name        : updateBatchRgstDetail
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : StatusResDto
    * @description :
    **/
    @RequestMapping(value="/updateBatchRgstDetail.do", method = RequestMethod.POST)
     public @ResponseBody StatusResDto  updateBatchRgstDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstDetailInsertReqDto param) throws IOException {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));
 		 LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
 		 param.setEmpId(loginInfo.getId());
         return systemBatchRgstService.updateBatchRgstDetail(param);
     }

    /**
     * @programId   :
     * @name        : cancelBatchIns
     * @date        : 2017. 11. 28.
     * @author      : sw.lim
     * @table       :
     * @return      : StatusResDto
     * @description :
     **/
     @RequestMapping(value="/cancelBatchIns.do", method = RequestMethod.POST)
      public @ResponseBody StatusResDto  cancelBatchIns(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstDetailReqDto param) throws IOException {
          LogUtil.param(SystemBatchRgstCotroller.class, param);
          param.setLoginInfo(authHelper.checkLoginSession(request, response));
          LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
          param.setEmpId(loginInfo.getEmpId());
          return systemBatchRgstService.cancelBatchIns(param);
      }

     /**
      * @programId   :
      * @name        : cancelBatchRequest
      * @date        : 2017. 11. 28.
      * @author      : sw.lim
      * @table       :
      * @return      : StatusResDto
      * @description :
      **/
      @RequestMapping(value="/cancelBatchRequest.do", method = RequestMethod.POST)
       public @ResponseBody StatusResDto  cancelBatchRequest(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstDetailReqDto param) throws IOException {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));
   		 LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
   		 param.setEmpId(loginInfo.getEmpId());
         return systemBatchRgstService.cancelBatchRequest(param);
       }

     /**
    * @programId   :
    * @name        : callLookUpValue
    * @date        : 2017. 11. 28.
    * @author      : kimjunki
    * @table       :
    * @return      : String
    * @description :
    **/
    @RequestMapping(value="/callLookUpValue.do", method = RequestMethod.POST)
     public @ResponseBody String  callLookUpValue(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchRgstDetailReqDto param) throws IOException {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));
         return systemBatchRgstService.callLookUpValue(param);
     }

    @RequestMapping(value="/gridExcelDown.do")
    public void  gridExcelDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
    		// 세션 확인
    	   authHelper.checkUserInfo(request, response);
    	   String fileName = request.getParameter("fileName");
    	   String filePath = request.getParameter("filePath");
    	   String rid = request.getParameter("rid");

			OutputStream os = null;
			FileInputStream fis = null;


    	   if(fileName == null || filePath == null || rid == null) return;

    	  try {
			fileName = new String(fileName.getBytes("8859_1"), "UTF-8");
			fileName = URLDecoder.decode(fileName,"UTF-8");

			filePath = new String(filePath.getBytes("8859_1"), "UTF-8");
			filePath  = URLDecoder.decode(filePath,"UTF-8");
			rid = new String(request.getParameter("rid").getBytes("8859_1"), "UTF-8");
			String exc  = filePath.substring(filePath.lastIndexOf('.')+1, filePath.length());

			String fileRootPath = CommonUtil.getInstance().getExcelFileUploadPath();

			filePath = fileRootPath + rid + "." + exc;

			String realPath = request.getSession().getServletContext().getRealPath("/");
			File orgFile = new File(realPath  + filePath);

	         if(orgFile != null) {
				// MIME Type 을 application/octet-stream 타입으로 변경
				// 무조건 팝업(다운로드창)이 뜨게 된다.
				response.setContentType("application/octet-stream");

				// 브라우저는 ISO-8859-1을 인식하기 때문에
				// UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.
				fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
				fileName = SecurityUtil.chkPath(fileName);

				// 파일명 지정
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
				fis = new FileInputStream(orgFile.getAbsolutePath());
				if(fis != null) {
					os = response.getOutputStream();
					int n = 0;
					byte[] b = new byte[1024];
					while ((n = fis.read(b)) != -1) {
						os.write(b, 0, n);
					}
				}
	         }
    	} catch (UnsupportedEncodingException e) {
		     LogUtil.error(e);
    	} catch(IOException io){
    		LogUtil.error(io);
		}finally {
			try {
				if(fis != null ) fis.close();
			} catch (Exception e2) {
				{LogUtil.error(e2);  fis = null;}
			}
			try {
				if(os != null)	os.close();
			}catch (IOException io){LogUtil.error(io);  os = null;}
		}

    }


    /**
    * @programId :
    * @name : uploadExcelPnt
    * @date : 2018. 11. 5.
    * @author : hy.jun
    * @table :
    * @return : ResponseEntity
    * @description :
    */
    @RequestMapping(value="/uploadExcelPnt.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity   uploadExcelPnt(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
		authHelper.checkLoginSession(request.getSession(true));
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
		SystemPntBatchRgstUploadReqDto batchUpload = new SystemPntBatchRgstUploadReqDto() ;
		StatusResDto rtnValue = new StatusResDto();
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj  = (JSONObject) json.get("data");
 		String dispNo = (String)obj.get("dispNo");
 		String ridCam = (String)obj.get("ridCam");
 		String ofrRid = (String)obj.get("ofrRid");
 		String pgmRid = (String)obj.get("pgmRid");
 		String custTypeCd = (String)obj.get("custTypeCd");
		String rid = CommonUtil.newRid();
		
		try {
			batchUpload = excelUpld.excelFileUploadPnt( request, false, rid);
			batchUpload.setLoginInfo(loginInfo);
		} catch (Exception e) {
			LogUtil.error(e);
		}
		if(batchUpload.getArray().size()>0){
			if(batchUpload.getUploadValidCheck()!=null){
	 			if(batchUpload.getUploadValidCheck().equals("NOTUPLD")){
	 	 			rtnValue.setSuccess(false);
	 	 			rtnValue.setMessage("업로드 할 데이터가 없습니다.");
	 			} else {
	 				LogUtil.error("LOYBatchRgstController.uploadExcelPnt >> " + batchUpload.getUploadValidCheck());
	 			}
			}else{
				/*
				 * for(SystemPntBatchRgstItemReqDto data : batchUpload.getArray()) {
				 * data.setLoginInfo(loginInfo); data.setRidPntUpload(rid); }
				 */
				batchUpload.setDispNo(dispNo);
				batchUpload.setRidCam(ridCam);
				batchUpload.setOfrRid(ofrRid);
				batchUpload.setPgmRid(pgmRid);
				batchUpload.setCustTypeCd(custTypeCd);
	 	 		rtnValue = systemBatchRgstService.insertPntUploadData(batchUpload);
			}

		}else{
			if(batchUpload.getUploadValidCheck()!=null){
				if(batchUpload.getUploadValidCheck().equals("EXT")){
	 	 			rtnValue.setSuccess(false);
	 		    	rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

	 			}else if(batchUpload.getUploadValidCheck().equals("SIZE")){
	 	 			rtnValue.setSuccess(false);
	 	 			rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				}else if(batchUpload.getUploadValidCheck().equals("DUP")){
					 rtnValue.setSuccess(false); rtnValue.setMessage("업로드 할 파일명은 중복될 수 없습니다."); 
			}
			
			} else {
				rtnValue.setSuccess(false);
				rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
			}
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

    /**
    * @programId :
    * @name : getBatchRgstList
    * @date : 2018. 11. 5.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getPntBatchRgstList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemPntBatchRgstListResDto> getPntBatchRgstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstListReqDto param) {
        LogUtil.param(SystemBatchRgstCotroller.class, param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return systemBatchRgstService.getPntBatchRgstList(param);
    }

    /**
    * @programId :
    * @name : getPntUpldItemList
    * @date : 2018. 11. 5.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getPntUpldItemList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemPntBatchRgstItemResDto> getPntUpldItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstItemReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return systemBatchRgstService.getPntUpldItemList(param);
    }

    /**
    * @programId :
    * @name : getPntUpldItemDown
    * @date : 2019. 1. 30.
    * @author : mj.kim
    * @table :
    * @return : String
    * @description :
    */
    @RequestMapping(value="/getPntUpldItemDown.do", method = RequestMethod.POST)
    public String getPntUpldItemDown(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody SystemPntBatchRgstItemReqDto param, ModelMap model) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	GridPagingResDto<SystemPntBatchRgstItemReqDto> data = systemBatchRgstService.getExcelDownPntUpldItemList(param);
    	SystemExcelDownloadLogReqDto edlr = new SystemExcelDownloadLogReqDto();
        edlr.setSystemColumn(param.getSystemColumn());
        edlr.setTargetId(param.getRidPntUpload());

        systemLogService.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.PNT_BATCH_RGST_RSLT);

    	model.addAttribute("result", data);
        model.addAttribute("excelHeader", param.getExcelHeader());
        model.addAttribute("fileName", "포인트 수동 일괄등록");
    	return "ExcelView";
    }

    /**
    * @programId :
    * @name : confirmPntBatchRgstList
    * @date : 2018. 11. 5.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
    * @description :
    */
    @RequestMapping(value="/confirmPntBatchRgstList.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto confirmPntBatchRgstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstListReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return systemBatchRgstService.confirmPntBatchRgstList(param);
    }

    /**
    * @programId :
    * @name : deletePntBatchRgstList
    * @date : 2018. 11. 5.
    * @author : hy.jun
    * @table :
    * @return : StatusResDto
     * @throws UnsupportedEncodingException
    * @description :
    */
    @RequestMapping(value="/deletePntBatchRgstList.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto deletePntBatchRgstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstListReqDto param) throws UnsupportedEncodingException {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	//업로드파일 삭제
    	String filePath = CommonUtil.getInstance().getServletProp("excelFileDownSample.excelFileDownPath.external").replaceAll("/", Matcher.quoteReplacement(File.separator));
    	filePath = filePath.replace("해당업무", "loyBatchRgst");

    	String imsiFileXls = param.getRid() + ".xls";
    	String imsiFileXlsx = param.getRid() + ".xlsx";
    	String imsiFileOrg = URLDecoder.decode(param.getFileName(), "UTF-8");
	    File saveFileXls  = new File(filePath+imsiFileXls);
	    File saveFileXlsx  = new File(filePath+imsiFileXlsx);
	    File saveFileOrg  = new File(filePath+imsiFileOrg);

	    if(saveFileXls.exists() || saveFileOrg.exists()) {
	    	saveFileXls.delete();
	    	saveFileOrg.delete();
	    	LogUtil.info("===== LOYBatchRgstController.deletePntBatchRgstList : File Remove Complete! : "+saveFileXls.getAbsolutePath());
	    } else if(saveFileXlsx.exists() || saveFileOrg.exists()) {
	    	saveFileXlsx.delete();
	    	saveFileOrg.delete();
	    	LogUtil.info("===== LOYBatchRgstController.deletePntBatchRgstList : File Remove Complete! : "+saveFileXlsx.getAbsolutePath());
	    }

    	return systemBatchRgstService.deletePntBatchRgstList(param);
    }
    
    // @Autowired String fileCryptorKey;
     /*
      * 1. 메소드명: gridExcelDown2
      * 2. 클래스명: SystemBatchRgstCotroller
      * 3. 작성자명: hy.jun
      * 4. 작성일자: 2018. 12. 3.
      */
    /**
     * <PRE>
     * 1. 설명
     *		서버의 암호화된 엑셀파일을 복호화후 엑셀 다운로드 하는 메소드
     *		추후 FileDataLocalEncryption를 이용하여 구현하세요
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @throws Exception	
     */
    @RequestMapping(value="/gridExcelDown2.do")
    public void  gridExcelDown2(HttpServletRequest request, HttpServletResponse response) throws Exception {
          // 세션 확인
          authHelper.checkUserInfo(request, response);
          String fileType = request.getParameter("fileType");
          String fileName = request.getParameter("fileName");
          String filePath = request.getParameter("filePath");
          String rid = request.getParameter("rid");
          File tmpFile = null;

         OutputStream os = null;
         FileInputStream fis = null;


          if(fileName == null || filePath == null/* || rid == null*/) return;

         try {
         fileName = URLDecoder.decode(fileName,"UTF-8");

         filePath  = URLDecoder.decode(filePath,"UTF-8");
         String exc  = filePath.substring(filePath.lastIndexOf('.')+1, filePath.length());

         String fileRootPath = CommonUtil.getInstance().getServletProp("icignal.context.resource.excelFileDownPathExternal").replaceAll("/", Matcher.quoteReplacement(File.separator));
         fileRootPath = fileRootPath.replaceAll("해당업무", fileType);

         filePath = fileRootPath + fileName;

         File orgFile = new File(filePath);

         //암호화된 파일 복호화
         KMSManager kms = new KMSManager();
         //EncryptUtil.getCryptoFile(Cipher.DECRYPT_MODE, kms.getSecretKey(BeansUtil.getFileCryptorKey()), orgFile, orgFile);

            if(orgFile.exists()) {
               // MIME Type 을 application/octet-stream 타입으로 변경
               // 무조건 팝업(다운로드창)이 뜨게 된다.
               response.setContentType("application/octet-stream");

               // 브라우저는 ISO-8859-1을 인식하기 때문에
               // UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.
               fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
               fileName = SecurityUtil.chkPath(fileName);

               // 파일명 지정
               response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
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
                  throw new FileNotFoundException("[LOYBatchRgstController.gridExcelDown2] 파일 복호화 실패");
               }
            //SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, kms.getSecretKey(BeansUtil.getFileCryptorKey()), orgFile, orgFile);
       } catch (UnsupportedEncodingException e) {
           LogUtil.error(e);
       } catch(IOException io){
          LogUtil.error(io);
      }finally {
         try {
            if(fis != null ) fis.close();
         } catch (Exception e2) {
            {LogUtil.error(e2);  fis = null;}
         }
         try {
            if(os != null)   os.close();
         }catch (IOException io){LogUtil.error(io);  os = null;}
      }

    }    /**
    * @programId :
    * @name : setBatchLog
    * @date : 2018. 12. 7.
    * @author : mj.kim
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/setBatchLog.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemBatchLogListResDto> setBatchLog(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody SystemBatchLogListReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);

    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return systemBatchRgstService.setBatchLog(param);
    }
    /**
    * @programId :
    * @name : getAprLogDetail
    * @date : 2018. 12. 10.
    * @author : mj.kim
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getAprLogDetail.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemBatchLogListResDto> getAprLogDetail(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody SystemBatchLogListReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);

    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return systemBatchRgstService.getAprLogDetail(param);
    }
    /**
    * @programId :
    * @name : setBatchLog
    * @date : 2018. 12. 10.
    * @author : mj.kim
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/setApprFailList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemBatchLogListResDto> setApprFailList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody SystemBatchLogListReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);

    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return systemBatchRgstService.setApprFailList(param);
    }
    
    @RequestMapping(value="/setReqResData.do", method = RequestMethod.POST)
    public @ResponseBody SystemAprReqResResDto setReqResData(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemBatchLogListReqDto param) {
    	LogUtil.param(SystemBatchRgstCotroller.class, param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return systemBatchRgstService.setReqResData(param);
    }

    /**
    * @programId :
    * @name : getUnSubExcelUploadList
    * @date : 2018. 05. 02.
    * @author : dw.keum
    * @table :	
    * @return : GridPagingResDto
    * @description :		080 수신거부 관리 엑셀 업로드
    */
    @RequestMapping(value="/getUnSubExcelUploadList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<SystemSmsUnSubscribeListReqDto> getUnSubExcelUploadList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSmsUnSubscribeListReqDto param) {
        LogUtil.param(SystemBatchRgstCotroller.class, param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return systemBatchRgstService.getUnSubExcelUploadList(param);
    }

    /**
     * @programId :
     * @name : smsUpldItemList
     * @date : 2018. 05. 02.
     * @author : dw.keum
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
     @RequestMapping(value="/smsUpldItemList.do", method = RequestMethod.POST)
     public @ResponseBody GridPagingResDto<SystemSmsUnSubscribeListReqDto> smsUpldItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSmsUnSubscribeListReqDto param) {
         LogUtil.param(SystemBatchRgstCotroller.class, param);
         param.setLoginInfo(authHelper.checkLoginSession(request, response));
         return systemBatchRgstService.smsUpldItemList(param);
     }

     /**
      * @programId :
      * @name : excelUploadSmsUnSub
      * @date : 2019. 05. 03.
      * @author : dw.keum
      * @table :
      * @return : ResponseEntity
      * @description :
      */
      @RequestMapping(value="/excelUploadSmsUnSub.do", method = RequestMethod.POST)
      @ResponseBody
      public ResponseEntity  excelUploadSmsUnSub(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
  		authHelper.checkLoginSession(request.getSession(true));
  		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
  		SystemPntBatchRgstUploadReqDto batchUpload = new SystemPntBatchRgstUploadReqDto() ;
  		StatusResDto rtnValue = new StatusResDto();
  		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

  		String rid = CommonUtil.newRid();

  		try {
  			batchUpload = excelUpld.excelUploadSmsUnSub( request, false, rid);
  			batchUpload.setLoginInfo(loginInfo);
  		} catch (Exception e) {
  			LogUtil.error(e);
  		}
  		if(batchUpload.getArray().size()>0){
  			if(batchUpload.getUploadValidCheck()!=null){
  	 			if(batchUpload.getUploadValidCheck().equals("NOTUPLD")){
  	 	 			rtnValue.setSuccess(false);
  	 	 			rtnValue.setMessage("업로드 할 데이터가 없습니다.");
  	 			} else {
  	 				LogUtil.error("SystemBatchRgstCotroller.uploadExcelPnt >> " + batchUpload.getUploadValidCheck());
  	 			}
  			}else{
  				for(SystemPntBatchRgstItemReqDto data : batchUpload.getArray()) {
  					data.setLoginInfo(loginInfo);
  					data.setRidPntUpload(rid);
  				}
  				batchUpload.setProcTypeCd("TARGET_SMS");

  	 	 		rtnValue = systemBatchRgstService.insertPntUploadData(batchUpload);
  			}

  		}else{
  			if(batchUpload.getUploadValidCheck()!=null){
  				if(batchUpload.getUploadValidCheck().equals("EXT")){
  	 	 			rtnValue.setSuccess(false);
  	 		    	rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");

  	 			}else if(batchUpload.getUploadValidCheck().equals("SIZE")){
  	 	 			rtnValue.setSuccess(false);
  	 	 			rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
  	 			}else if(batchUpload.getUploadValidCheck().equals("DUP")){
  	 	 			rtnValue.setSuccess(false);
  	 	 			rtnValue.setMessage("업로드 할 파일명은 중복될 수 없습니다.");
  	 			}
  			} else {
  				rtnValue.setSuccess(false);
  				rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
  			}
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


      @RequestMapping(value="/callUnSubscribeSms.do", method = RequestMethod.POST)
      public @ResponseBody StatusResDto  callUnSubscribeSms(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSmsUnSubscribeListReqDto param){
    	  LogUtil.param(SystemBatchRgstCotroller.class, param);
          param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	  return systemBatchRgstService.callUnSubscribeSms(param);
      }
      
      @RequestMapping(value="/getTxnCodeList.do", method = RequestMethod.POST)
      public @ResponseBody GridPagingResDto<SystemTxnCodeListResDto> getTxnCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstItemReqDto param) {
      	LogUtil.param(SystemBatchRgstCotroller.class, param);
      	param.setLoginInfo(authHelper.checkLoginSession(request, response));

      	return systemBatchRgstService.getTxnCodeList(param);
      }
      
      @RequestMapping(value="/clearMaskPntItemMbr.do", method = RequestMethod.POST)
      public @ResponseBody SystemPntBatchRgstItemResDto clearMaskPntItemMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstItemReqDto param) {
      	LogUtil.param(SystemBatchRgstCotroller.class, param);
      	param.setLoginInfo(authHelper.checkLoginSession(request, response));

      	return systemBatchRgstService.clearMaskPntItemMbr(param);
      }
      
      @RequestMapping(value="/useConfirmPntBatchRgstList.do", method = RequestMethod.POST)
      public @ResponseBody StatusResDto useConfirmPntBatchRgstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemPntBatchRgstListReqDto param) {
      	LogUtil.param(SystemBatchRgstCotroller.class, param);
      	param.setLoginInfo(authHelper.checkLoginSession(request, response));
      	return systemBatchRgstService.useConfirmPntBatchRgstList(param);
      }
      
      @RequestMapping(value="/blackRuleTest.do", method = RequestMethod.POST)
      public @ResponseBody StatusResDto  blackRuleTest(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSmsUnSubscribeListReqDto param){
    	  LogUtil.param(SystemBatchRgstCotroller.class, param);
          param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	  return systemBatchRgstService.blackRuleTest(param);
      }
}
