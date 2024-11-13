package com.icignal.marketing.storeReport.service;

import java.util.ArrayList;
import java.util.List;

import com.icignal.marketing.storeReport.dto.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.channel.mapper.LoyChannelMapper;
import com.icignal.marketing.storeReport.dto.request.MktStoreReportReqDto;
import com.icignal.marketing.storeReport.mapper.MktStoreReportMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;
import com.icignal.systemmanagement.commcode.mapper.SystemCommCodeMapper;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeReqDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeItemDto;
import com.icignal.systemmanagement.employee.mapper.SystemEmployeeMapper;


@Service
public class MktStoreReportService {
	@Autowired
	private MktStoreReportMapper mktStoreReportMapper;
	@Autowired
	private LoyChannelMapper loyChannelMapper;
	@Autowired
	private SystemCommCodeMapper systemCommCodeMapper;
	@Autowired
	private SystemEmployeeMapper systemEmployeeMapper;

	/**
	 * 브랜드 조회용 매장수 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	public Integer getShopCnt(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectShopCnt(reqDto);
	}
	
	/**
	 * 브랜드 조회용 매장수 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	public Integer getProductShopCnt(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectProductShopCnt(reqDto);
	}	

	/**
	 * 매장용 리포트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	public MktMbrCompareResDto getMbrCompareTotal(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto = mktStoreReportMapper.selectMbrCompareTotal(reqDto);
		else if (reqDto.getType().equals("brand")) 
			//brand조회
			resDto = mktStoreReportMapper.selectMbrCompareTotalBrand(reqDto);
		
		return resDto;		
	}

	/**
	 * 매장용 리포트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	public MktMbrCompareResDto getMbrCompare(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto = mktStoreReportMapper.selectMbrCompare(reqDto);
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto = mktStoreReportMapper.selectMbrCompareBrand(reqDto);
		
		return resDto;
	}

	/**
	 * 매장용 리포트 등급별 구성비 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 14.
	 */
	public MktMbrCompareResDto getMbrCompareGenderChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopGenderChart(mktStoreReportMapper.selectGenderChart(reqDto));
		else if (reqDto.getType().equals("brand")) 
			//brand조회
			resDto.setBrandGenderChart(mktStoreReportMapper.selectGenderChart(reqDto));
		
