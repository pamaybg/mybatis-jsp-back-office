package com.icignal.systemmanagement.log.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.auth.service.AuthCommonService;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.log.dto.request.SystemExcelDownloadLogReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemLoginHistoryReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemServiceReqLogReqDto;
import com.icignal.systemmanagement.log.dto.response.SystemAuthLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemCondLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemExcelDownloadLogResDto;
import com.icignal.systemmanagement.log.dto.response.SystemLoginHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemPiMaskDecListResDto;
import com.icignal.systemmanagement.log.service.SystemLogSerivce;

/*
 * 1. 클래스명	: SystemLogController
 * 2. 파일명	: SystemLogController.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		개인정보 취급이력 Controller
 *		Personal information handling history
 * </PRE>
 */ 
@Controller
@RequestMapping("/common/log")
public class SystemLogController extends BaseController{
	
	@Autowired
	private SystemLogSerivce systemLogService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Autowired
	AuthCommonService AuthCommonService;
	
	@Autowired
	CommonService commonService;

	@Autowired
	private LoggingHelper loggingHelper;

	 /*
	  * 1. 메소드명: getExcelDownloadLogList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: dg.ryu
	  * 4. 작성일자: 2017. 6. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 로그 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @table : com.com_excel_downl_log
	 *   @param edlr
	 *   @return	
	 */
	@RequestMapping(value = "/getExcelDownloadLogList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemExcelDownloadLogResDto> getExcelDownloadLogList(HttpServletRequest request,	HttpServletResponse response, @RequestBody SystemExcelDownloadLogReqDto edlr) {
		LogUtil.param(SystemLogController.class, edlr);

		authHelper.checkLoginSession(request, response);

		return systemLogService.getExcelDownloadLogList(edlr);
	}

	 /*
	  * 1. 메소드명: ExcelDownload
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 이력 조회 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param edlr
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/ExcelDownload.do", method = RequestMethod.POST)
	public String ExcelDownload(HttpServletRequest request, HttpServletResponse response,	@RequestBody SystemExcelDownloadLogReqDto edlr, ModelMap model) {
		LogUtil.param(SystemLogController.class, edlr);
		edlr.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<SystemExcelDownloadLogResDto> data = systemLogService.getExcelDownloadLogList(edlr);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", edlr.getExcelHeader());
		model.addAttribute("fileName", "엑셀 다운로드 이력");

		ExcelDownloadLogReqDto edl = new ExcelDownloadLogReqDto();
		edl.setSystemColumn(edlr.getSystemColumn());
		edl.setTargetId(edlr.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edl, EXCEL_DOWNLOAD_TYPE.EXCEL_DOWNLOAD_LOG_LIST);

		return "ExcelView";
	}

	 /*
	  * 1. 메소드명: getLoginHistoryList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2017. 6. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 이력 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @table : com.login_history
	 *   @param lhr
	 *   @return	
	 */
	@RequestMapping(value = "/getLoginHistoryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemLoginHistoryResDto> getLoginHistoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto lhr) {
		LogUtil.param(SystemLogController.class, lhr);

		authHelper.checkLoginSession(request, response);
		
		return systemLogService.getLoginHistoryList(lhr);
	}

	 /*
	  * 1. 메소드명: LoginHistoryDownload
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 이력 조회 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param lhr
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/LoginHistoryDownload.do", method = RequestMethod.POST)
	public String LoginHistoryDownload(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto lhr, ModelMap model) {
		LogUtil.param(SystemLogController.class, lhr);
		lhr.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<SystemLoginHistoryResDto> data = systemLogService.excelDownLoginHistoryList(lhr);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", lhr.getExcelHeader());
		model.addAttribute("fileName", "로그인 이력");

		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(lhr.getSystemColumn());
		edlr.setTargetId(lhr.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.LOGIN_HISTORY_LIST);

		return "ExcelView";
	}

	 /*
	  * 1. 메소드명: getCondLogHistoryList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: dw.keum
	  * 4. 작성일자: 2019. 01. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 조회조건 조회이력 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @table : com.login_history
	 *   @param clhr
	 *   @return	
	 */
	@RequestMapping(value = "/getCondLogHistoryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemCondLogHistoryResDto> getCondLogHistoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto clhr) {
		LogUtil.param(SystemLogController.class, clhr);

		authHelper.checkLoginSession(request, response);

		return systemLogService.getCondLogHistoryList(clhr);
	}
	


