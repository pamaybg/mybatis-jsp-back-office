package com.icignal.marketing.storeReport.dto.response;

import java.math.BigInteger;

public class TuiStackBarChartSeriesDto {
	
	private String name;
	private String stackGroup;
	private String category;
	private BigInteger[] data = new BigInteger[12];
	
	private BigInteger data1;
	private BigInteger data2;
	private BigInteger data3;
	private BigInteger data4;
	private BigInteger data5;
	private BigInteger data6;
	private BigInteger data7;
	private BigInteger data8;
	private BigInteger data9;
	private BigInteger data10;
	private BigInteger data11;
	private BigInteger data12;

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
	public String getCategory() {return category;}
	public void setCategory(String category) {this.category = category;}

	public BigInteger[] getData() {
		data[0] = this.data1;
		data[1] = this.data2;
		data[2] = this.data3;
		data[3] = this.data4;
		data[4] = this.data5;
		data[5] = this.data6;
		data[6] = this.data7;
		data[7] = this.data8;
		data[8] = this.data9;
		data[9] = this.data10;
		data[10] = this.data11;
		data[11] = this.data12;
		return data;
	}
	public void setData(BigInteger[] data) {
		this.data = data;
	}
	public void setData1(BigInteger data1) {
		this.data1 = data1;
	}
	public void setData2(BigInteger data2) {
		this.data2 = data2;
	}
	public void setData3(BigInteger data3) {
		this.data3 = data3;
	}
	public void setData4(BigInteger data4) {
		this.data4 = data4;
	}
	public void setData5(BigInteger data5) {
		this.data5 = data5;
	}
	public void setData6(BigInteger data6) {
		this.data6 = data6;
	}
	public void setData7(BigInteger data7) {
		this.data7 = data7;
	}
	public void setData8(BigInteger data8) {
		this.data8 = data8;
	}
	public void setData9(BigInteger data9) {
		this.data9 = data9;
	}
	public void setData10(BigInteger data10) {
		this.data10 = data10;
	}
	public void setData11(BigInteger data11) {
		this.data11 = data11;
	}
	public void setData12(BigInteger data12) {
		this.data12 = data12;
	}
	
}
