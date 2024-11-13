package com.icignal.marketing.storeReport.dto.response;

import java.util.ArrayList;

public class MktDurationCompareResDto {
	private ArrayList<TuiBarChartSeriesDto> durCmpPieChart;
	private ArrayList<TuiAgeChartSeriesDto> durCmpAgeChart;
	
	private ArrayList<TuiDurationCompareGridDataDto> durCmpPurTotalGrid;
	private ArrayList<TuiDurationCompareGridDataDto> durCmpPurMbrGrid;
	private ArrayList<TuiDurationCompareGridDataDto> durCmpTopItemGrid;
	private ArrayList<TuiDurationCompareGridDataDto> durCmpTopProductGrid;

	public ArrayList<TuiBarChartSeriesDto> getDurCmpPieChart() {
		return durCmpPieChart;
	}

	public void setDurCmpPieChart(ArrayList<TuiBarChartSeriesDto> durCmpPieChart) {
		this.durCmpPieChart = durCmpPieChart;
	}

	public ArrayList<TuiAgeChartSeriesDto> getDurCmpAgeChart() {
		return durCmpAgeChart;
	}

	public void setDurCmpAgeChart(ArrayList<TuiAgeChartSeriesDto> durCmpAgeChart) {
		this.durCmpAgeChart = durCmpAgeChart;
	}

	public ArrayList<TuiDurationCompareGridDataDto> getDurCmpPurTotalGrid() {
		return durCmpPurTotalGrid;
	}

	public void setDurCmpPurTotalGrid(ArrayList<TuiDurationCompareGridDataDto> durCmpPurTotalGrid) {
		this.durCmpPurTotalGrid = durCmpPurTotalGrid;
	}

	public ArrayList<TuiDurationCompareGridDataDto> getDurCmpPurMbrGrid() {
		return durCmpPurMbrGrid;
	}

	public void setDurCmpPurMbrGrid(ArrayList<TuiDurationCompareGridDataDto> durCmpPurMbrGrid) {
		this.durCmpPurMbrGrid = durCmpPurMbrGrid;
	}

	public ArrayList<TuiDurationCompareGridDataDto> getDurCmpTopItemGrid() {
		return durCmpTopItemGrid;
	}

	public void setDurCmpTopItemGrid(ArrayList<TuiDurationCompareGridDataDto> durCmpTopItemGrid) {
		this.durCmpTopItemGrid = durCmpTopItemGrid;
	}

	public ArrayList<TuiDurationCompareGridDataDto> getDurCmpTopProductGrid() {
		return durCmpTopProductGrid;
	}

	public void setDurCmpTopProductGrid(ArrayList<TuiDurationCompareGridDataDto> durCmpTopProductGrid) {
		this.durCmpTopProductGrid = durCmpTopProductGrid;
	}
}
