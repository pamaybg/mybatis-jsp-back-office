package com.icignal.marketing.storeReport.dto.response;

public class TuiAgeChartSeriesDto {
	
	private String name;
	private Integer[] data = new Integer[10];
	private String stackGroup;
	
	private Integer age_19;
	private Integer age_20;
	private Integer age_25;
	private Integer age_30;
	private Integer age_35;
	private Integer age_40;
	private Integer age_45;
	private Integer age_50;
	private Integer age_55;
	private Integer age_60;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setStackGroup(String stackGroup) {
		this.stackGroup = stackGroup;
	}	
	public String getStackGroup() {
		return stackGroup;
	}
	public Integer[] getData() {
		data[0] = this.age_19;
		data[1] = this.age_20;
		data[2] = this.age_25;
		data[3] = this.age_30;
		data[4] = this.age_35;
		data[5] = this.age_40;
		data[6] = this.age_45;
		data[7] = this.age_50;
		data[8] = this.age_55;
		data[9] = this.age_60;
		return data;
	}
	public void setData(Integer[] data) {
		this.data = data;
	}
	
	public void setAge_19(Integer age_19) {
		this.age_19 = age_19;
	}
	public void setAge_20(Integer age_20) {
		this.age_20 = age_20;
	}
	public void setAge_25(Integer age_25) {
		this.age_25 = age_25;
	}
	public void setAge_30(Integer age_30) {
		this.age_30 = age_30;
	}
	public void setAge_35(Integer age_35) {
		this.age_35 = age_35;
	}
	public void setAge_40(Integer age_40) {
		this.age_40 = age_40;
	}
	public void setAge_45(Integer age_45) {
		this.age_45 = age_45;
	}
	public void setAge_50(Integer age_50) {
		this.age_50 = age_50;
	}
	public void setAge_55(Integer age_55) {
		this.age_55 = age_55;
	}
	public void setAge_60(Integer age_60) {
		this.age_60 = age_60;
	}

}
