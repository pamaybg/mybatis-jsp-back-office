package com.icignal.marketing.campaignhome.dto.response;

public class CampignCustTypeCdResDto {
	private String countsI;   //개인
	private String countsC;  //법인
	private String countsE;  //임직원
	private String countsX;  //임원
	private String countsO;  //매장직원

	public String getCountsI() {
		return countsI;
	}
	public void setCountsI(String countsI) {
		this.countsI = countsI;
	}
	public String getCountsC() {
		return countsC;
	}
	public void setCountsC(String countsC) {
		this.countsC = countsC;
	}
	public String getCountsE() {
		return countsE;
	}
	public void setCountsE(String countsE) {
		this.countsE = countsE;
	}

	public String getCountsX() {
		return countsX;
	}

	public void setCountsX(String countsX) {
		this.countsX = countsX;
	}

	public String getCountsO() {
		return countsO;
	}

	public void setCountsO(String countsO) {
		this.countsO = countsO;
	}
}
