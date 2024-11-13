package com.icignal.systemmanagement.channel.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class SystemSnsAdtnInfoReqDto extends MKTGridPagingReqDto {
	
	private String mktChlId;
	private String id;
	
	
	public String getMktChlId() {
		return mktChlId;
	}
	public void setMktChlId(String mktChlId) {
		this.mktChlId = mktChlId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
