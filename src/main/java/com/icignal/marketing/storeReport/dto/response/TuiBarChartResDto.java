package com.icignal.marketing.storeReport.dto.response;

import java.util.ArrayList;

public class TuiBarChartResDto {
	
	private String[] categories = new String[1];
	private ArrayList<TuiBarChartSeriesDto> series;
	
	public String[] getCategories() {
		return categories;
	}
	public void setCategories(String[] categories) {
		this.categories = categories;
	}
	public ArrayList<TuiBarChartSeriesDto> getSeries() {
		return series;
	}
	public void setSeries(ArrayList<TuiBarChartSeriesDto> series) {
		this.series = series;
	}

}
