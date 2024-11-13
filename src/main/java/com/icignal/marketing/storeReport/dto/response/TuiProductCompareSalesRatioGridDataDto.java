package com.icignal.marketing.storeReport.dto.response;

public class TuiProductCompareSalesRatioGridDataDto {
	
	private String productName;
	private String cnt;
	private float iCnt;
	private float sCnt;
	private float bCnt;

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCnt() {
		return String.valueOf(this.sCnt) + "%\n("+ String.valueOf(this.iCnt) + "%)";
	}

	public void setiCnt(float iCnt) {
		this.iCnt = iCnt;
	}


	public void setsCnt(float sCnt) {
		this.sCnt = sCnt;
	}

	public void setbCnt(float bCnt) {
		this.bCnt = bCnt;
	}

}
