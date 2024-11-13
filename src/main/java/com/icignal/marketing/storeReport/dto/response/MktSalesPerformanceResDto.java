package com.icignal.marketing.storeReport.dto.response;

public class MktSalesPerformanceResDto {
	
	private String mbrTear;

	private String cntMbr;
	private String salAmt;

	private String cntMbr1;
	private String salAmt1;
	
	private String cntMbr2;
	private String salAmt2;
	private String cntMbr3;
	private String salAmt3;
	
	private float iCntMbr2;
	private float iSalAmt2;
	private float iCntMbr3;
	private float iSalAmt3;
	
	//전년
	private String cntMbr0;
	private String salAmt0;
	
	public String getMbrTear() {
		return mbrTear;
	}
	public void setMbrTear(String mbrTear) {
		this.mbrTear = mbrTear;
	}
	public String getCntMbr() {
		return cntMbr;
	}
	public void setCntMbr(String cntMbr) {
		this.cntMbr = cntMbr;
	}
	public String getSalAmt() {
		return salAmt;
	}
	public void setSalAmt(String salAmt) {
		this.salAmt = salAmt;
	}
	public String getCntMbr1() {
		return cntMbr1;
	}
	public void setCntMbr1(String cntMbr1) {
		this.cntMbr1 = cntMbr1;
	}
	public String getSalAmt1() {
		return salAmt1;
	}
	public void setSalAmt1(String salAmt1) {
		this.salAmt1 = salAmt1;
	}
	public String getCntMbr2() {
		return String.valueOf(this.iCntMbr2)  + '%';
	}
	public String getSalAmt2() {
		return String.valueOf(this.iSalAmt2)  + '%';
	}
	public String getCntMbr3() {
		return String.valueOf(this.iCntMbr3)  + '%';
	}
	public String getSalAmt3() {
		return String.valueOf(this.iSalAmt3)  + '%';
	}

	public void setSalAmt3(String salAmt3) {
		this.salAmt3 = salAmt3;
	}
	public void setiCntMbr2(float iCntMbr2) {
		this.iCntMbr2 = iCntMbr2;
	}
	public void setiSalAmt2(float iSalAmt2) {
		this.iSalAmt2 = iSalAmt2;
	}
	public void setiCntMbr3(float iCntMbr3) {
		this.iCntMbr3 = iCntMbr3;
	}
	public void setiSalAmt3(float iSalAmt3) {
		this.iSalAmt3 = iSalAmt3;
	}
	public String getCntMbr0() {
		return cntMbr0;
	}
	public void setCntMbr0(String cntMbr0) {
		this.cntMbr0 = cntMbr0;
	}
	public String getSalAmt0() {
		return salAmt0;
	}
	public void setSalAmt0(String salAmt0) {
		this.salAmt0 = salAmt0;
	}
}
