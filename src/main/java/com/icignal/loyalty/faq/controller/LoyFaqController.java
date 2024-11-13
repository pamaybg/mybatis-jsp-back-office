package com.icignal.loyalty.faq.controller;

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
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.faq.dto.request.LoyFaqDetailReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqInsertReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqListReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqUploadReqDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqDetailResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqListResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqUploadResDto;
import com.icignal.loyalty.faq.service.LoyFaqService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 * @name : 
 * @date : 
 * @author : 
 * @description : 
 * 
 * 
 * 
 * 
 */
@Controller
@RequestMapping("/loyalty/custChnl/faq")
public class LoyFaqController extends BaseController {
		
		@Autowired
		private LoggingHelper loggingHelper;
		
		@Autowired
		private LoyFaqService loyFaqService;
		
		@Autowired
		private AuthHelper authHelper;
		
		/**
		 * @name : getFAQList
		 * @date : 2017. 03. 27
		 * @author : mjpyo
		 * @description : FAQ 리스트
		 */
		@RequestMapping(value = "/getFAQList.do", method = RequestMethod.POST)
		public @ResponseBody GridPagingResDto<LoyFaqListResDto> getFAQList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqListReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.getFAQList(reqDTO);
		}
		
		/**
		 * @name : insertFaq
		 * @date : 2017. 03. 27
		 * @author : mjpyo
		 * @description : FAQ 등록
		 */
		@RequestMapping(value = "/insertFaq.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto insertFaq(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqInsertReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.insertFaq(reqDTO);
		}
		
		
		/**
		 * @name : increaseFaqCount
		 * @date : 2017. 03. 27
		 * @author : mjpyo
		 * @description : FAQ 조회수 증가
		 */
		@RequestMapping(value = "/increaseFaqCount.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto increaseFaqCount(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqDetailReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.increaseFaqCount(reqDTO);
		}
		
		/**
		 * @name : getFaqDetail
		 * @date : 2017. 03. 27
		 * @author : mjpyo
		 * @description : FAQ 상세
		 */
		@RequestMapping(value = "/getFaqDetail.do", method = RequestMethod.POST)
		public @ResponseBody LoyFaqDetailResDto getFaqDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqDetailReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.getFaqDetail(reqDTO);
		}
		
		
		/**
		 * @name : insertMasterFaq
		 * @date : 2017. 04. 06
		 * @author : mjpyo
		 * @description : FAQ 마스터 등록
		 */
		@RequestMapping(value = "/insertMasterFaq.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto insertMasterFaq(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqInsertReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.insertMasterFaq(reqDTO);
		}
		
		
		/**
		 * @name : getFaqMasterDetail
		 * @date : 2017. 04. 06
		 * @author : mjpyo
		 * @description : FAQ 마스터 상세
		 */
		@RequestMapping(value = "/getFaqMasterDetail.do", method = RequestMethod.POST)
		public @ResponseBody LoyFaqDetailResDto getFaqMasterDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqDetailReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.getFaqMasterDetail(reqDTO);
		}
		
		/**
		* @programId :
		* @name : removeFaq
		* @date : 2019. 7. 24.
		* @author : dw.keum
		* @table :
		* @return : StatusResDto
		* @description : FAQ 삭제
		*/
		@RequestMapping(value = "/removeFaq.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto removeFaq(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFaqInsertReqDto reqDTO) {
			LogUtil.param(this.getClass(), reqDTO);
			reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyFaqService.removeFaq(reqDTO);
		}
			
		
		  /**
		* @programId :
		* @name : uploadExcelFaq
		* @date : 2019. 11. 28.
		* @author : hr.noh
		* @table :
		* @return : ResponseEntity
		* @description :
		*/
		@RequestMapping(value="/uploadExcelFaq.do", method = RequestMethod.POST)
		@ResponseBody
		public ResponseEntity  uploadExcelPnt(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
			authHelper.checkLoginSession(request.getSession(true));
			BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
			List<LoyFaqUploadReqDto> batchUpload = new ArrayList<LoyFaqUploadReqDto>() ;
			StatusResDto rtnValue = new StatusResDto();
			LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
			LoyFaqUploadReqDto br = new LoyFaqUploadReqDto();
			MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
			
			String[] rs = mptRequest.getParameterValues("param");
			String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
			JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
			JSONObject obj  = (JSONObject) json.get("data");
			
			String rid = CommonUtil.newRid();
			
			try {
				batchUpload = excelUpld.FaqUploadData( request, false, rid);
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
					
					rtnValue = loyFaqService.FaqUploadData(br);
					rtnValue.setMessage("저장되었습니다.");
				}
			} else {
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
		* @programId :
		* @name : faqExcelDownload
		* @date : 2019. 11. 28.
		* @author : hr.noh
		* @table :
		* @return : LOYFaqUploadRequestDTO
		* @description : FAQ 전체 엑셀다운
		*/
		@RequestMapping(value = "/faqExcelDownload.do", method = RequestMethod.POST)
		public String faqExcelDownload(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyFaqUploadReqDto reqDto , ModelMap model) {
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
			
			GridPagingResDto<LoyFaqUploadResDto>  data = loyFaqService.getFaqDetailList(reqDto);
			
			ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
			edlr.setSystemColumn(reqDto.getSystemColumn());
			edlr.setTargetId(null);
			loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.FAG_DETAIL_LIST);

			model.addAttribute("result", data);
			model.addAttribute("excelHeader", reqDto.getExcelHeader());
			model.addAttribute("fileName", "FAQ 상세 리스트");

			return "ExcelView";
		}
		
		/**
		* @programId :
		* @name : faqExcelDownloadGrid
		* @date : 2019. 12. 02.
		* @author : hr.noh
		* @table :
		* @return : LOYFaqUploadRequestDTO
		* @description : FAQ 전체 다운로드하기위한 리스트
		*/
		
	    @RequestMapping(value="/faqExcelDownList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyFaqUploadResDto> getMbrCardList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyFaqUploadReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyFaqService.getfaqExcelDownList(reqDto);
	    }
		

}