	 /*
	  * 1. 메소드명: condLogHistoryDownload
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 조회조건 이력 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param clhr
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/condLogHistoryDownload.do", method = RequestMethod.POST)
	public String condLogHistoryDownload(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto clhr, ModelMap model) {
		LogUtil.param(SystemLogController.class, clhr);
		clhr.setLoginInfo(authHelper.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);
		//프로그램 경로 가져오기
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
		ProgramCache proResDto = null;
		String ObjCode = clhr.getObjCode();
		//MetaData 가져오기
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
		
		//데이터 가져오기
		GridPagingResDto<SystemCondLogHistoryResDto> data = systemLogService.getCondLogTestList(clhr);
//		GridPagingResDto<SystemCondLogHistoryResDto> data = systemLogService.getCondLogHistoryList(clhr);

		model.addAttribute("result", data);
//		model.addAttribute("excelHeader", clhr.getExcelHeader());
//		model.addAttribute("fileName", "공통조회조건 조회 이력");

		//엑셀 로그
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(clhr.getSystemColumn());
		edlr.setTargetId(clhr.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.COND_LOG_HIST_LIST);

		return "ExcelView";
	}
	


	 /*
	  * 1. 메소드명: getAuthLogHistoryList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: dw.keum
	  * 4. 작성일자: 2019. 01. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 변경 이력 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @table : com.com_auth_log
	 *   @param alhr
	 *   @return	
	 */
	@RequestMapping(value = "/getAuthLogHistoryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthLogHistoryResDto> getAuthLogHistoryList(HttpServletRequest request, 	HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto alhr) {
		LogUtil.param(SystemLogController.class, alhr);

		authHelper.checkLoginSession(request, response);

		return systemLogService.getAuthLogHistoryList(alhr);
	}

	 /*
	  * 1. 메소드명: authLogHistoryDownload
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 변경 이력 조회 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param alhr
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/authLogHistoryDownload.do", method = RequestMethod.POST)
	public String authLogHistoryDownload(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto alhr, ModelMap model) {
		LogUtil.param(SystemLogController.class, alhr);
		alhr.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<SystemAuthLogHistoryResDto> data = systemLogService.getAuthLogHistoryList(alhr);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", alhr.getExcelHeader());
		model.addAttribute("fileName", "권한 변경 이력");

		//엑셀 다운로드 로그
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(alhr.getSystemColumn());
		edlr.setTargetId(alhr.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.AUTH_LOG_HISTORY_LIST);

		return "ExcelView";
	}

	 /*
	  * 1. 메소드명: editMbr
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: dg.ryu 
	  * 4. 작성일자: 2019. 7. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		서비스 요청 로그 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @table : com.com_service_req_log
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/addServiceReqLog.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemServiceReqLogReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return systemLogService.addServiceReqLog(request, reqDto);
	}

	 /*
	  * 1. 메소드명: getLoyOfferMstList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: yj.choi 
	  * 4. 작성일자: 2019. 11. 07.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		개인정보 마스킹 해지이력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getPiMaskDecList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemPiMaskDecListResDto> getLoyOfferMstList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);

		return systemLogService.getPiMaskDecList(param);
	}

	 /*
	  * 1. 메소드명: getPiMaskDecExcelDn
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 1. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		개인정보 마스킹해지이력 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value = "/getPiMaskDecExcelDn.do", method = RequestMethod.POST)
	public String getPiMaskDecExcelDn(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto param, ModelMap model) {

		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<SystemPiMaskDecListResDto> rtnValue = systemLogService.getPiMaskDecExcelDn(param);
		SystemExcelDownloadLogReqDto edlr = new SystemExcelDownloadLogReqDto();

		edlr.setSystemColumn(param.getSystemColumn());
		edlr.setTargetId(null);
		systemLogService.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.PI_MASKING_DEC_LIST);

		model.addAttribute("result", rtnValue);
		model.addAttribute("excelHeader", param.getExcelHeader());
		model.addAttribute("fileName", "개인정보 마스킹 해지이력");

		return "ExcelView";

	}
	
	 /*
	  * 1. 메소드명: clearMaskCondLogHistList
	  * 2. 클래스명: SystemLogController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		개인정보 조회이력 - 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/clearMaskCondLogHistList.do", method = RequestMethod.POST)
	public @ResponseBody SystemCondLogHistoryResDto clearMaskCondLogHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemLoginHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemLogService.clearMaskCondLogHistList(param);
	}
}
