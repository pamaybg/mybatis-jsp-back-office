package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SetManageTabReqDto extends MKTBaseReqDto {
	
	private String rid;
	private String tabSort;
	private String tabNm;
	private String tabLinkUrl;
	private String empId;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTabSort() {
		return tabSort;
	}
	public void setTabSort(String tabSort) {
		this.tabSort = tabSort;
	}
	public String getTabNm() {
		return tabNm;
	}
	public void setTabNm(String tabNm) {
		this.tabNm = tabNm;
	}
	public String getTabLinkUrl() {
		return tabLinkUrl;
	}
	public void setTabLinkUrl(String tabLinkUrl) {
		this.tabLinkUrl = tabLinkUrl;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
}
