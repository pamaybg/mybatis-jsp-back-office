package com.icignal.marketing.storeReport.dto.response;

import java.util.ArrayList;

public class MktRepeatBreakawayResDto {
	
	private String repeatCnt;
	private String repeatRate;
	private String customerChurnCnt;
	
	private ArrayList<TuiBarChartSeriesDto> gradeChart;
	private ArrayList<TuiAgeChartSeriesDto> ageChart;
	
	private ArrayList<TuiMbrCompareGridDataDto> genderGrid;
	private ArrayList<TuiMbrCompareGridDataDto> ageGrid;
	
	private ArrayList<TuiRepeatBreakawayGridDataDto> breakawayGrid;
	
	public String getRepeatCnt() {
		return repeatCnt;
	}
	public void setRepeatCnt(String repeatCnt) {
		this.repeatCnt = repeatCnt;
	}
	public String getRepeatRate() {
		return repeatRate;
	}
	public void setRepeatRate(String repeatRate) {
		this.repeatRate = repeatRate;
	}
	public String getCustomerChurnCnt() {
		return customerChurnCnt;
	}
	public void setCustomerChurnCnt(String customerChurnCnt) {
		this.customerChurnCnt = customerChurnCnt;
	}
	public ArrayList<TuiBarChartSeriesDto> getGradeChart() {
		return gradeChart;
	}
	public void setGradeChart(ArrayList<TuiBarChartSeriesDto> gradeChart) {
		this.gradeChart = gradeChart;
	}
	public ArrayList<TuiAgeChartSeriesDto> getAgeChart() {
		return ageChart;
	}
	public void setAgeChart(ArrayList<TuiAgeChartSeriesDto> ageChart) {
		this.ageChart = ageChart;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getGenderGrid() {
		return genderGrid;
	}
	public void setGenderGrid(ArrayList<TuiMbrCompareGridDataDto> genderGrid) {
		this.genderGrid = genderGrid;
	}
	public ArrayList<TuiMbrCompareGridDataDto> getAgeGrid() {
		return ageGrid;
	}
	public void setAgeGrid(ArrayList<TuiMbrCompareGridDataDto> ageGrid) {
		this.ageGrid = ageGrid;
	}
	public ArrayList<TuiRepeatBreakawayGridDataDto> getBreakawayGrid() {
		return breakawayGrid;
	}
	public void setBreakawayGrid(ArrayList<TuiRepeatBreakawayGridDataDto> breakawayGrid) {
		this.breakawayGrid = breakawayGrid;
	}

}
