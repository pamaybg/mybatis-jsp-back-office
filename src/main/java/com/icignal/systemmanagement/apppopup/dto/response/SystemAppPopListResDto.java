package com.icignal.systemmanagement.apppopup.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class SystemAppPopListResDto extends GridPagingItemResDto {

	private String rid;
	private String appPopLang;
	private String appPopTitle;
	private String appPopWriter;
	private String createDate;
	private String startDate;
	private String endDate;
	private String appPopStatus;
	private String appPopType;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAppPopLang() {
		return appPopLang;
	}
	public void setAppPopLang(String appPopLang) {
		this.appPopLang = appPopLang;
	}
	public String getAppPopTitle() {
		return appPopTitle;
	}
	public void setAppPopTitle(String appPopTitle) {
		this.appPopTitle = appPopTitle;
	}
	public String getAppPopWriter() {
		return appPopWriter;
	}
	public void setAppPopWriter(String appPopWriter) {
		this.appPopWriter = appPopWriter;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAppPopStatus() {
		return appPopStatus;
	}
	public void setAppPopStatus(String appPopStatus) {
		this.appPopStatus = appPopStatus;
	}
	public String getAppPopType() {
		return appPopType;
	}
	public void setAppPopType(String appPopType) {
		this.appPopType = appPopType;
	}
	
	
}
