package com.icignal.marketing.storeReport.dto.response;

public class MktStoreReportResDto {
	
	private String brandCode;
	private String brandName;
	private String ridBrand;

	public String getRidBrand() {return ridBrand;}

	public void setRidBrand(String ridBrand) {this.ridBrand = ridBrand;}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

}
