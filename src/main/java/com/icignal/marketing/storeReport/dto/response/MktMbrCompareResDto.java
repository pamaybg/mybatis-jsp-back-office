package com.icignal.marketing.storeReport.dto.response;

import java.math.BigInteger;
import java.util.ArrayList;

public class MktMbrCompareResDto {
	
	private BigInteger shopTotalSales;
	private Integer shopUnitSales;
	private float shopUnitSalesPrice;
	
	private BigInteger brandTotalSales;
	private Integer brandUnitSales;
	private float brandUnitSalesPrice;	
	
	private float shopMemSales;
	private Integer shopTotalMemCnt;
	private Integer shopNewMemCnt;
	private Integer shopCustomerCnt;
	private float shopAverageCnt;
	private Integer shopAveragePrice;
	
	private float brandMemSales;
	private Integer brandTotalMemCnt;
	private Integer brandNewMemCnt;
	private Integer brandCustomerCnt;
	private float brandAverageCnt;
	private Integer brandAveragePrice;
	
	private float shopNonMemSales;
	private float brandNonMemSales;
	
	private ArrayList<TuiBarChartSeriesDto> shopGenderChart;
	private ArrayList<TuiBarChartSeriesDto> brandGenderChart;
	
	private ArrayList<TuiAgeChartSeriesDto> shopAgeChart;
	private ArrayList<TuiAgeChartSeriesDto> brandAgeChart;
	
	private ArrayList<TuiMbrCompareGridDataDto> shopGenderGrid;
	private ArrayList<TuiMbrCompareGridDataDto> brandGenderGrid;
	
	private ArrayList<TuiMbrCompareGridDataDto> shopAgeGrid;
	private ArrayList<TuiMbrCompareGridDataDto> brandAgeGrid;	
	

