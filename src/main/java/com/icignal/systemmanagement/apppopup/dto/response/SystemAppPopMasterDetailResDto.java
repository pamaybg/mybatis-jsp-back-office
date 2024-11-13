package com.icignal.systemmanagement.apppopup.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemAppPopMasterDetailResDto extends StatusResDto {
	
	private String appPopStatus;
	private String appPopMasterName;
	private String openDate;
	private String openTime;
	private String endDate;
	private String endTime;
	
	
	public String getAppPopStatus() {
		return appPopStatus;
	}
	public void setAppPopStatus(String appPopStatus) {
		this.appPopStatus = appPopStatus;
	}
	public String getAppPopMasterName() {
		return appPopMasterName;
	}
	public void setAppPopMasterName(String appPopMasterName) {
		this.appPopMasterName = appPopMasterName;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getOpenTime() {
		return openTime;
	}
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	
}
