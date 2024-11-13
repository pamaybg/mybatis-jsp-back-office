package com.icignal.kepler.report.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.kepler.report.dto.request.KprReportCampaignReactionReqDto;
import com.icignal.kepler.report.dto.request.KprReportIncreaseMbrReqDto;
import com.icignal.kepler.report.dto.request.KprReportLnlReqDto;
import com.icignal.kepler.report.dto.request.KprReportRecommListReqDto;
import com.icignal.kepler.report.dto.request.KprReportReqDto;
import com.icignal.kepler.report.dto.request.KprReportStoreReqDto;
import com.icignal.kepler.report.dto.response.KprIncreaseMbrResDto;
import com.icignal.kepler.report.dto.response.KprReportAgeCdResDto;
import com.icignal.kepler.report.dto.response.KprReportCampaignReactionResDto;
import com.icignal.kepler.report.dto.response.KprReportCrossDtlResDto;
import com.icignal.kepler.report.dto.response.KprReportCrossResDto;
import com.icignal.kepler.report.dto.response.KprReportDaysSalseResDto;
import com.icignal.kepler.report.dto.response.KprReportDoNotBuyMbrResDto;
import com.icignal.kepler.report.dto.response.KprReportEmpPntResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlCampaignResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlDayTierResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlMbrFlagResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlMbrPerformResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlOffPromResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlOrdCrossResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlOrdDayWeekResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlOrdPntResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlOrdProdResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlPathDeviceResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlTierMbrResDto;
import com.icignal.kepler.report.dto.response.KprReportLnlTotMbrResDto;
import com.icignal.kepler.report.dto.response.KprReportMbrCaseResDto;
import com.icignal.kepler.report.dto.response.KprReportMbrMonthSalResDto;
import com.icignal.kepler.report.dto.response.KprReportMonthSalseResDto;
import com.icignal.kepler.report.dto.response.KprReportOnlinePerfomExcelResDto;
import com.icignal.kepler.report.dto.response.KprReportOnlinePerfomResDto;
import com.icignal.kepler.report.dto.response.KprReportPntUseSaveResDto;
import com.icignal.kepler.report.dto.response.KprReportRecommListResDto;
import com.icignal.kepler.report.dto.response.KprReportSalCntAmtResDto;
import com.icignal.kepler.report.dto.response.KprReportSegMstListResDto;
import com.icignal.kepler.report.dto.response.KprReportStoreResDto;
import com.icignal.kepler.report.dto.response.KprReportTimesSalResDto;
import com.icignal.kepler.report.dto.response.KprReportTransResDto;
import com.icignal.kepler.report.dto.response.selectRecommReportExcelList;
import com.icignal.kepler.report.service.KprReportService;

/*
 * 1. 클래스명	: KprReportController
 * 2. 파일명	: KprReportController.java
 * 3. 패키지명	: com.icignal.kepler.report.controller
 * 4. 작성자명	: mj.kim
 * 5. 작성일자	: 2019. 4. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *		정형 레포트
 * </PRE>
 */ 
@Controller
@RequestMapping({ "/kepler/report" })
public class KprReportController extends CommonController {


	@Autowired
	private KprReportService kprReportService;
	
	@Autowired 
	private LoggingHelper loggingHelper;

	@Autowired
	AuthHelper authHelper;
}

