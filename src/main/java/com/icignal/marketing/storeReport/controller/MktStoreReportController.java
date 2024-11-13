package com.icignal.marketing.storeReport.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.marketing.storeReport.dto.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.storeReport.dto.request.MktStoreReportReqDto;
import com.icignal.marketing.storeReport.service.MktStoreReportService;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeReqDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeItemDto;


@Controller
@RequestMapping("/marketing/storeReport")
public class MktStoreReportController extends BaseController{
	
	@Autowired
	private MktStoreReportService mktStoreReportService;
	
	/**
	 * 매장코드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 8.
	 */
	@RequestMapping(value="/getBrandCode.do", method = RequestMethod.POST)
	public @ResponseBody MktStoreReportResDto getBrandCode(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);
		
		return mktStoreReportService.getBrandCode(reqDto.getEmpId());
	}
	
	/**
	 * 브랜드 조회용 매장수 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 16.
	 */
	@RequestMapping(value="/getShopCnt.do", method = RequestMethod.POST)
	public @ResponseBody Integer getShopCnt(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);
		
		return mktStoreReportService.getShopCnt(reqDto);
	}	

	/**
	 * 매장용 리포트 > 회원 비교 전체
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/getMbrCompareTotal.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompareTotal(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompareTotal(reqDto);
	}

	/**
	 * 매장용 리포트 > 회원 비교 > 회원
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/getMbrCompare.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompare(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompare(reqDto);
	}

	/**
	 * 매장용 리포트 > 회원 비교 > 등급별 구성비 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 14.
	 */
	@RequestMapping(value="/getMbrCompareGenderChart.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompareGenderChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompareGenderChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 회원 비교 > 성별 연령 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 14.
	 */
	@RequestMapping(value="/getMbrCompareAgeChart.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompareAgeChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompareAgeChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 회원 비교 > 등급별 구성비 그리드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 17.
	 */
	@RequestMapping(value="/getMbrCompareGenderGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompareGenderGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompareGenderGrid(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 회원 비교 > 성별 연령 그리드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 17.
	 */
	@RequestMapping(value="/getMbrCompareAgeGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktMbrCompareResDto getMbrCompareAgeGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getMbrCompareAgeGrid(reqDto);
	}	
	
	/**
	 * 매장용 리포트 > 상품 비교 > 브랜드 조회용 매장수 조회
	 *
	 * @author ps.lee
	 * @since 2022. 5. 12.
	 */
	@RequestMapping(value="/getProductShopCnt.do", method = RequestMethod.POST)
	public @ResponseBody Integer getProductShopCnt(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);
		
		return mktStoreReportService.getProductShopCnt(reqDto);
	}		
		
	/**
	 * 매장용 리포트 > 상품 비교 > 클래스 비중 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 15.
	 */
	@RequestMapping(value="/getProductCompareClassChart.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareClassChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareClassChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 상품 비교 > 카테고리 비중 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 18.
	 */
	@RequestMapping(value="/getProductCompareCategoryChart.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareCategoryChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareCategoryChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 상품 비교 > 전체TOP아이템 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 18.
	 */
	@RequestMapping(value="/getProductCompareTopItemGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareTopItemGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareTopItemGrid(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 상품 비교 > 전체LOW아이템 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 18.
	 */
	@RequestMapping(value="/getProductCompareLowItemGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareLowItemGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareLowItemGrid(reqDto);
	}

	/**
	 * 매장용 리포트 > 상품 비교 > 브랜드별 평균 아이템 판매율 대비 TOP
	 *
	 * @author ps.lee
	 * @since 2022. 4. 1.
	 */
	@RequestMapping(value="/getProductCompareSalesRatioTopItemGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareSalesRatioTopItemGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareSalesRatioTopItemGrid(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 상품 비교 > 브랜드별 평균 아이템 판매율 대비 LOW
	 *
	 * @author ps.lee
	 * @since 2022. 4. 1.
	 */
	@RequestMapping(value="/getProductCompareSalesRatioLowItemGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareSalesRatioLowItemGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareSalesRatioLowItemGrid(reqDto);
	}	
	
	/**
	 * 매장용 리포트 > 상품 비교 > TOP 상품 조회 ( 전체 / productClass:1 의류 / productClass:2 신발 / productClass:3 용품 )
	 *
	 * @author ps.lee
	 * @since 2022. 3. 18.
	 */
	@RequestMapping(value="/getProductCompareTopProductGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareTopProductGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareTopProductGrid(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 상품 비교 > 상품 전체 조회 
	 *
	 * @author ps.lee
	 * @since 2022. 3. 31.
	 */
	@RequestMapping(value="/getProductCompareProductGridTotal.do", method = RequestMethod.POST)
	public @ResponseBody MktProductCompareResDto getProductCompareProductGridTotal(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getProductCompareProductGridTotal(reqDto);
	}	
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 회원가치
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/getRepeatBreakaway.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakaway(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakaway(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 회원가치(브랜드)
	 *
	 * @author ps.lee
	 * @since 2022. 5. 13.
	 */
	@RequestMapping(value="/getRepeatBreakawayBrand.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayBrand(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayBrand(reqDto);
	}	
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 등급별 구성비 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 4. 5.
	 */
	@RequestMapping(value="/getRepeatBreakawayGradeChart.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayGradeChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayGradeChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 성별 연령 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 4. 5.
	 */
	@RequestMapping(value="/getRepeatBreakawayGradeAgeChart.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayGradeAgeChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayGradeAgeChart(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 성별 등급 그리드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 4. 5.
	 */
	@RequestMapping(value="/getRepeatBreakawayGenderGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayGenderGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayGenderGrid(reqDto);
	}	
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 연령 등급 그리드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 4. 5.
	 */
	@RequestMapping(value="/getRepeatBreakawayAgeGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayAgeGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayAgeGrid(reqDto);
	}
	
	/**
	 * 매장용 리포트 > 재구매&이탈 분석 > 이탈 예상 고객수 그리드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 4. 5.
	 */
	@RequestMapping(value="/getRepeatBreakawayGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktRepeatBreakawayResDto getRepeatBreakawayGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getRepeatBreakawayGrid(reqDto);
	}	
	
	/**
	 * 매장용 리포트 최근 12개월 매출 추이
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/getSalesChange.do", method = RequestMethod.POST)
	public @ResponseBody
	List<TuiStackBarChartSeriesDto> getMktTierSalesRatio(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getSalesChange(reqDto);
	}
	
	/**
	 * 매장용 리포트 등급별 회원 & 매출성과
	 *
	 * @author ps.lee
	 * @since 2022. 3. 23.
	 */
	@RequestMapping(value="/getSalesPerformance.do", method = RequestMethod.POST)
	public @ResponseBody List<MktSalesPerformanceResDto> getSalesPerformance(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);	
		
		return mktStoreReportService.getSalesPerformance(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 기간 파이 차트 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpPieChart.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpPieChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpPieChart(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 기간 성별 연령 차트 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpAgeChart.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpAgeChart(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpAgeChart(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 전체성과 기간 비교 그리드 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpPurTotalGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpPurTotalGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpPurTotalGrid(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 회원성과 기간 비교 그리드 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpPurMbrGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpPurMbrGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpPurMbrGrid(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 아이템 TOP 10개 성과 비교 그리드 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpTopItemGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpTopItemGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpTopItemGrid(reqDto);
	}

	/**
	 * 매장용 리포트 > 구간 비교 > 상품 TOP 10개 성과 비교 그리드 조회
	 *
	 * @author bg.yoon
	 * @since 2023. 8. 28.
	 */
	@RequestMapping(value="/getDurCmpTopProductGrid.do", method = RequestMethod.POST)
	public @ResponseBody MktDurationCompareResDto getDurCmpTopProductGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody MktStoreReportReqDto reqDto) {
		LogUtil.param(MktStoreReportController.class,reqDto);

		return mktStoreReportService.getDurCmpTopProductGrid(reqDto);
	}

	/**
	 * 매장용 리포트 브랜드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 23.
	 */
	@RequestMapping(value="/getReportBrandList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemCommCodeExGridResDto> getReportBrandList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return mktStoreReportService.getReportBrandList(reqDto);
	}

	/**
	 * 매장용 리포트 브랜드 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 23.
	 */
	@RequestMapping(value="/getReportBrandStoreList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemEmployeeItemDto> getReportBrandStoreList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEmployeeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return mktStoreReportService.getReportBrandStoreList(reqDto);
	}
}