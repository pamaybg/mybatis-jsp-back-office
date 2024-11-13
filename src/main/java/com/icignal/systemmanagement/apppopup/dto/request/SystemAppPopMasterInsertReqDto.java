package com.icignal.systemmanagement.apppopup.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class SystemAppPopMasterInsertReqDto extends CommonCondReqDto {
	
	private String openDate;
	private String endDate;
	private String appPopMasterTitle;
	private String appPopType;
	private Boolean updateFlag;
	
	private String	appPopId; 
	
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAppPopMasterTitle() {
		return appPopMasterTitle;
	}
	public void setAppPopMasterTitle(String appPopMasterTitle) {
		this.appPopMasterTitle = appPopMasterTitle;
	}
	public String getAppPopType() {
		return appPopType;
	}
	public void setAppPopType(String appPopType) {
		this.appPopType = appPopType;
	}
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
	public String getAppPopId() {
		return appPopId;
	}
	public void setAppPopId(String appPopId) {
		this.appPopId = appPopId;
	}

}
