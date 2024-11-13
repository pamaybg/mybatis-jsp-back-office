package com.icignal.marketing.storeReport.dto.response;

public class TuiMbrCompareGridDataDto {
	
	private String colNm;
	private String total;
	private String vip;
	private String aGrade;
	private String bGrade;
	private String cGrade;
	
	private float iTotal;
	private float iVip;
	private float iAGrade;
	private float iBGrade;
	private float iCGrade;	
	
	public String getColNm() {
		return colNm;
	}
	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
	public String getTotal() {
		return String.valueOf(this.iTotal)  + '%';
	}
	public String getVip() {
		return String.valueOf(this.iVip)  + '%';
	}
	public String getaGrade() {
		return String.valueOf(this.iAGrade)  + '%';
	}
	public String getbGrade() {
		return String.valueOf(this.iBGrade)  + '%';
	}
	public String getcGrade() {
		return String.valueOf(this.iCGrade)  + '%';
	}	
	
	public void setiTotal(float iTotal) {
		this.iTotal = iTotal;
	}
	public void setiVip(float iVip) {
		this.iVip = iVip;
	}
	public void setiAGrade(float iAGrade) {
		this.iAGrade = iAGrade;
	}
	public void setiBGrade(float iBGrade) {
		this.iBGrade = iBGrade;
	}
	public void setiCGrade(float iCGrade) {
		this.iCGrade = iCGrade;
	}

}