	public Integer getShopUnitSales() {
		return shopUnitSales;
	}
	public void setShopUnitSales(Integer shopUnitSales) {
		this.shopUnitSales = shopUnitSales;
	}
	public float getShopUnitSalesPrice() {
		return shopUnitSalesPrice;
	}
	public void setShopUnitSalesPrice(float shopUnitSalesPrice) {
		this.shopUnitSalesPrice = shopUnitSalesPrice;
	}
	public Integer getBrandUnitSales() {
		return brandUnitSales;
	}
	public void setBrandUnitSales(Integer brandUnitSales) {
		this.brandUnitSales = brandUnitSales;
	}
	public float getBrandUnitSalesPrice() {
		return brandUnitSalesPrice;
	}
	public void setBrandUnitSalesPrice(float brandUnitSalesPrice) {
		this.brandUnitSalesPrice = brandUnitSalesPrice;
	}
	public float getShopMemSales() {
		return shopMemSales;
	}
	public void setShopMemSales(float shopMemSales) {
		this.shopMemSales = shopMemSales;
	}
	public Integer getShopTotalMemCnt() {
		return shopTotalMemCnt;
	}
	public void setShopTotalMemCnt(Integer shopTotalMemCnt) {
		this.shopTotalMemCnt = shopTotalMemCnt;
	}
	public Integer getShopNewMemCnt() {
		return shopNewMemCnt;
	}
	public void setShopNewMemCnt(Integer shopNewMemCnt) {
		this.shopNewMemCnt = shopNewMemCnt;
	}
	public Integer getShopCustomerCnt() {
		return shopCustomerCnt;
	}
	public void setShopCustomerCnt(Integer shopCustomerCnt) {
		this.shopCustomerCnt = shopCustomerCnt;
	}
	public float getBrandMemSales() {
		return brandMemSales;
	}
	public void setBrandMemSales(float brandMemSales) {
		this.brandMemSales = brandMemSales;
	}
	public Integer getBrandTotalMemCnt() {
		return brandTotalMemCnt;
	}
	public void setBrandTotalMemCnt(Integer brandTotalMemCnt) {
		this.brandTotalMemCnt = brandTotalMemCnt;
	}
	public Integer getBrandNewMemCnt() {
		return brandNewMemCnt;
	}
	public void setBrandNewMemCnt(Integer brandNewMemCnt) {
		this.brandNewMemCnt = brandNewMemCnt;
	}
	public Integer getBrandCustomerCnt() {
		return brandCustomerCnt;
	}
	public void setBrandCustomerCnt(Integer brandCustomerCnt) {
		this.brandCustomerCnt = brandCustomerCnt;
	}
	public ArrayList<TuiBarChartSeriesDto> getShopGenderChart() {
		return shopGenderChart;
	}
	public void setShopGenderChart(ArrayList<TuiBarChartSeriesDto> shopGenderChart) {
		this.shopGenderChart = shopGenderChart;
	}
	public ArrayList<TuiBarChartSeriesDto> getBrandGenderChart() {
		return brandGenderChart;
	}
	public void setBrandGenderChart(ArrayList<TuiBarChartSeriesDto> brandGenderChart) {
		this.brandGenderChart = brandGenderChart;
	}
	public BigInteger getShopTotalSales() {
		return shopTotalSales;
	}
	public void setShopTotalSales(BigInteger shopTotalSales) {
		this.shopTotalSales = shopTotalSales;
	}
	public BigInteger getBrandTotalSales() {
		return brandTotalSales;
	}
	public void setBrandTotalSales(BigInteger brandTotalSales) {
		this.brandTotalSales = brandTotalSales;
	}
	public ArrayList<TuiAgeChartSeriesDto> getShopAgeChart() {
		return shopAgeChart;
	}
	public void setShopAgeChart(ArrayList<TuiAgeChartSeriesDto> shopAgeChart) {
		this.shopAgeChart = shopAgeChart;
	}
	public ArrayList<TuiAgeChartSeriesDto> getBrandAgeChart() {
		return brandAgeChart;
	}
	public void setBrandAgeChart(ArrayList<TuiAgeChartSeriesDto> brandAgeChart) {
		this.brandAgeChart = brandAgeChart;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getShopGenderGrid() {
		return shopGenderGrid;
	}
	public void setShopGenderGrid(ArrayList<TuiMbrCompareGridDataDto> shopGenderGrid) {
		this.shopGenderGrid = shopGenderGrid;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getBrandGenderGrid() {
		return brandGenderGrid;
	}
	public void setBrandGenderGrid(ArrayList<TuiMbrCompareGridDataDto> brandGenderGrid) {
		this.brandGenderGrid = brandGenderGrid;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getShopAgeGrid() {
		return shopAgeGrid;
	}
	public void setShopAgeGrid(ArrayList<TuiMbrCompareGridDataDto> shopAgeGrid) {
		this.shopAgeGrid = shopAgeGrid;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getBrandAgeGrid() {
		return brandAgeGrid;
	}
	public void setBrandAgeGrid(ArrayList<TuiMbrCompareGridDataDto> brandAgeGrid) {
		this.brandAgeGrid = brandAgeGrid;
	}
	public float getShopNonMemSales() {
		return shopNonMemSales;
	}
	public void setShopNonMemSales(float shopNonMemSales) {
		this.shopNonMemSales = shopNonMemSales;
	}
	public float getBrandNonMemSales() {
		return brandNonMemSales;
	}
	public void setBrandNonMemSales(float brandNonMemSales) {
		this.brandNonMemSales = brandNonMemSales;
	}
	public float getShopAverageCnt() {
		return shopAverageCnt;
	}
	public void setShopAverageCnt(float shopAverageCnt) {
		this.shopAverageCnt = shopAverageCnt;
	}
	public Integer getShopAveragePrice() {
		return shopAveragePrice;
	}
	public void setShopAveragePrice(Integer shopAveragePrice) {
		this.shopAveragePrice = shopAveragePrice;
	}
	public float getBrandAverageCnt() {
		return brandAverageCnt;
	}
	public void setBrandAverageCnt(float brandAverageCnt) {
		this.brandAverageCnt = brandAverageCnt;
	}
	public Integer getBrandAveragePrice() {
		return brandAveragePrice;
	}
	public void setBrandAveragePrice(Integer brandAveragePrice) {
		this.brandAveragePrice = brandAveragePrice;
	}

}
