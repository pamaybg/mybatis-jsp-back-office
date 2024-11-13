package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class AuthListReqDto extends MKTGridPagingReqDto {
	private String storeId;
	private String pgmId;
	private String uiObjId;
	private String id;
	
	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getPgmId() {
		return pgmId;
	}

	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}

	public String getUiObjId() {
		return uiObjId;
	}

	public void setUiObjId(String uiObjId) {
		this.uiObjId = uiObjId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	

}
