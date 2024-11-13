package com.icignal.kepler.report.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.report.dto.request.KprReportCampaignReactionReqDto;
import com.icignal.kepler.report.dto.request.KprReportLnlReqDto;
import com.icignal.kepler.report.dto.request.KprReportPntReqDto;
import com.icignal.kepler.report.dto.request.KprReportRecommListReqDto;
import com.icignal.kepler.report.dto.request.KprReportReqDto;
import com.icignal.kepler.report.dto.request.KprReportStoreReqDto;
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
import com.icignal.kepler.report.dto.response.KprReportPntUseSaveResDto;
import com.icignal.kepler.report.dto.response.KprReportPointOfMonthResDto;
import com.icignal.kepler.report.dto.response.KprReportRecommListResDto;
import com.icignal.kepler.report.dto.response.KprReportSalCntAmtResDto;
import com.icignal.kepler.report.dto.response.KprReportSegMstListResDto;
import com.icignal.kepler.report.dto.response.KprReportStoreResDto;
import com.icignal.kepler.report.dto.response.KprReportTimesSalResDto;
import com.icignal.kepler.report.dto.response.KprReportTransResDto;
import com.icignal.kepler.report.dto.response.selectRecommReportExcelList;

/*
 * 1. 클래스명	: KprLoyReportMapper
 * 2. 파일명	: KprLoyReportMapper.java
 * 3. 패키지명	: com.icignal.kepler.report.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명  loyMapper
 *
 * </PRE>
 */ 
@Mapper
public interface KprLoyReportMapper {

	List<KprReportStoreResDto> selectStoreList(KprReportStoreReqDto reqDto);

	KprReportAgeCdResDto selectAgeList(KprReportStoreReqDto reqDto);

	List<KprReportAgeCdResDto> testList(KprReportStoreReqDto reqDto);

	List<KprReportDaysSalseResDto> selectDaysSal(KprReportReqDto reqDto);

	List<KprReportMonthSalseResDto> selectMonthSal(KprReportReqDto reqDto);

	List<KprReportDoNotBuyMbrResDto> selectNoneBuyMbr(KprReportReqDto reqDto);

	List<KprReportTimesSalResDto> selectTimesSal(KprReportReqDto reqDto);

	KprReportAgoMonthDateResDto selectAgoMonth(KprReportReqDto reqDto);

	List<KprReportMbrCaseResDto> selectmbrCaseList(KprReportReqDto reqDto);

	List<KprReportPntUseSaveResDto> selectPntSaveUseList(KprReportReqDto reqDto);

	List<KprReportMbrMonthSalResDto> selectMbrMonthSalList(KprReportReqDto reqDto);

	List<KprReportSalCntAmtResDto> selectSalCntAmtList(KprReportReqDto reqDto);

	List<KprReportCampaignReactionResDto> selectCampaignChnReactionList(
			KprReportCampaignReactionReqDto reqDto);

	List<KprReportCampaignReactionResDto> selectCampaignExeInfoList(KprReportCampaignReactionReqDto reqDto);

	List<KprReportCampaignReactionResDto> selectCampaignExeInfo(KprReportCampaignReactionReqDto reqDto);

	List<KprReportCampaignReactionResDto> selectSendCampaignInfo(KprReportCampaignReactionReqDto reqDto);

	List<KprReportCampaignReactionResDto> selectPurReactionRate(KprReportCampaignReactionReqDto reqDto);

	List<String> selectColList(KprReportReqDto reqDto);

	List<KprReportTransResDto> selectTransReport2(KprReportReqDto reqDto);
	
	List<KprReportCrossResDto> selectCrossReport(KprReportReqDto reqDto);

	List<String> selectColList2(KprReportReqDto reqDto);

	List<KprReportCrossResDto> selectIncReport(KprReportReqDto reqDto);

	List<KprReportCrossDtlResDto.preMonVal> selectPreMonVal(KprReportReqDto reqDto);

