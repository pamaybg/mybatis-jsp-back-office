package com.icignal.marketing.storeReport.dto.response;

public class TuiBarChartSeriesDto {
	
	private String name;
	private float data;
	private String stackGroup;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStackGroup() {
		return stackGroup;
	}
	public void setStackGroup(String stackGroup) {
		this.stackGroup = stackGroup;
	}
	public float getData() {return data;}
	public void setData(float data) {
		this.data = data;
	}
}
