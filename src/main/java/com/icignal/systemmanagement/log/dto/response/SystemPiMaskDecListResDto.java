package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemPiMaskDecListResDto extends GridPagingItemResDto{

	private String createDate;
	private String pageInfo;
	private String name;
	private String infoType;
	private String rid;
	private String reason;
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPageInfo() {
		return pageInfo;
	}
	public void setPageInfo(String pageInfo) {
		this.pageInfo = pageInfo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfoType() {
		return infoType;
	}
	public void setInfoType(String infoType) {
		this.infoType = infoType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}

	
	
}
