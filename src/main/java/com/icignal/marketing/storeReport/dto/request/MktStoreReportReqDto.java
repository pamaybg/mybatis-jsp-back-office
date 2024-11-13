package com.icignal.marketing.storeReport.dto.request;

public class MktStoreReportReqDto {
	
	private String empId;
	private String shopCode;
	private String brandCode;
	private String startDate;
	private String endDate;
	private String cmpStartDate;
	private String cmpEndDate;
	private String type;
	private String gender;
	private String[] ageGroupCode;
	private Integer shopCnt = 0;
	private String mbrDiv;
	//상품군 비교 
	private String productClass;
	
	private String year;
	private String month;
	
	private String[] membershipLevelCode;
	
	private String[] proCode;
	private String[] clubCode;
	
	private String[] martType;
	private String[] regionType;
	private String shopTypeCode;
	
	private String itemCode;
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public String getShopCode() {
		return shopCode;
	}

	public void setShopCode(String shopCode) {
		this.shopCode = shopCode;
	}

	public String getEndDate() {return endDate;}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getShopCnt() {
		return shopCnt;
	}

	public void setShopCnt(Integer shopCnt) {
		this.shopCnt = shopCnt;
	}

	public String getMbrDiv() {
		return mbrDiv;
	}

	public void setMbrDiv(String mbrDiv) {
		this.mbrDiv = mbrDiv;
	}

	public String getGender() {return gender;}

	public void setGender(String gender) {this.gender = gender;}

	public String getProductClass() {
		return productClass;
	}

	public void setProductClass(String productClass) {
		this.productClass = productClass;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String[] getMembershipLevelCode() {
		return membershipLevelCode;
	}

	public void setMembershipLevelCode(String[] membershipLevelCode) {
		this.membershipLevelCode = membershipLevelCode;
	}

	public String[] getAgeGroupCode() {
		return ageGroupCode;
	}

	public void setAgeGroupCode(String[] ageGroupCode) {
		this.ageGroupCode = ageGroupCode;
	}

	public String[] getClubCode() {
		return clubCode;
	}

	public void setClubCode(String[] clubCode) {
		this.clubCode = clubCode;
	}

	public String[] getProCode() {
		return proCode;
	}

	public void setProCode(String[] proCode) {
		this.proCode = proCode;
	}

	public String[] getMartType() {
		return martType;
	}

	public void setMartType(String[] martType) {
		this.martType = martType;
	}

	public String[] getRegionType() {
		return regionType;
	}

	public void setRegionType(String[] regionType) {
		this.regionType = regionType;
	}

	public String getShopTypeCode() {
		return shopTypeCode;
	}

	public void setShopTypeCode(String shopTypeCode) {
		this.shopTypeCode = shopTypeCode;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getCmpStartDate() {
		return cmpStartDate;
	}

	public void setCmpStartDate(String cmpStartDate) {
		this.cmpStartDate = cmpStartDate;
	}

	public String getCmpEndDate() {
		return cmpEndDate;
	}

	public void setCmpEndDate(String cmpEndDate) {
		this.cmpEndDate = cmpEndDate;
	}
}

