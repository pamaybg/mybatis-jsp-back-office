package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyMbrPointLimitListResDto extends GridPagingItemResDto {
	private String createDate;
	private String createById;
	private String createBy;
	private String bchngData;
	private String achngData;
	private String chgPstn;
	private String rmark;
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateById() {
		return createById;
	}
	public void setCreateById(String createById) {
		this.createById = createById;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getBchngData() {
		return bchngData;
	}
	public void setBchngData(String bchngData) {
		this.bchngData = bchngData;
	}
	public String getAchngData() {
		return achngData;
	}
	public void setAchngData(String achngData) {
		this.achngData = achngData;
	}
	public String getChgPstn() {
		return chgPstn;
	}
	public void setChgPstn(String chgPstn) {
		this.chgPstn = chgPstn;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	
}
