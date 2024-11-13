package com.icignal.kepler.report.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.kepler.report.dto.request.KprReportCampaignReactionReqDto;
import com.icignal.kepler.report.dto.request.KprReportIncreaseMbrReqDto;
import com.icignal.kepler.report.dto.request.KprReportLnlReqDto;
import com.icignal.kepler.report.dto.request.KprReportPntReqDto;
import com.icignal.kepler.report.dto.request.KprReportRecommListReqDto;
import com.icignal.kepler.report.dto.request.KprReportReqDto;
import com.icignal.kepler.report.dto.request.KprReportStoreReqDto;
import com.icignal.kepler.report.dto.response.KprIncreaseMbrResDto;
import com.icignal.kepler.report.dto.response.KprReportAgeCdResDto;
import com.icignal.kepler.report.dto.response.KprReportAgoMonthDateResDto;
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
import com.icignal.kepler.report.dto.response.KprReportPointOfMonthResDto;
import com.icignal.kepler.report.dto.response.KprReportRecommListResDto;
import com.icignal.kepler.report.dto.response.KprReportSalCntAmtResDto;
import com.icignal.kepler.report.dto.response.KprReportSegMstListResDto;
import com.icignal.kepler.report.dto.response.KprReportStoreResDto;
import com.icignal.kepler.report.dto.response.KprReportTimesSalResDto;
import com.icignal.kepler.report.dto.response.KprReportTransResDto;
import com.icignal.kepler.report.dto.response.selectRecommReportExcelList;
import com.icignal.kepler.report.mapper.KprLoyReportMapper;
import com.icignal.loyalty.product.service.LoyProductService;

/*
 * 1. 클래스명	: KPRReportService
 * 2. 파일명	: KPRReportService.java
 * 3. 패키지명	: com.icignal.kepler.report.service
 * 4. 작성자명	: mj.kim
 * 5. 작성일자	: 2019. 4. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *		KPRReportService
 * </PRE>
 */ 
@Service("KprReportService")
public class KprReportService {

	@Autowired
	private KprLoyReportMapper kprLoyReportMapper;  //로이매퍼
	

}
