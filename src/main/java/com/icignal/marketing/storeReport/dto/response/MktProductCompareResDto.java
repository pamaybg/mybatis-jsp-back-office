package com.icignal.marketing.storeReport.dto.response;

import java.util.ArrayList;

public class MktProductCompareResDto {
	
	//클래스별 비중 차트
	private ArrayList<TuiBarChartSeriesDto> shopClassChart;
	private ArrayList<TuiBarChartSeriesDto> brandClassChart;
	//카테고리별 비중 차트	
	private ArrayList<TuiCategoryChartSeriesDto> shopCategoryChart;
	private ArrayList<TuiCategoryChartSeriesDto> brandCategoryChart;
	//전체TOP Item
	private ArrayList<TuiProductCompareGridDataDto> shopTopItemGrid;
	private ArrayList<TuiProductCompareGridDataDto> brandTopItemGrid;
	//전체LOW Item	
	private ArrayList<TuiProductCompareGridDataDto> shopLowItemGrid;
	private ArrayList<TuiProductCompareGridDataDto> brandLowItemGrid;
	//전체TOP Product
	private ArrayList<TuiProductCompareGridDataDto> shopTopProductGrid;
	private ArrayList<TuiProductCompareGridDataDto> brandTopProductGrid;
	//전체TOP 의류
	private ArrayList<TuiProductCompareGridDataDto> shopTopClass1Grid;
	private ArrayList<TuiProductCompareGridDataDto> brandTopClass1Grid;
	//전체TOP 용품
	private ArrayList<TuiProductCompareGridDataDto> shopTopClass2Grid;
	private ArrayList<TuiProductCompareGridDataDto> brandTopClass2Grid;
	//전체TOP 신발
	private ArrayList<TuiProductCompareGridDataDto> shopTopClass3Grid;
	private ArrayList<TuiProductCompareGridDataDto> brandTopClass3Grid;	
	
	//전체TOP 신발
	private ArrayList<TuiProductCompareSalesRatioGridDataDto> salesRatioTopItemGrid;
	private ArrayList<TuiProductCompareSalesRatioGridDataDto> salesRatioLowItemGrid;		
	
	public ArrayList<TuiBarChartSeriesDto> getShopClassChart() {
		return shopClassChart;
	}
	public void setShopClassChart(ArrayList<TuiBarChartSeriesDto> shopClassChart) {
		this.shopClassChart = shopClassChart;
	}
	public ArrayList<TuiBarChartSeriesDto> getBrandClassChart() {
		return brandClassChart;
	}
	public void setBrandClassChart(ArrayList<TuiBarChartSeriesDto> brandClassChart) {
		this.brandClassChart = brandClassChart;
	}
	public ArrayList<TuiCategoryChartSeriesDto> getShopCategoryChart() {
		return shopCategoryChart;
	}
	public void setShopCategoryChart(ArrayList<TuiCategoryChartSeriesDto> shopCategoryChart) {
		this.shopCategoryChart = shopCategoryChart;
	}
	public ArrayList<TuiCategoryChartSeriesDto> getBrandCategoryChart() {
		return brandCategoryChart;
	}
	public void setBrandCategoryChart(ArrayList<TuiCategoryChartSeriesDto> brandCategoryChart) {
		this.brandCategoryChart = brandCategoryChart;
	}

	public ArrayList<TuiProductCompareGridDataDto> getShopTopItemGrid() {
		return shopTopItemGrid;
	}
	public void setShopTopItemGrid(ArrayList<TuiProductCompareGridDataDto> shopTopItemGrid) {
		this.shopTopItemGrid = shopTopItemGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandTopItemGrid() {
		return brandTopItemGrid;
	}
	public void setBrandTopItemGrid(ArrayList<TuiProductCompareGridDataDto> brandTopItemGrid) {
		this.brandTopItemGrid = brandTopItemGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getShopLowItemGrid() {
		return shopLowItemGrid;
	}
	public void setShopLowItemGrid(ArrayList<TuiProductCompareGridDataDto> shopLowItemGrid) {
		this.shopLowItemGrid = shopLowItemGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandLowItemGrid() {
		return brandLowItemGrid;
	}
	public void setBrandLowItemGrid(ArrayList<TuiProductCompareGridDataDto> brandLowItemGrid) {
		this.brandLowItemGrid = brandLowItemGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getShopTopProductGrid() {
		return shopTopProductGrid;
	}
	public void setShopTopProductGrid(ArrayList<TuiProductCompareGridDataDto> shopTopProductGrid) {
		this.shopTopProductGrid = shopTopProductGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandTopProductGrid() {
		return brandTopProductGrid;
	}
	public void setBrandTopProductGrid(ArrayList<TuiProductCompareGridDataDto> brandTopProductGrid) {
		this.brandTopProductGrid = brandTopProductGrid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getShopTopClass1Grid() {
		return shopTopClass1Grid;
	}
	public void setShopTopClass1Grid(ArrayList<TuiProductCompareGridDataDto> shopTopClass1Grid) {
		this.shopTopClass1Grid = shopTopClass1Grid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandTopClass1Grid() {
		return brandTopClass1Grid;
	}
	public void setBrandTopClass1Grid(ArrayList<TuiProductCompareGridDataDto> brandTopClass1Grid) {
		this.brandTopClass1Grid = brandTopClass1Grid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getShopTopClass2Grid() {
		return shopTopClass2Grid;
	}
	public void setShopTopClass2Grid(ArrayList<TuiProductCompareGridDataDto> shopTopClass2Grid) {
		this.shopTopClass2Grid = shopTopClass2Grid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandTopClass2Grid() {
		return brandTopClass2Grid;
	}
	public void setBrandTopClass2Grid(ArrayList<TuiProductCompareGridDataDto> brandTopClass2Grid) {
		this.brandTopClass2Grid = brandTopClass2Grid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getShopTopClass3Grid() {
		return shopTopClass3Grid;
	}
	public void setShopTopClass3Grid(ArrayList<TuiProductCompareGridDataDto> shopTopClass3Grid) {
		this.shopTopClass3Grid = shopTopClass3Grid;
	}
	public ArrayList<TuiProductCompareGridDataDto> getBrandTopClass3Grid() {
		return brandTopClass3Grid;
	}
	public void setBrandTopClass3Grid(ArrayList<TuiProductCompareGridDataDto> brandTopClass3Grid) {
		this.brandTopClass3Grid = brandTopClass3Grid;
	}
	public ArrayList<TuiProductCompareSalesRatioGridDataDto> getSalesRatioTopItemGrid() {
		return salesRatioTopItemGrid;
	}
	public void setSalesRatioTopItemGrid(ArrayList<TuiProductCompareSalesRatioGridDataDto> salesRatioTopItemGrid) {
		this.salesRatioTopItemGrid = salesRatioTopItemGrid;
	}
	public ArrayList<TuiProductCompareSalesRatioGridDataDto> getSalesRatioLowItemGrid() {
		return salesRatioLowItemGrid;
	}
	public void setSalesRatioLowItemGrid(ArrayList<TuiProductCompareSalesRatioGridDataDto> salesRatioLowItemGrid) {
		this.salesRatioLowItemGrid = salesRatioLowItemGrid;
	}
}