	List<KprReportCrossDtlResDto> selectCrossDtlReport(KprReportReqDto reqDto);

	List<KprReportSegMstListResDto> selectSegMstList(KprReportReqDto reqDto);

	List<KprReportLnlTotMbrResDto> selectTotMbrList(KprReportLnlReqDto reqDto);

	List<KprReportLnlTotMbrResDto> selectKprChnlList(KprReportLnlReqDto reqDto);

	List<KprReportLnlMbrFlagResDto> selectMbrFlagList(KprReportLnlReqDto reqDto);

	List<KprReportLnlMbrPerformResDto> selectMbrPerformList(KprReportLnlReqDto reqDto);

	List<KprReportLnlTotMbrResDto> selectTotMbrExcelList(KprReportLnlReqDto reqDto);

	List<KprReportLnlMbrFlagResDto> selectMbrFlagExcelList(KprReportLnlReqDto reqDto);

	List<KprReportLnlMbrPerformResDto> selectMbrPerformExcelList(KprReportLnlReqDto reqDto);

	List<KprReportLnlTierMbrResDto> selectTierMbrList(KprReportLnlReqDto reqDto);

	List<KprReportLnlTierMbrResDto> selectTierMbrExcelList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdPntResDto> selectOrdPntList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdPntResDto> selectOrdPntExcelList(KprReportLnlReqDto reqDto);

	List<KprReportLnlDayTierResDto> selectDayTierSaleList(KprReportLnlReqDto reqDto);

	List<KprReportLnlDayTierResDto> dayTierListExcelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlCampaignResDto> selectCamTotList(KprReportLnlReqDto reqDto);

	List<KprReportLnlCampaignResDto> selectKprCamlList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdDayWeekResDto> selectOrdDayWeekList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdDayWeekResDto> selectOrdAgeList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdProdResDto> selectOrdProdList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdProdResDto> ordProdListExelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdCrossResDto> selectOrdCrossList(KprReportLnlReqDto reqDto);

	List<KprReportLnlDayTierResDto> selectDayTierSaleList2(KprReportLnlReqDto reqDto);

	List<KprReportLnlPathDeviceResDto> selectPathDeviceList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOffPromResDto> selectOffPromList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdCrossResDto> ordCrossExcelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlOffPromResDto> selectKprPromList(KprReportLnlReqDto reqDto);

	List<KprReportLnlOffPromResDto> offPromExcelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdDayWeekResDto> ordDayWeekExcelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdDayWeekResDto> ordAgeExcelDown(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdDayWeekResDto> selectOrdAgeList2(KprReportLnlReqDto reqDto);

	List<KprReportLnlOrdPntResDto> selectOrdPntList2(KprReportLnlReqDto reqDto);

	List<KprReportLnlMbrPerformResDto> getMbrPerformList2(KprReportLnlReqDto reqDto);

	List<KprReportRecommListResDto> selectRecommReportList(KprReportRecommListReqDto reqDto);

	List<KprReportRecommListResDto> selectRecommendedPersonList(KprReportRecommListReqDto reqDto);

	List<KprReportPointOfMonthResDto> selectMonthOfPoint(KprReportPntReqDto reqDto);

	List<KprReportEmpPntResDto> selectEmpAggPntReport(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectStoreAggPntReport(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectStoreAggPntReport2(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectStoreEmpAggPntReport(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectStoreEmpAggPntReport2(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectEmpAggPntReportExcel(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectStoreAggPntReportExcel(KprReportLnlReqDto reqDto);

	List<KprReportEmpPntResDto> selectEmpAggUsePntReport(KprReportLnlReqDto reqDto);

	 /*
	  * 1. 메소드명: selectRecommReportExcelList
	  * 2. 클래스명: KprLoyReportMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<selectRecommReportExcelList> selectRecommReportExcelList(KprReportRecommListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectRecommReportExcelList
	  * 2. 클래스명: KprLoyReportMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	



	
}
