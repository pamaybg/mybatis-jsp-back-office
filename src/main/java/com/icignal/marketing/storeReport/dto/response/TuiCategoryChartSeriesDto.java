package com.icignal.marketing.storeReport.dto.response;

public class TuiCategoryChartSeriesDto {
	
	private String name;
	/*
	 * private Integer[] data = new Integer[3];
	 * 
	 * private Integer data1; private Integer data2; private Integer data3;
	 */
	
	private Integer data;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getData() {
		return data;
	}
	public void setData(Integer data) {
		this.data = data;
	}
	/*
	public Integer[] getData() {
		data[0] = this.data1;
		data[1] = this.data2;
		data[2] = this.data3;
		return data;
	}
	public void setData(Integer[] data) {
		this.data = data;
	}
	
	public void setData1(Integer data1) {
		this.data1 = data1;
	}
	public void setData2(Integer data2) {
		this.data2 = data2;
	}
	public void setData3(Integer data3) {
		this.data3 = data3;
	}
	*/
	
}
