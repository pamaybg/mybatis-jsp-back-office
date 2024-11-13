package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyTransAddInfoReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String defaultArchive;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	* @return the defaultArchive
	*/
	public String getDefaultArchive() {
		return defaultArchive;
	}

	/**
	* @param defaultArchive the defaultArchive to set
	*/
	public void setDefaultArchive(String defaultArchive) {
		this.defaultArchive = defaultArchive;
	}
	
	
	
}
