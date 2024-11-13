package com.icignal.systemmanagement.storeReport.controller;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.auth.service.AuthCommonService;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.loyalty.membership.dto.request.LoyMbrReqDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrListNewPageResDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertListResDto;
import com.icignal.systemmanagement.storeReport.dto.request.StoreReportHistoryReqDto;
import com.icignal.systemmanagement.storeReport.dto.response.StoreReportHistoryResDto;
import com.icignal.systemmanagement.storeReport.service.StoreReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
 *		매장용 리포트 조회 이력 Controller
 *		Store Report Reference History
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/storeReport")
public class StoreReportController extends BaseController{
	
	@Autowired
	private StoreReportService storeReportService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Autowired
	AuthCommonService AuthCommonService;
	
	@Autowired
	CommonService commonService;

	@Autowired
	private LoggingHelper loggingHelper;

	/*
	 * 1. 메소드명: addStoreReportHist
	 * 2. 클래스명: StoreReportController
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 2. 28.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 메뉴 조회 이력 추가
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value = "/addStoreReportHist.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addStoreReportHist(HttpServletRequest request, HttpServletResponse response, @RequestBody StoreReportHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return storeReportService.addStoreReportHist(param);
	}

	/*
	 * 1. 메소드명: getStoreReportHistList
	 * 2. 클래스명: StoreReportController
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 2. 28.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 메뉴 조회 이력 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value = "/getStoreReportHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<StoreReportHistoryResDto> getStoreReportHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody StoreReportHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return storeReportService.getStoreReportHistList(param);
	}

	/*
	 * 1. 메소드명: getStoreReportHistExcelDown
	 * 2. 클래스명: StoreReportController
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 3. 7.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 조회 이력 액셀 다운로드
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return
	 */
	@RequestMapping(value = "/getStoreReportHistExcelDown.do", method = RequestMethod.POST)
	public String getStoreReportHistExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody StoreReportHistoryReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());

		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.STORE_REPORT_HISTORY_LIST);

		GridPagingResDto<StoreReportHistoryResDto> data = storeReportService.getStoreReportHistListForExcel(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "매장용 리포트 조회 이력");

		return "ExcelView";
	}
}
