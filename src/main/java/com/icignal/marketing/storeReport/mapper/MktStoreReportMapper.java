/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: MktStoreReportMapper.java
 * 2. Package	: com.icignal.marketing.storeReport.mapper
 * 3. Comments	:	
 * 4. Author	: ps.lee
 * 5. DateTime	: 2022. 3. 1.
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022. 3. 1.		 | ps.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.marketing.storeReport.mapper;

import java.util.ArrayList;
import java.util.List;

import com.icignal.core.annotation.handler.BoMartMapper;
import com.icignal.marketing.storeReport.dto.request.MktStoreReportReqDto;
import com.icignal.marketing.storeReport.dto.response.*;

/*
 * 1. 클래스명	: MktStoreReportMapper
 * 2. 파일명	: MktStoreReportMapper.java
 * 3. 패키지명	: com.icignal.marketing.storeReport.mapper
 * 4. 작성자명	: ps.lee
 * 5. 작성일자	: 2022. 3. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@BoMartMapper
public interface MktStoreReportMapper {
	
	Integer selectShopCnt(MktStoreReportReqDto reqDto);
	
	//1. 회원 비교 
	MktMbrCompareResDto selectMbrCompareTotal(MktStoreReportReqDto reqDto);
	MktMbrCompareResDto selectMbrCompareTotalBrand(MktStoreReportReqDto reqDto);
	MktMbrCompareResDto selectMbrCompare(MktStoreReportReqDto reqDto);
	MktMbrCompareResDto selectMbrCompareBrand(MktStoreReportReqDto reqDto);
	ArrayList<TuiBarChartSeriesDto> selectGenderChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiAgeChartSeriesDto> selectAgeChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiMbrCompareGridDataDto> selectGenderGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiMbrCompareGridDataDto> selectAgeGrid(MktStoreReportReqDto reqDto);	
	//1. 회원 비교
	
	//2. 상품 비교
	Integer selectProductShopCnt(MktStoreReportReqDto reqDto);
	ArrayList<TuiBarChartSeriesDto> selectClassChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiCategoryChartSeriesDto> selectCategoryChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiProductCompareGridDataDto> selectTopItemGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiProductCompareGridDataDto> selectLowItemGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiProductCompareGridDataDto> selectTopProductGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiProductCompareSalesRatioGridDataDto> selectSalesRatioItemGrid(MktStoreReportReqDto reqDto);
	//2. 상품 비교
	
	//3. 재구매&이탈 분석
	MktRepeatBreakawayResDto selectRepeatBreakaway(MktStoreReportReqDto reqDto);
	MktRepeatBreakawayResDto selectRepeatBreakawayBrand(MktStoreReportReqDto reqDto);
	ArrayList<TuiBarChartSeriesDto> selectRepeatBreakawayGradeChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiAgeChartSeriesDto> selectRepeatBreakawayGradeAgeChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiMbrCompareGridDataDto> selectRepeatBreakawayGenderGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiMbrCompareGridDataDto> selectRepeatBreakawayAgeGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiRepeatBreakawayGridDataDto> selectRepeatBreakawayGrid(MktStoreReportReqDto reqDto);
	//3. 재구매&이탈 분석
	
	//4. 최근12개월 매출 추이
	List<TuiStackBarChartSeriesDto> selectSalesChange(MktStoreReportReqDto reqDto);
	//4. 최근12개월 매출 추이

	//5. 등급별 회원 & 매출 성과
	List<MktSalesPerformanceResDto> selectSalesPerformance(MktStoreReportReqDto reqDto);
	//5. 등급별 회원 & 매출 성과

	//6. 구간 비교
	ArrayList<TuiBarChartSeriesDto> selectDurCmpPieChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiAgeChartSeriesDto> selectDurCmpAgeChart(MktStoreReportReqDto reqDto);
	ArrayList<TuiDurationCompareGridDataDto> selectDurCmpPurTotalGrid(MktStoreReportReqDto reqDto);

	ArrayList<TuiDurationCompareGridDataDto> selectDurCmpPurMbrGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiDurationCompareGridDataDto> selectDupCmpNewMbr(MktStoreReportReqDto reqDto);
	ArrayList<TuiDurationCompareGridDataDto> selectDurCmpTopItemGrid(MktStoreReportReqDto reqDto);
	ArrayList<TuiDurationCompareGridDataDto> selectDurCmpTopProductGrid(MktStoreReportReqDto reqDto);
	//6. 구간 비교
}
