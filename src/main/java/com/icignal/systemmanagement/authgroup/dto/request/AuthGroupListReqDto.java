package com.icignal.systemmanagement.authgroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class AuthGroupListReqDto extends CommonDataAuthReqDto {
	
	private String storeId;
	private String rid;
	private String id;

	
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