		return resDto;
	}

	/**
	 * 매장용 리포트 성별 연령 차트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 14.
	 */
	public MktMbrCompareResDto getMbrCompareAgeChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopAgeChart(mktStoreReportMapper.selectAgeChart(reqDto));
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto.setBrandAgeChart(mktStoreReportMapper.selectAgeChart(reqDto));
		
		return resDto;
	}	

	public MktProductCompareResDto getProductCompareClassChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopClassChart(mktStoreReportMapper.selectClassChart(reqDto));
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto.setBrandClassChart(mktStoreReportMapper.selectClassChart(reqDto));
		
		return resDto;
	}
	
	public MktProductCompareResDto getProductCompareCategoryChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopCategoryChart(mktStoreReportMapper.selectCategoryChart(reqDto));
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto.setBrandCategoryChart(mktStoreReportMapper.selectCategoryChart(reqDto));
		
		return resDto;
	}	

	public MktRepeatBreakawayResDto getRepeatBreakaway(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectRepeatBreakaway(reqDto);
	}
	
	public MktRepeatBreakawayResDto getRepeatBreakawayBrand(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectRepeatBreakawayBrand(reqDto);
	}	
	
	public MktRepeatBreakawayResDto getRepeatBreakawayGradeChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktRepeatBreakawayResDto resDto = new MktRepeatBreakawayResDto();
		resDto.setGradeChart(mktStoreReportMapper.selectRepeatBreakawayGradeChart(reqDto));
		
		return resDto;
	}

	public MktRepeatBreakawayResDto getRepeatBreakawayGradeAgeChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktRepeatBreakawayResDto resDto = new MktRepeatBreakawayResDto();
		resDto.setAgeChart(mktStoreReportMapper.selectRepeatBreakawayGradeAgeChart(reqDto));
		
		return resDto;
	}

	public MktRepeatBreakawayResDto getRepeatBreakawayGenderGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktRepeatBreakawayResDto resDto = new MktRepeatBreakawayResDto();
		resDto.setGenderGrid(mktStoreReportMapper.selectRepeatBreakawayGenderGrid(reqDto));
		
		return resDto;
	}

	public MktRepeatBreakawayResDto getRepeatBreakawayAgeGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktRepeatBreakawayResDto resDto = new MktRepeatBreakawayResDto();
		resDto.setAgeGrid(mktStoreReportMapper.selectRepeatBreakawayAgeGrid(reqDto));
		
		return resDto;
	}

	public MktRepeatBreakawayResDto getRepeatBreakawayGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktRepeatBreakawayResDto resDto = new MktRepeatBreakawayResDto();
		resDto.setBreakawayGrid(mktStoreReportMapper.selectRepeatBreakawayGrid(reqDto));
		
		return resDto;
	}	

	public List<TuiStackBarChartSeriesDto> getSalesChange(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectSalesChange(reqDto);
	}

	public MktStoreReportResDto getBrandCode(String empId) {
		LogUtil.param(this.getClass(), empId);
		return loyChannelMapper.selectBrandCode(empId);
	}

	public MktMbrCompareResDto getMbrCompareGenderGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopGenderGrid(mktStoreReportMapper.selectGenderGrid(reqDto));
		else if (reqDto.getType().equals("brand")) 
			//brand조회
			resDto.setBrandGenderGrid(mktStoreReportMapper.selectGenderGrid(reqDto));
		
		return resDto;
	}

	public MktMbrCompareResDto getMbrCompareAgeGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktMbrCompareResDto resDto = new MktMbrCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopAgeGrid(mktStoreReportMapper.selectAgeGrid(reqDto));
		else if (reqDto.getType().equals("brand")) 
			//brand조회
			resDto.setBrandAgeGrid(mktStoreReportMapper.selectAgeGrid(reqDto));
		
		return resDto;
	}

	public MktProductCompareResDto getProductCompareTopItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopTopItemGrid(mktStoreReportMapper.selectTopItemGrid(reqDto));
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto.setBrandTopItemGrid(mktStoreReportMapper.selectTopItemGrid(reqDto));
		
		return resDto;
	}

	public MktProductCompareResDto getProductCompareLowItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		if (reqDto.getType().equals("shop"))
			//shop조회
			resDto.setShopLowItemGrid(mktStoreReportMapper.selectLowItemGrid(reqDto));
		else if (reqDto.getType().equals("brand"))
			//brand조회
			resDto.setBrandLowItemGrid(mktStoreReportMapper.selectLowItemGrid(reqDto));
		
		return resDto;
	}

	public MktProductCompareResDto getProductCompareTopProductGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		if (reqDto.getType().equals("shop")) {
			//shop조회
			resDto.setShopTopProductGrid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		}
			
		else if (reqDto.getType().equals("brand")) {
			//brand조회
			resDto.setBrandTopProductGrid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		}

		return resDto;
	}
	
	public MktProductCompareResDto getProductCompareProductGridTotal(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();

		//shop조회
		reqDto.setType("shop");
		resDto.setShopTopProductGrid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		reqDto.setProductClass("1");
		resDto.setShopTopClass1Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		reqDto.setProductClass("2");
		resDto.setShopTopClass2Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		reqDto.setProductClass("3");
		resDto.setShopTopClass3Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));			
		
		reqDto.setType("brand");
		reqDto.setProductClass("");
		resDto.setBrandTopProductGrid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		reqDto.setProductClass("1");
		resDto.setBrandTopClass1Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));			
		reqDto.setProductClass("2");
		resDto.setBrandTopClass2Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));
		reqDto.setProductClass("3");
		resDto.setBrandTopClass3Grid(mktStoreReportMapper.selectTopProductGrid(reqDto));
			
		return resDto;
	}	

	public List<MktSalesPerformanceResDto> getSalesPerformance(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktStoreReportMapper.selectSalesPerformance(reqDto);
	}

	public MktProductCompareResDto getProductCompareSalesRatioItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		//상위 조회
		reqDto.setType("top");
		resDto.setSalesRatioTopItemGrid(mktStoreReportMapper.selectSalesRatioItemGrid(reqDto));
		//하위 조회
		reqDto.setType("low");
		resDto.setSalesRatioLowItemGrid(mktStoreReportMapper.selectSalesRatioItemGrid(reqDto));
		
		return resDto;
	}

	public MktProductCompareResDto getProductCompareSalesRatioTopItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		//상위 조회
		reqDto.setType("top");
		resDto.setSalesRatioTopItemGrid(mktStoreReportMapper.selectSalesRatioItemGrid(reqDto));
		
		return resDto;
	}

	public MktProductCompareResDto getProductCompareSalesRatioLowItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		MktProductCompareResDto resDto = new MktProductCompareResDto();
		
		//하위 조회
		reqDto.setType("low");
		resDto.setSalesRatioLowItemGrid(mktStoreReportMapper.selectSalesRatioItemGrid(reqDto));
		
		return resDto;
	}

	public MktDurationCompareResDto getDurCmpPieChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		resDto.setDurCmpPieChart(mktStoreReportMapper.selectDurCmpPieChart(reqDto));

		return resDto;
	}

	public MktDurationCompareResDto getDurCmpAgeChart(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		resDto.setDurCmpAgeChart(mktStoreReportMapper.selectDurCmpAgeChart(reqDto));

		return resDto;
	}

	public MktDurationCompareResDto getDurCmpPurTotalGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		resDto.setDurCmpPurTotalGrid(mktStoreReportMapper.selectDurCmpPurTotalGrid(reqDto));

		return resDto;
	}


	public MktDurationCompareResDto getDurCmpPurMbrGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		ArrayList<TuiDurationCompareGridDataDto> durCmpPurMbrGrid = mktStoreReportMapper.selectDurCmpPurMbrGrid(reqDto);
		ArrayList<TuiDurationCompareGridDataDto> newMbrCntList = mktStoreReportMapper.selectDupCmpNewMbr(reqDto);

		TuiDurationCompareGridDataDto stdPurMbr = durCmpPurMbrGrid.get(0);
		TuiDurationCompareGridDataDto cmpPurMbr = durCmpPurMbrGrid.get(1);

		stdPurMbr.setNewMbrCnt(newMbrCntList.get(0).getNewMbrCnt());
		cmpPurMbr.setNewMbrCnt(newMbrCntList.get(1).getNewMbrCnt());

		durCmpPurMbrGrid.set(0, stdPurMbr);
		durCmpPurMbrGrid.set(1, cmpPurMbr);

		resDto.setDurCmpPurMbrGrid(durCmpPurMbrGrid);

		return resDto;
	}

	public MktDurationCompareResDto getDurCmpTopItemGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		resDto.setDurCmpTopItemGrid(mktStoreReportMapper.selectDurCmpTopItemGrid(reqDto));

		return resDto;
	}

	public MktDurationCompareResDto getDurCmpTopProductGrid(MktStoreReportReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		MktDurationCompareResDto resDto = new MktDurationCompareResDto();

		resDto.setDurCmpTopProductGrid(mktStoreReportMapper.selectDurCmpTopProductGrid(reqDto));

		return resDto;
	}

	public GridPagingResDto<SystemCommCodeExGridResDto> getReportBrandList(MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<SystemCommCodeExGridResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemCommCodeMapper.selectReportBrandList(reqDto));
	}


	public GridPagingResDto<SystemEmployeeItemDto> getReportBrandStoreList(SystemEmployeeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<SystemEmployeeItemDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.selectReportBrandStoreList(reqDto));
	}

}
