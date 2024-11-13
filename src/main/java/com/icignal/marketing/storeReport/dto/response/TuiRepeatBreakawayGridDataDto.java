package com.icignal.marketing.storeReport.dto.response;

public class TuiRepeatBreakawayGridDataDto {
	
	private String mbrTier;
	private String cntMbr1;
	private String salRatio1;
	private String cntMbr2;
	private String salRatio2;
	private String cntMbr3;
	private String salRatio3;
	
	private float iSalRatio1;
	private float iSalRatio2;
	private float iSalRatio3;
	
	public String getMbrTier() {
		return mbrTier;
	}
	public void setMbrTier(String mbrTier) {
		this.mbrTier = mbrTier;
	}
	public String getCntMbr1() {
		return cntMbr1;
	}
	public void setCntMbr1(String cntMbr1) {
		this.cntMbr1 = cntMbr1;
	}
	public String getSalRatio1() {
		return String.valueOf(this.iSalRatio1)  + '%';
	}
	public String getCntMbr2() {
		return cntMbr2;
	}
	public void setCntMbr2(String cntMbr2) {
		this.cntMbr2 = cntMbr2;
	}
	public String getSalRatio2() {
		return String.valueOf(this.iSalRatio2)  + '%';
	}
	public String getCntMbr3() {
		return cntMbr3;
	}
	public void setCntMbr3(String cntMbr3) {
		this.cntMbr3 = cntMbr3;
	}
	public String getSalRatio3() {
		return String.valueOf(this.iSalRatio3)  + '%';
	}

	public void setiSalRatio1(float iSalRatio1) {
		this.iSalRatio1 = iSalRatio1;
	}
	public void setiSalRatio2(float iSalRatio2) {
		this.iSalRatio2 = iSalRatio2;
	}
	public void setiSalRatio3(float iSalRatio3) {
		this.iSalRatio3 = iSalRatio3;
	}

}
